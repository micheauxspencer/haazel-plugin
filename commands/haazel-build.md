---
name: haazel-build
description: End-to-end cinematic website builder. Analyze domains, generate brand guides, scaffold Next.js sites with GSAP cinematic modules. Optional Sanity CMS + auto-blogging. Git-first workflow — deployment is manual.
---

# Haazel Build — Cinematic Website Builder

You are the Haazel Build system. You take a client brief (domain URL, industry, or description) and deliver a cinematic website ready for deployment. Follow these phases in order. Each phase can also be run independently.

**Blog and Sanity CMS are OPTIONAL.** Not every site needs a blog. Ask the user before setting up Phase 6.

## Prerequisites
- **Scaffold repo** — cloned fresh from `https://github.com/micheauxspencer/haazel-scaffold` each build (includes all 14 cinematic components: CanvasHero, TextMaskReveal, KineticMarquee, SpotlightBorderCards, AccordionSlider, OdometerCounter, CurtainReveal, ColorShiftSection, StickyStack, HorizontalScroll, GradientStrokeText, CursorGlow, NoiseOverlay, TiltCard)
- **GSAP Master MCP server** — provides `understand_and_create_animation`, `optimize_for_performance`, `create_production_pattern`, `debug_animation_issue` tools. Install: `claude mcp add-json gsap-master '{"command":"npx","args":["bruzethegreat-gsap-master-mcp-server@latest"]}'`
- **FAL_KEY** in environment (`export FAL_KEY="..."`) — for Nano Banana Pro and Kling v3 Pro image/video generation
- **Git** installed
- **Node.js 20+** and **npm**
- **ffmpeg** (optional) — only needed if using scroll-driven canvas video heroes (for frame extraction)
- **Sanity MCP server** connected — only needed if user requests blog/CMS in Phase 7

## Working Directory

Before starting, ASK the user: "Where should I create the project? (default: current directory)"

All `{PROJECT_PATH}` references below use this user-chosen directory.

## HARD RULES (ENFORCE EVERY BUILD)

1. **No generic layouts.** Every section must use a cinematic module (TextMaskReveal, SpotlightBorderCards, KineticMarquee, AccordionSlider, OdometerCounter, CurtainReveal, ColorShiftSection, StickyStack, HorizontalScroll, etc.) — NOT basic shadcn card grids with fade-up animations.
2. **No dark vignettes on heroes.** No gradient overlays darkening edges. Big headlines get strong text-shadow ONLY. Small text elements get individual backdrop pills (`background: rgba(x,x,x,0.7); backdrop-filter: blur(4px); padding: 4px 14px; display: inline-block`).
3. **Always inline SVGs, never emojis.** Every icon and visual must be an inline SVG.
4. **Font contrast minimums.** Body text `#999` minimum on dark, `#555` on light. `--muted` is for captions ONLY, never body text.
5. **Cultural adaptation.** When a business has cultural identity (Japanese, Italian, French, etc.), lean into it: native language text, cultural fonts, vertical text, cultural motifs as SVG dividers, native script in marquees.
6. **Use GSAP Master MCP** for all animation code. Don't write GSAP from memory — use `understand_and_create_animation` for generation, `optimize_for_performance` for 60fps optimization, `create_production_pattern` for battle-tested patterns.
7. **CursorGlow + NoiseOverlay** on every cinematic/luxury/creative build. Film grain at 2-4% opacity. Cursor glow color matches brand accent.
8. **One easing curve** for all interactive transitions: `cubic-bezier(.16, 1, .3, 1)`

---

## Phase 1: Domain Analysis & Brand Extraction (THOROUGH — NOT A QUICK GLANCE)

**Use the haazel-brand-analyzer skill for this phase.**

**DO NOT guess colors from a quick WebFetch.** You must extract REAL computed styles from the live DOM and count usage frequency to find the TRUE palette, not what looks right at a glance.

If the user provides a domain URL:

### 1a. Navigate and wait for full load
Open the site in Chrome, wait for JS to render (many sites are SPA/JS-heavy):
```
Navigate to URL → wait 4-5 seconds → take screenshot
```

### 1b. Deep color extraction (CRITICAL)
Execute JavaScript on the LIVE page to extract EVERY computed color and count frequency:
```javascript
// Count every background-color and color on every element
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
// Sort by frequency — the MOST USED colors are the real brand colors
const sorted = Object.entries(colorCount).sort((a,b) => b[1] - a[1]);
JSON.stringify(sorted.slice(0, 20));
```

This gives the TRUE palette ranked by actual usage. The most-used background color IS the brand background. The most-used text color IS the brand foreground. The color used on buttons/links IS the accent. **Do NOT override this with assumptions.**

### 1c. Font extraction
```javascript
const fontCount = {};
document.querySelectorAll('*').forEach(el => {
  const ff = getComputedStyle(el).fontFamily;
  if (ff) { fontCount[ff] = (fontCount[ff] || 0) + 1; }
});
const fontsSorted = Object.entries(fontCount).sort((a,b) => b[1] - a[1]);
JSON.stringify(fontsSorted.slice(0, 10));
```

### 1d. Download actual brand assets
```javascript
// Find logo images
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

If logo is an image URL → download it to `public/images/logo.{ext}`
If logo is an inline SVG → extract the SVG markup for use in the site

### 1e. Extract text content, links, contact info
```javascript
// Navigation links
const navLinks = [...document.querySelectorAll('nav a, header a')]
  .map(a => ({ text: a.textContent?.trim(), href: a.href }));

// Social links
const socials = [...document.querySelectorAll('a[href*="instagram"], a[href*="tiktok"], a[href*="facebook"], a[href*="linkedin"], a[href*="twitter"]')]
  .map(a => ({ href: a.href }));

// Phone numbers
const phones = document.body.textContent.match(/\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}/g);

// Email addresses
const emails = document.body.textContent.match(/[\w.-]+@[\w.-]+\.\w{2,}/g);

JSON.stringify({ navLinks, socials, phones, emails });
```

### 1f. Screenshot key pages
Take screenshots of:
- Homepage (above the fold)
- Homepage (scrolled to middle)
- About page (if accessible)
- Menu/Services page (if accessible)

### 1g. Analyze imagery style
Look at the photos on the site:
- Dark moody vs bright airy?
- Close-up food shots vs wide environment shots?
- Candid vs staged?
- Color grading (warm, cool, desaturated, neon)?
- Are they using stock photos or custom photography?

### Output: Brand Extraction Report
Present findings as:

```
## Brand Extraction: {Domain}

### Color Palette (by usage frequency)
| Rank | Color | Hex | Usage Count | Role |
|------|-------|-----|-------------|------|
| 1 | Deep navy | #060416 | 4200 | Background |
| 2 | Golden beige | #EED8C3 | 3719 | Primary/dominant |
| 3 | Warm cream | #FAF5EF | 1850 | Text/foreground |
| 4 | Crimson red | #D72626 | 21 | CTA accent only |
...

### Typography
| Font Family | Usage Count | Role |
|-------------|-------------|------|
| "nocturne-serif" | 3400 | Display/headings |
| "Clarkson" | 2800 | Body text |
...

### Brand Assets Found
- Logo: [downloaded to public/images/logo.svg]
- Favicon: [URL]
- OG Image: [URL]

### Contact Info
- Phone: (647) 930-2623
- Email: ...
- Address: 3175 Rutherford Rd, Unit 28, Vaughan

### Social Links
- Instagram: @yokai.izakaya
- TikTok: @yokai.izakaya

### Voice Analysis
- Tone: [from actual copy on the site]
- Key phrases: [from actual headlines]
```

### Pause Point
Show the FULL extraction report with color frequency data. Ask: "Does this match what you see? Any corrections?"

**The color frequency data is the truth.** If red only appears 21 times and golden beige appears 3719 times, the brand primary is golden beige — not red. Red is an accent. Get this right or the whole site will look wrong.

---

## Phase 2: Brand Guide Generation

From the Phase 1 analysis, generate a complete brand guide:

### Colors
- Primary color + dark/light variants
- Secondary color
- Accent color (used for CursorGlow, neon effects, spotlight borders)
- Background, foreground, muted, card, border colors
- Ensure sufficient contrast ratios (WCAG AA minimum)

### Typography — AVOID GENERIC FONTS
Never use Inter, Roboto, Arial, or system fonts for display/headings. Choose distinctive, characterful fonts:
- Display font — for hero headlines (e.g., Playfair Display, Space Grotesk, Bebas Neue, Syne)
- Heading font — condensed bold for section headings (e.g., Oswald, Barlow Condensed)
- Body font — readable but not boring (e.g., DM Sans, Outfit, Satoshi)
- Accent/mono font — for stats, code, timestamps (e.g., JetBrains Mono, IBM Plex Mono)
- Cultural font — if business has cultural identity (Noto Serif JP, etc.)

### Voice
- 3-5 tone adjectives
- 3-5 brand personality adjectives
- Banned phrases (clichés, overused terms)
- Writing style description

### Imagery
- Photography style (photorealistic, editorial, etc.)
- Subject matter relevant to industry
- Lighting preferences
- Camera/lens suggestions for FAL.ai prompts
- Keywords to avoid in generated images

### Output
Write all values into `brand.config.ts`. This file drives everything else.

---

## Phase 3: Aesthetic Direction + Visual Planning

Present the user with 7 style presets, plan which cinematic modules to use, AND plan all visual assets that need to be created:

### Style Presets
1. **Cinematic** — Dark, immersive. Full GSAP. Best for: agencies, studios, restaurants, luxury brands.
2. **Minimalist** — Clean, whitespace. Subtle. Best for: SaaS, consulting, professional services.
3. **Brutalist** — Raw, hard edges, glitch. Best for: creative agencies, fashion, art, music.
4. **Luxury** — Serif, gold/cream, slow elegant. Best for: real estate, hospitality, jewelry.
5. **Corporate** — Professional, card-based. Best for: finance, healthcare, legal.
6. **Creative Agency** — Playful, asymmetric, bold. Best for: design agencies, startups.
7. **E-commerce** — Product grid, conversion-focused. Best for: retail, DTC brands.

### Cinematic Module Selection (CRITICAL)

Pick 4-6 modules from the library based on industry. Use this guide:

| Industry | Recommended Modules |
|----------|-------------------|
| Restaurant/Food | ColorShift, AccordionSlider, KineticMarquee, OdometerCounter, CurtainReveal |
| Luxury/Jewelry | TextMaskReveal, CurtainReveal, SpotlightBorderCards, HorizontalScroll |
| Tech/SaaS | SpotlightBorderCards, StickyStack, GradientStrokeText, KineticMarquee |
| Creative/Agency | AccordionSlider, HorizontalScroll, TextMaskReveal, CursorGlow |
| Service Business | OdometerCounter, StickyStack, SpotlightBorderCards, KineticMarquee |
| Portfolio | AccordionSlider, HorizontalScroll, TextMaskReveal, CurtainReveal |
| Real Estate | CurtainReveal, HorizontalScroll, OdometerCounter, SpotlightBorderCards |

### Available Cinematic Components (in scaffold src/components/cinematic/)
- **CanvasHero** — Scroll-driven frame sequence OR static hero with scroll-fade content
- **TextMaskReveal** — Giant outlined text fills with color on scroll (clipPath animation)
- **KineticMarquee** — Scroll-velocity-reactive infinite text strip
- **SpotlightBorderCards** — Grid with cursor-tracking border glow on each card
- **OdometerCounter** — Mechanical rolling digit counter
- **AccordionSlider** — Expandable image panels (flex: 1 → flex: 5)
- **ColorShiftSection** — Background/text color transitions on scroll
- **StickyStack** — Pinned visual + scrolling content cards
- **CurtainReveal** — Two panels part like curtains revealing content
- **HorizontalScroll** — Scroll-hijack horizontal gallery
- **GradientStrokeText** — Animated gradient outlined text
- **CursorGlow** — Page-wide cursor-following radial gradient
- **NoiseOverlay** — Subtle film grain overlay
- **TiltCard** — 3D perspective tilt with spotlight

### Visual Asset Plan (CRITICAL — DO NOT SKIP)

For every section you're building, plan the visual assets it needs. Present this as a table to the user for approval BEFORE generating anything:

| Section | Asset Needed | Type | Generation Method | Prompt/Description |
|---------|-------------|------|-------------------|-------------------|
| Hero | Hero background | Video (frame sequence) OR Image | Kling via WaveSpeed + ffmpeg OR FAL.ai | "Moody izakaya interior, neon red glow..." |
| About | Interior photo | Image | FAL.ai (recraft-v3) | "Shot on Sony A7III, 35mm f/1.4..." |
| AccordionSlider panel 1 | Food photo | Image | FAL.ai | "Sashimi platter, dramatic lighting..." |
| AccordionSlider panel 2 | Food photo | Image | FAL.ai | "Yakitori on charcoal grill..." |
| ... | ... | ... | ... | ... |

**For each asset, decide:**
1. **Static image** → FAL.ai with brand imagery config (cameras, lenses, lighting, subjects)
2. **Scroll-driven video** → Generate image first (FAL.ai or Nano Banana Pro), then animate with Kling via WaveSpeed, then extract JPEG frames with ffmpeg
3. **Existing asset** → Client provides, or source from Unsplash (verify URL returns 200)

**Image prompt formula** (from brand.config.ts imagery settings):
```
"Shot on {camera}, {lens}, {scene matching section content}, {lighting}, {color temperature}, candid documentary style, {avoid keywords}"
```

**Video prompt formula** (for Kling/WaveSpeed):
```
"Slow {motion type}: {subject description}. {lighting}. {camera movement}. Cinematic, no text, no watermarks."
```
Motion types: dolly in, slow pan, gentle zoom, parallax shift, orbit

### Pause Point
Show the visual asset plan. Ask: "Does this look right? Should I generate these assets? The video generation will cost ~$0.50 per 5s clip on WaveSpeed."

Wait for approval before proceeding to Phase 4.

---

## Phase 4: Visual Asset Creation (STAGED — Images First, Video After Approval)

**Three stages with approval gates. NEVER skip to video without approved images.**

### Stage 1: Generate ALL static images first (FREE via FAL.ai)

Generate every image from the Phase 3 plan. This is free (FAL.ai), so generate liberally:

```bash
FAL_KEY="$FAL_KEY" npx tsx scripts/generate-blog-image.ts "{section-name}" "{prompt}"
```

Or use FAL.ai directly:
- Model: `fal-ai/nano-banana-pro` for clean product shots on plain backgrounds, `fal-ai/recraft-v3` for atmospheric scenes
- **Size for hero first-frames: ALWAYS `landscape_16_9`** — Kling output matches input aspect ratio, and the canvas is viewport-width. Square images = wasted space and ugly cropping. NEVER generate first-frame images as square.
- Size: `landscape_16_9` for hero/backgrounds/first-frames, `portrait_4_5` for accordion panels, `square_1_1` for cards only
- Style: `realistic_image` (recraft) or omit (nano-banana)

Save to `public/images/` with descriptive names:
```
public/images/
├── hero-bg.jpg              (hero background — 1920x1080)
├── hero-first-frame.jpg     (starting frame for video, if planned)
├── about-interior.jpg       (about section)
├── menu-sashimi.jpg         (accordion panel 1)
├── menu-skewers.jpg         (accordion panel 2)
├── menu-cocktails.jpg       (accordion panel 3)
└── ...
```

If an image doesn't look right, **regenerate it** with a refined prompt. Iterate until good.

### ── PAUSE: Image Review ──
Show ALL generated images to the user. Ask:
"Here are the generated images for each section. Which ones work? Which need regeneration? And which image should I use as the starting frame for the hero video?"

**Wait for explicit approval before spending money on video.**

### Stage 2: Animate approved hero image into video (COSTS MONEY)

**Only proceed if:**
1. User approved the hero first-frame image
2. User confirmed they want scroll-driven video (not just a static hero)
3. User acknowledged the cost (~$0.50-0.56 per 5s clip)

**Step 1: Verify image is landscape 16:9** (Kling output matches input aspect ratio)
The first-frame MUST already be landscape from generation (generated with `image_size: 'landscape_16_9'`). If it's square or portrait, REGENERATE IT in landscape — do NOT pad/crop a square image. Kling will animate whatever aspect ratio you give it, and the canvas renders at viewport width.

If the image needs resizing to exactly 1920x1080:
```javascript
const sharp = require('sharp');
sharp('public/images/hero-first-frame.jpg')
  .resize(1920, 1080, { fit: 'cover' })
  .jpeg({ quality: 95 })
  .toFile('public/images/hero-1080p.jpg');
```

**Step 2: Upload to litterbox** (24hr temp hosting for WaveSpeed)
```bash
curl -s -F "reqtype=fileupload" -F "time=24h" -F "fileToUpload=@public/images/hero-1080p.jpg" https://litterbox.catbox.moe/resources/internals/api.php
```

**Step 3: Submit to WaveSpeed/Kling**
```bash
curl -X POST "https://api.wavespeed.ai/api/v3/kwaivgi/kling-video-o3-pro/image-to-video" \
  -H "Authorization: Bearer $WAVESPEED_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"image": "{litterbox_url}", "prompt": "{motion prompt}", "duration": 5, "cfg_scale": 0.7, "sound": false}'
```

Motion prompt examples:
- Restaurant: "Slow dolly forward, steam rises from dishes, neon signs glow warmly, ambient movement"
- Agency: "Gentle orbit around workspace, screens emit soft light, city bokeh through windows"
- Luxury: "Slow zoom into product, spotlight catches details, shallow depth of field shifts"

**Step 4: Poll for result** (every 15s, takes 1-3 minutes)
```bash
curl "https://api.wavespeed.ai/api/v3/predictions/{id}/result"
```

Download the MP4 to `public/assets/hero-loop.mp4`

### ── PAUSE: Video Review ──
Show/describe the generated video. Ask: "Does this look good for the scroll-driven hero? If not, I can regenerate with a different motion prompt."

### Stage 3: Extract JPEG frames for CanvasHero

**Only after video is approved:**

```bash
# Extract at 24fps, 720p for web performance
mkdir -p public/assets/frames
ffmpeg -i public/assets/hero-loop.mp4 -vf "fps=24,scale=1280:720" -q:v 4 public/assets/frames/frame-%04d.jpg

# Count frames
FRAME_COUNT=$(ls public/assets/frames/ | wc -l)
echo "Extracted $FRAME_COUNT frames"
```

Update the CanvasHero component with the actual frame count:
```tsx
<CanvasHero frameCount={FRAME_COUNT} framePath="/assets/frames/frame-" />
```

### No Video? That's Fine.
If the user doesn't want video or can't justify the cost, the CanvasHero falls back to `staticImage` mode with a parallax effect on the approved hero-bg.jpg. Still cinematic, just not scroll-driven video.

Motion prompt examples:
- Restaurant: "Slow dolly forward through izakaya, neon signs glow, steam rises from grill, warm amber light"
- Agency: "Slow orbit around modern workspace, screens glowing, city lights through windows"
- Luxury: "Gentle zoom into jewelry display, soft spotlight catches facets, shallow depth of field"

**Step 3: Extract JPEG frames with ffmpeg**
```bash
# 720p frames for scroll animation (lighter files)
ffmpeg -i public/assets/hero-loop.mp4 -vf "fps=24,scale=1280:720" -q:v 4 public/assets/frames/frame-%04d.jpg

# Count frames
ls public/assets/frames/ | wc -l
```

**Step 4: Update CanvasHero frameCount**
Set `frameCount` in the page component to the actual number of extracted frames.

### 4c. Unsplash Fallback

If FAL.ai or video generation isn't available/wanted, use Unsplash:
```
https://images.unsplash.com/photo-{ID}?w={width}&h={height}&fit=crop&q=80
```
**Always verify** each URL returns 200 before using. Broken images kill the premium feel.

### Pause Point
Show generated assets to user. Ask: "Do these look right for the site?"

---

## Phase 5: Scaffold & Customize

1. **Clone the scaffold fresh** from GitHub into the user's chosen `{PROJECT_PATH}/{CLIENT_SLUG}` directory:
   ```bash
   cd "{PROJECT_PATH}"
   npx degit micheauxspencer/haazel-scaffold {CLIENT_SLUG}
   cd {CLIENT_SLUG}
   ```

   `degit` downloads the repo without git history — perfect for a fresh scaffold. Windows users: if degit fails, fallback is:
   ```bash
   git clone --depth 1 https://github.com/micheauxspencer/haazel-scaffold.git {CLIENT_SLUG}
   rm -rf {CLIENT_SLUG}/.git
   ```

2. Write `src/lib/brand.config.ts` with ALL Phase 2-3 values (replace the default Haazel Studio config entirely)

3. Update `src/app/globals.css` — modify `:root` CSS custom properties with brand colors in oklch format. This is a DARK-FIRST brand system — `:root` and `.dark` should match for dark brands.

4. Update `src/app/layout.tsx` — change `next/font/google` imports to match brand typography. Add cultural font (e.g. Noto Serif JP) if needed.

5. Install dependencies:
   ```bash
   npm install
   ```

6. Verify build works:
   ```bash
   npx next build
   ```

---

## Phase 5: Build Pages with Cinematic Modules

**THIS IS WHERE THE MAGIC HAPPENS. No generic sections.**

### GSAP Master MCP Workflow (USE FOR EVERY ANIMATION)

For every animation effect on the page:
1. **Generate**: Use GSAP Master MCP `understand_and_create_animation` — describe the effect in natural language
2. **Optimize**: Run `optimize_for_performance` on the generated code — get 60fps + mobile variant
3. **Pattern**: Use `create_production_pattern` for battle-tested hero/scroll/text patterns
4. **Debug**: If anything stutters or breaks, use `debug_animation_issue`

### Home Page Composition — Content-Driven, Not Templated

**DO NOT use a fixed section sequence.** Every site is unique. Compose the page based on:
1. **What the business actually needs to communicate** (menu? portfolio? services? trust?)
2. **What content exists** (do they have great photography? testimonials? stats worth showing?)
3. **What emotional arc fits the brand** (mystery → reveal? authority → trust? playful → conversion?)

### Composition Process

**Step 1: Identify the narrative arc.** Ask: what story does this site need to tell? Examples:
- Restaurant: "Enter our world → see what we offer → feel the vibe → book a table"
- SaaS: "Understand the problem → see the solution → trust the proof → start free"
- Portfolio: "See the work → understand the craft → hire us"
- Local service: "Know who we are → see what we do → trust us → call now"

**Step 2: Map content blocks to that arc.** Each block needs a purpose:
- **Establish mood** → CanvasHero, ColorShiftSection, CursorGlow
- **Reveal identity** → TextMaskReveal, GradientStrokeText, CurtainReveal
- **Build energy** → KineticMarquee, AccordionSlider
- **Show offerings** → SpotlightBorderCards, StickyStack, HorizontalScroll
- **Prove credibility** → OdometerCounter, TiltCard (testimonials)
- **Drive action** → CurtainReveal (dramatic CTA), MagneticButton
- **Create rhythm** → KineticMarquee (as dividers, not just at top/bottom)

**Step 3: Sequence for flow.** Alternate between:
- High-energy moments (hero, marquee, reveal) and breathing room (story sections, stats)
- Full-width immersive sections and contained content blocks
- Scroll-driven effects and static reading sections

**Step 4: Cut ruthlessly.** A 5-section site with perfect pacing beats a 9-section site that drags. Not every module needs to appear. Use 4-7 sections per page.

### Module Selection — Match to Content, Not Industry

Ask these questions:
- **Does the brand name deserve a reveal moment?** → TextMaskReveal or CurtainReveal
- **Are there 3+ visual items to showcase?** → AccordionSlider or HorizontalScroll
- **Are there impressive numbers?** → OdometerCounter
- **Does the offering need explanation?** → StickyStack (pinned visual + scrolling steps)
- **Are there 4+ services/features?** → SpotlightBorderCards
- **Does the brand have cultural identity?** → KineticMarquee with native script, cultural SVG dividers
- **Is there a strong CTA moment?** → CurtainReveal
- **Does the brand shift between moods?** → ColorShiftSection

### Cultural Adaptation (when applicable)
- **Japanese**: Native characters in headlines/marquees, Noto Serif JP, noren SVGs, vertical text (`writing-mode: vertical-rl`), Japanese farewells
- **Italian**: Italian phrases, elegant serif, olive/terracotta tones, classical proportions
- **French**: French accents, refined typography, muted luxury palette
- **Latin American**: Warm palette, bold type, rhythmic layout
- **Nordic**: Cool tones, extreme whitespace, understated motion
- Adapt naturally — don't caricature. Weave culture in, don't slap it on.

### Inner Pages
- Inner pages use 3-5 cinematic modules (not all 14)
- Match modules to page purpose (About → story-focused, Services → showcase-focused)
- CursorGlow + NoiseOverlay on cinematic/luxury/creative builds

### Image Generation
Use FAL.ai to generate hero and section images matching brand imagery config:
```bash
FAL_KEY="$FAL_KEY" npx tsx scripts/generate-blog-image.ts "hero" "{prompt from brand imagery config}"
```

---

## Phase 6: Git Init + First Commit

**This runs automatically at the end of every build.**

```bash
cd "{PROJECT_PATH}/{CLIENT_SLUG}"
git init
git add -A
git commit -m "Initial build: {CLIENT_NAME} cinematic site via Haazel Build"
```

This gives the user a clean starting point they can push to any remote, deploy anywhere, or continue iterating on.

**DO NOT deploy to Vercel automatically.** Deployment is the user's choice and timing.

---

## Phase 7: Sanity CMS + Auto-Blog Setup (OPTIONAL)

**Only run this phase if the user explicitly requests a blog or CMS.**

Before starting, ASK: "Do you want a blog with auto-publishing for this site?"

If yes → use the `haazel-auto-blog` skill:
- Create Sanity project, deploy schemas, create initial documents
- Set up scheduled task from template
- Update `.env.local` with Sanity credentials
- Commit the CMS integration as a second commit:
  ```bash
  git add -A
  git commit -m "Add Sanity CMS + auto-blog configuration"
  ```

If no → skip entirely. The site works perfectly without Sanity/blog. The scaffold gracefully handles missing Sanity config (`isSanityConfigured` guard returns empty arrays).

---

## Quality Checklist (VERIFY BEFORE DELIVERY)

- [ ] No generic sections — every section uses a cinematic module
- [ ] CursorGlow active (accent color)
- [ ] NoiseOverlay at 2-4% opacity
- [ ] Hero text uses strong text-shadow, NOT gradient overlays
- [ ] Small text over images uses individual backdrop pills
- [ ] All icons are inline SVGs, no emojis
- [ ] Font contrast meets minimums (#999 dark, #555 light)
- [ ] Cultural elements woven in (if applicable)
- [ ] KineticMarquee speeds up on fast scroll
- [ ] OdometerCounter digits roll mechanically
- [ ] SpotlightBorderCards glow follows cursor
- [ ] CurtainReveal opens smoothly on scroll
- [ ] Animations optimized via GSAP Master MCP
- [ ] Mobile responsive (375px to 1440px+)
- [ ] All links clickable (tel:, mailto:, internal)
- [ ] Git initialized with clean first commit
- [ ] If blog requested: ISR working (60s revalidation)

---

## Per-Client Checklist (What You Need)

**Required:**
1. Business name + domain (or competitor URL)
2. Industry/niche
3. Region/location
4. Style preference (from 7 presets)

**Optional (ask the user):**
5. Want a blog? → triggers Phase 7 (Sanity + auto-blog)
6. Blog schedule (e.g., "Tuesdays and Thursdays at 9am")
7. Authority credentials (e.g., "10 years, 500+ projects")

Everything else derives automatically. The build ends with a git repo ready to push.
