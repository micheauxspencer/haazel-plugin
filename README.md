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

This is a **marketplace** repo. Add the marketplace first, then install the plugin:

```bash
# From Claude Code (interactive)
/plugin marketplace add micheauxspencer/haazel-plugin
/plugin install haazel@haazel
```

Or from the shell:
```bash
claude plugin marketplace add micheauxspencer/haazel-plugin
claude plugin install haazel@haazel
```

For local development:
```bash
claude plugin marketplace add ./haazel-plugin
claude plugin install haazel@haazel
```

After install, restart your Claude Code session and verify the commands exist:
```
/haazel:haazel-build
/haazel:haazel-brand-analyzer
/haazel:haazel-cinematic
/haazel:haazel-auto-blog
```

(Note: plugins namespace their commands with the plugin name. The marketplace namespace also comes into play when there are name conflicts.)

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

**34 production-grade GSAP components** ported from the Cinematic Modules library, organized by interaction category. Full documentation with props and usage examples lives in the scaffold at `src/components/cinematic/README.md`.

### Scroll-Driven (10)
- **CanvasHero** — Scroll-driven JPEG frame sequence on canvas (300vh sticky + GSAP scrub) with static fallback
- **TextMaskReveal** — Giant outlined text fills with color on scroll via clipPath animation
- **CurtainReveal** — Two sticky panels part like curtains revealing content behind (xPercent ±100)
- **HorizontalScroll** — Vertical scroll hijacked into horizontal pan with progress bar
- **ColorShiftSection** — Background + text color transitions when section enters viewport (0.8s CSS transition at top 60%)
- **StickyStack** — Pinned visual on left + scrolling content cards on right (visual swaps as cards enter)
- **StickyCards** — Stacking cards where each pins and the next slides over it
- **SplitScreen** — Two-column scroll with independent left/right panels
- **ZoomParallax** — 3 depth layers zoom at different speeds on scroll (bg 1→1.15, mid 1→1.6, fg 1→6)
- **SVGDraw** — SVG paths draw themselves via stroke-dasharray/dashoffset GSAP animation

### Cursor & Hover (9)
- **CursorGlow** — Fixed radial gradient follows cursor with 0.12 eased trailing (desktop only)
- **TiltCard** — 3D perspective tilt (600px, ±12° rotation, 1.02 scale) with cursor-tracking spotlight
- **SpotlightBorderCards** — Grid with cursor-tracking border glow on each card (CSS vars)
- **AccordionSlider** — Expandable image panels (flex 1→5) with staggered content reveal (horizontal or vertical)
- **FlipCards** — 3D flip on hover (rotateY 180deg, backface-hidden)
- **CursorReveal** — Before/after image comparison (horizontal drag, vertical drag, spotlight, or grid)
- **ImageTrail** — Cursor leaves rotating fading trail of elements (60px spawn threshold, pool of 20)
- **MagneticGrid** — Dot grid that reacts to cursor proximity (dots scale up as cursor approaches)
- **DragPanGrid** — Click-and-drag to pan infinite canvas of scattered cards (mood boards)

### Click & Tap (6)
- **CoverflowCarousel** — 3D perspective carousel (center scale 1, flanks 0.8 with rotateY ±40°)
- **ParticleButton** — Button emits canvas particles on click with physics (velocity, gravity, fade)
- **DynamicIsland** — Apple Dynamic Island-style expanding pill (44px → 320px, 20px radius)
- **DockNav** — macOS dock with distance-based magnification (48px → 72px within 120px range)
- **ViewTransitionMorph** — Card-to-detail morphing using View Transitions API
- **OdometerCounter** — Mechanical rolling digit counter triggered on scroll (0.12s staggered delays)

### Ambient & Auto (9)
- **KineticMarquee** — Infinite text strip accelerates with scroll velocity (ScrollTrigger.getVelocity())
- **CircularText** — SVG text rotates along circular path (continuous + scroll-velocity reactive)
- **GlitchEffect** — RGB channel split on hover with steps() keyframe animation (cyan top, red bottom)
- **GradientStrokeText** — Outlined text with animated gradient fill (background-size 300%, infinite linear)
- **MeshGradient** — Animated gradient blobs drift smoothly (ambient atmospheric background)
- **TextScramble** — Text decodes character-by-character Matrix-style (cycles random chars, resolves left-to-right)
- **Typewriter** — Sequential text reveal with blinking cursor
- **VideoBackground** — Fullscreen autoplay looping video with optional overlay and content layer
- **NoiseOverlay** — Fixed full-page SVG film grain via feTurbulence filter (2-4% opacity)

### Component Conventions
All components follow these rules (see full README in scaffold for examples):
- `"use client"` with dynamic GSAP imports (zero impact on initial bundle)
- `gsap.context()` cleanup in useEffect return
- Standard easing: `cubic-bezier(.16, 1, .3, 1)` for interactive transitions
- TypeScript props interface + `className` prop on every component
- SSR safe (browser APIs only in useEffect)

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
