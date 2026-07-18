# Extraction Snippets — Live-DOM Brand Recon

Reference for Phase 1 of `haazel-build` (recon on an existing domain) and the
`haazel-brand-analyzer` skill. The goal is the TRUE brand — the palette ranked
by actual usage, not what looks right at a glance, the fonts actually
shipping, the real nav/contact/social footprint. Never settle for a guess
when the tools below can measure it.

## Detection ladder

Try each tier in order; stop at the first that's available. Record which tier
was actually used in `extraction.json`'s `confidence` field — later phases
need to know how much to trust the extraction.

1. **Claude Browser pane tools** (`mcp__Claude_Browser__*`) — first choice.
   Full JS execution against the live page: real computed styles, real
   `getComputedStyle()` color/font frequency, screenshots at any viewport.
   `confidence: "high"`.
2. **claude-in-chrome** — the same JS-execution capability, routed through
   the user's own Chrome instead. Use when the Browser pane isn't available,
   or the target needs the user's logged-in session (gated content, a
   staging site behind auth). `confidence: "high"`.
3. **WebFetch — degraded** — static HTML only, no JS execution. No computed
   styles (a JS-heavy SPA may render nothing at all), no screenshots, no true
   color/font frequency — only what regex/parsing can pull from raw HTML and
   any inline/linked CSS source. Use only when neither browser tool is
   available. `confidence: "low"` — say so in the output, and say so to the
   user at Gate 1. Don't present a WebFetch guess with the same authority as
   a real DOM measurement.

Never settle for a quick WebFetch when a browser tool exists — that's the
exact mistake this ladder exists to prevent.

## Snippets

Run these as JS execution against the live, fully-loaded page (navigate, wait
~4–5s for render — many sites are SPA-heavy — then run).

### Color frequency

The most-used background color IS the brand background; the most-used text
color IS the brand foreground; the color on buttons/links IS the accent. Rank
by count, don't eyeball it.

```javascript
const colorCount = {};
document.querySelectorAll('*').forEach(el => {
  const style = getComputedStyle(el);
  ['backgroundColor', 'color', 'borderColor'].forEach(prop => {
    const val = style[prop];
    if (val && val !== 'rgba(0, 0, 0, 0)' && val !== 'transparent') {
      colorCount[val] = (colorCount[val] || 0) + 1;
    }
  });
});
const sorted = Object.entries(colorCount).sort((a, b) => b[1] - a[1]);
JSON.stringify(sorted.slice(0, 20));
```

### Font stacks

```javascript
const fontCount = {};
document.querySelectorAll('*').forEach(el => {
  const ff = getComputedStyle(el).fontFamily;
  if (ff) fontCount[ff] = (fontCount[ff] || 0) + 1;
});
const fontsSorted = Object.entries(fontCount).sort((a, b) => b[1] - a[1]);
JSON.stringify(fontsSorted.slice(0, 10));
```

### Logo, favicon, OG image

Logo candidates first — download it if it's an image URL, extract the raw
markup if it's inline SVG:

```javascript
const logos = [...document.querySelectorAll('img, svg')]
  .filter(el => {
    const src = el.src || el.getAttribute('src') || '';
    const cls = el.className || '';
    const alt = el.alt || '';
    return /logo|brand|header/i.test(src + cls + alt);
  })
  .map(el => ({ tag: el.tagName, src: el.src, alt: el.alt, width: el.width }));
JSON.stringify(logos);
```

Favicon and OG image are two `<meta>`/`<link>` reads, not a DOM scrape:

```javascript
const favicon = document.querySelector(
  'link[rel="icon"], link[rel="shortcut icon"]'
)?.href;
const ogImage = document.querySelector('meta[property="og:image"]')?.content;
JSON.stringify({ favicon, ogImage });
```

### Nav, socials, contacts

```javascript
const navLinks = [...document.querySelectorAll('nav a, header a')]
  .map(a => ({ text: a.textContent?.trim(), href: a.href }));

const socials = [...document.querySelectorAll(
  'a[href*="instagram"], a[href*="tiktok"], a[href*="facebook"], ' +
  'a[href*="linkedin"], a[href*="twitter"], a[href*="x.com"]'
)].map(a => ({ href: a.href }));

// NANP phone format — adjust the pattern for non-North-American numbers
const phones = document.body.textContent.match(
  /\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}/g
);

const emails = document.body.textContent.match(/[\w.-]+@[\w.-]+\.\w{2,}/g);

JSON.stringify({ navLinks, socials, phones, emails });
```

## Screenshot checklist

Capture alongside the JS extraction, not instead of it — colors and copy need
the DOM, imagery direction needs the eye:

- Homepage, above the fold
- Homepage, scrolled to a representative middle section
- About page (if it exists)
- Menu/services/product page (if it exists)
- One inner page relevant to the archetype (pricing for saas, a service page
  for leadgen, a product page for commerce)
- While looking, note the imagery style: dark/moody vs bright/airy, close-up
  vs wide environment shots, candid vs staged, color grading, custom
  photography vs stock

## `extraction.json` output shape

```json
{
  "colors": [
    { "value": "#060416", "count": 4200, "roleGuess": "background" },
    { "value": "#EED8C3", "count": 3719, "roleGuess": "primary" },
    { "value": "#D72626", "count": 21, "roleGuess": "accent" }
  ],
  "fonts": [
    { "family": "\"nocturne-serif\", serif", "count": 3400, "roleGuess": "display" },
    { "family": "\"Clarkson\", sans-serif", "count": 2800, "roleGuess": "body" }
  ],
  "logo": { "type": "svg | image", "src": "string | null", "markup": "string | null" },
  "favicon": "string | null",
  "ogImage": "string | null",
  "nav": [{ "text": "string", "href": "string" }],
  "contacts": { "phones": ["string"], "emails": ["string"], "address": "string | null" },
  "socials": [{ "platform": "string", "href": "string" }],
  "screenshots": [{ "label": "string", "path": "string" }],
  "confidence": "high | low"
}
```

`roleGuess` is exactly that — a guess, ranked by frequency. Gate 1 exists to
correct it before it becomes the design foundation; never skip straight from
extraction to `tokens.json` without the user confirming the read.
