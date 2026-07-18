---
name: haazel-brand-analyzer
description: Extract brand elements from any domain — colors ranked by computed-style frequency, font stacks, logo, nav map, voice read, imagery read — into design/extraction.json (machine data) and design/BRAND_BRIEF.md (the interpreted brief: what the brand IS vs. what the old site merely looks like). Trigger on "analyze <domain>", "brand extraction", "what's this site's brand", or /haazel-brand-analyzer. Also the extraction contract behind Phase 1 (Recon) of haazel-build.
---

# Haazel Brand Analyzer — the extraction contract

You turn a live domain into structured, evidence-backed brand data. Use this
skill standalone ("analyze acme.com"), or as the contract Phase 1 (Recon) of
haazel-build runs against — same method, same two output files, same gate.

The rule that makes this useful: every claim traces to something actually
observed on the page — a color counted 3,719 times is the brand background,
one counted 21 times is an accent, regardless of how either looks at a glance.

## Step 1 — Detection ladder (silent, before touching the domain)

Determine what's actually available, in priority order:

1. **Claude Browser pane tools** — full navigation, computed-style
   JavaScript execution, screenshots. Preferred; use if present.
2. **claude-in-chrome tools** — same capability class, different surface.
   Use when the Browser pane isn't connected.
3. **WebFetch-only degraded mode** — last resort, only when neither browser
   surface exists. Raw HTML/CSS text, no computed styles, no JS-rendered
   content, no screenshots.

Tell the user which tier you're running in before you start. Tier 3 output
is marked `"confidence": "low"` throughout — see Step 5. **Never present a
degraded extraction as if it were a full DOM read.**

## Step 2 — Live-DOM extraction (main thread, tiers 1–2)

Navigate to the domain, wait for full render (many sites are SPA/JS-heavy —
give it 3–5 seconds), then screenshot the homepage and 1–2 inner pages
(about/services) at desktop and mobile widths.

Run the extraction snippets from `references/extraction-snippets.md` — that
file is the method: color-frequency walk, font-family frequency, logo
detection, nav map, contact/social scrape. Execute them as written; do not
recreate them from memory or paste copies into this file or your output —
read the reference and run it.

## Step 3 — Voice + imagery read (main thread, judgment call)

This part isn't scriptable — read it like an editor would:

- **Voice**: headline/body copy — formality, sentence length, POV, active
  vs. passive, the adjectives the brand would use for itself.
- **Imagery**: hero/section photography — style, subject matter, lighting,
  color grade, treatment (rounded corners, shadows, overlays).

Keep this on the main thread with the DOM work. It's interpretation, not
data collection — the two are different jobs and only one delegates.

## Step 4 — Delegate the bulk crawl (parallel with Steps 2–3)

Launch `haazel-scout` (`brand-crawl` mission) for the volume work: full
per-page copy dump, internal/external link map, contact/hours/service
inventory across every page — not just the homepage. It returns structured
facts, never opinions; it cannot see computed styles or render JS the way
browser tools can, so color/font/logo extraction never delegates.

## Step 5 — Fallback: quick WebFetch (last resort only)

Only when Step 1 found no browser tool at all: WebFetch the homepage HTML
and regex for hex/rgb/hsl literals in inline styles and `<style>` blocks,
`font-family` declarations, and `<meta>`/`og:image` tags. This cannot see
cascaded CSS, computed styles, or anything JS-rendered — frequency counts
from raw HTML are unreliable, not just approximate. Mark every field this
tier produces `"confidence": "low"`; never silently upgrade it later.

## Outputs

### `design/extraction.json`

```json
{
  "domain": "example.com",
  "confidence": "high | low",
  "colors": [{ "hex": "#0B0A12", "usageCount": 4200, "role": "background" }],
  "fonts": [{ "family": "Fraunces", "usageCount": 3400, "role": "display" }],
  "logo": { "type": "svg | image", "src": "...", "savedTo": "public/images/logo.svg" },
  "nav": [{ "text": "Menu", "href": "/menu" }],
  "contact": { "phones": [], "emails": [], "socials": [], "address": "" },
  "imagery": { "style": "...", "subjects": [], "lighting": "...", "treatment": "..." },
  "voice": { "tone": [], "sentenceLength": "...", "pov": "..." },
  "screenshots": ["design/raw/home-1440.png", "design/raw/home-375.png"]
}
```

Colors and fonts are arrays **sorted by `usageCount` descending** — rank is
the point, not just presence.

### `design/BRAND_BRIEF.md`

- **What the brand IS** — identity synthesized from evidence: name,
  industry, audience, positioning. A conclusion, not a copy of the homepage.
- **What the old site looks like** — the literal surface observed: palette,
  type, layout, as it exists today. This section may describe things worth
  discarding; say so.
- **Dated vs. loved** — the section that makes the brief useful. Flag stale
  defaults (unstyled link blue, a fallback font firing because a webfont
  failed) separately from real brand equity (a hand-picked color, a
  distinctive wordmark). Downstream phases keep one, discard the other.
- **Open questions** — anything the extraction couldn't resolve; hand these
  to the gate instead of guessing.

## Gate

Present the Brand Extraction Report — colors ranked by usage, fonts, voice
read, imagery read — straight from `extraction.json` and `BRAND_BRIEF.md`.
Ask: "Corrections before this becomes the design foundation?" Gate here even
running standalone; this data feeds real design decisions downstream and
corrections are cheap now, expensive later.

## Rules

- The frequency data is the truth — don't override the ranked palette with
  what "looks right" from a screenshot.
- Never fabricate contact info, socials, or copy that isn't actually on the
  page; a missing fact is reported missing, not invented.
- Confidence propagates: a `"low"`-confidence extraction should make every
  downstream phase visibly cautious, not treated as a full DOM read.
