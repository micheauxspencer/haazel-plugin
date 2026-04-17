# Haazel — Cinematic Website Builder Plugin for Claude Code

End-to-end cinematic website builder as a Claude Code plugin. Turn any brand brief into a production-grade Next.js site with GSAP scroll-driven effects, scroll-driven video heroes, and optional Sanity CMS auto-blogging.

## What's Inside

Four skills that work together or independently:

| Skill | Purpose |
|-------|---------|
| `/haazel-build` | Master 8-phase workflow: domain → brand → visual assets → scaffold → cinematic pages → git commit → optional blog |
| `/haazel-brand-analyzer` | Forensic brand extraction from any domain (frequency-ranked color/font analysis from live DOM) |
| `/haazel-cinematic` | Add GSAP cinematic modules to any Next.js project (TextMaskReveal, SpotlightBorderCards, KineticMarquee, CurtainReveal, etc.) |
| `/haazel-auto-blog` | Wire up Sanity CMS + ACE authority content auto-publishing with FAL.ai image generation |

## Install

```bash
claude plugin add https://github.com/micheauxspencer/haazel-plugin
```

Or for local development:
```bash
claude plugin add ./haazel-plugin
```

After install, restart your Claude Code session and verify:
```
/haazel-build
```

## Prerequisites

Required:
- **Node.js 20+** and **npm**
- **Git**
- **FAL_KEY** environment variable — for Nano Banana Pro images and Kling v3 Pro video generation. Get one at [fal.ai](https://fal.ai)

Recommended:
- **[GSAP Master MCP](https://github.com/bruzethegreat/gsap-master-mcp-server)** — for animation code generation and 60fps optimization
  ```bash
  claude mcp add-json gsap-master '{"command":"npx","args":["bruzethegreat-gsap-master-mcp-server@latest"]}'
  ```
- **ffmpeg** — only needed if building scroll-driven canvas video heroes
- **Sanity MCP server** — only needed for auto-blogging workflow

## The Workflow

```
1. Brand Analysis          Forensic DOM extraction — frequency-ranked colors, fonts, logo download
2. Brand Guide             Generate brand.config.ts with colors, typography, voice, imagery rules
3. Style + Module Plan     Pick style preset + cinematic modules + visual asset plan (PAUSE for approval)
4. Visual Asset Creation   Generate images (FREE) → approve → animate hero video (~$0.50) → extract frames
5. Scaffold & Customize    Clone haazel-scaffold, inject brand config, install dependencies
6. Build Pages             Cinematic modules composed based on narrative arc — no fixed templates
7. Git Init                Automatic first commit, no auto-deploy
8. Blog Setup              OPTIONAL — ask user, set up Sanity + scheduled auto-blogging if yes
```

## Cinematic Components (in the scaffold)

All 14 components ported from the Cinematic Modules library:

- **CanvasHero** — Scroll-driven frame sequence (300vh sticky canvas with GSAP scrub) or static fallback
- **TextMaskReveal** — Giant outlined text fills with color on scroll via clipPath
- **KineticMarquee** — Infinite text strip that accelerates with scroll velocity
- **SpotlightBorderCards** — Grid with cursor-tracking border glow on each card
- **OdometerCounter** — Mechanical rolling digit counter triggered on scroll
- **AccordionSlider** — Expandable image panels (flex 1→5 on hover)
- **ColorShiftSection** — Background/text color transitions when section enters viewport
- **StickyStack** — Pinned visual + scrolling content cards
- **CurtainReveal** — Two panels part like curtains revealing content behind
- **HorizontalScroll** — Vertical scroll hijacked into horizontal pan
- **GradientStrokeText** — Animated gradient on outlined text
- **CursorGlow** — Page-wide cursor-following radial gradient
- **NoiseOverlay** — Subtle SVG film grain overlay
- **TiltCard** — 3D perspective tilt with cursor-tracking spotlight

## Hard Rules (Enforced Every Build)

1. No generic layouts — every section uses a cinematic module, never a plain shadcn card grid
2. No dark vignettes on heroes — text-shadow on h1, individual backdrop pills on small text
3. All icons are inline SVGs, never emojis
4. Font contrast minimums — body #999 on dark, #555 on light
5. Cultural adaptation when applicable (Japanese, Italian, French, etc.)
6. One easing curve: `cubic-bezier(.16, 1, .3, 1)` for all interactive transitions
7. CursorGlow + NoiseOverlay on every cinematic/luxury/creative build
8. Use GSAP Master MCP for all animation code, not memorized patterns
9. Landscape 16:9 for hero first-frame images (never square)
10. Pause gates before spending money on video generation

## License

MIT
