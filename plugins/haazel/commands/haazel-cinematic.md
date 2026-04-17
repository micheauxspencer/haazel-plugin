---
name: haazel-cinematic
description: Add cinematic GSAP animations to any Next.js project using the Cinematic Modules library and GSAP Master MCP. TextMaskReveal, SpotlightBorderCards, KineticMarquee, OdometerCounter, AccordionSlider, CurtainReveal, CanvasHero, and more. No generic fade-ups.
---

# Haazel Cinematic — Premium GSAP Animation System

You transform websites from generic to cinematic using the Cinematic Modules library and GSAP Master MCP server. No fade-up-on-scroll basics. Every effect must be scroll-driven, cursor-reactive, or narratively purposeful.

Use this skill standalone or as Phase 5 of haazel-build.

## HARD RULES

1. **NEVER use basic ScrollReveal fade-ups as the primary animation.** Those are fallbacks only. Every section MUST use a cinematic module.
2. **Use GSAP Master MCP for all animation code generation.** Don't write GSAP from memory.
3. **No gradient overlays on heroes.** Strong text-shadow on headlines. Individual backdrop pills on small text.
4. **All icons are inline SVGs.** Never emojis. Never passing React component references as props from server to client.
5. **One easing curve:** `cubic-bezier(.16, 1, .3, 1)` for all interactive transitions.
6. **CursorGlow + NoiseOverlay** on every cinematic/luxury/creative build.

## Prerequisites

```bash
npm install gsap lenis
```

GSAP Master MCP must be installed:
```bash
claude mcp add-json gsap-master '{"command":"npx","args":["bruzethegreat-gsap-master-mcp-server@latest"]}'
```

---

## GSAP Master MCP Workflow

For EVERY animation on the page, follow this process:

### Step 1: Generate
Use `understand_and_create_animation` tool with a natural language description:
- "Scroll-driven text mask reveal where outlined text fills with red as user scrolls through"
- "Kinetic marquee that speeds up based on scroll velocity"
- "3D tilt card with cursor-tracking spotlight gradient"

### Step 2: Optimize
Run `optimize_for_performance` on the generated code:
- Gets 60fps desktop + mobile-optimized variant
- Adds `will-change`, reduces repaints, uses GPU-accelerated properties
- Creates battery-efficient mobile fallback

### Step 3: Pattern Check
Use `create_production_pattern` for standard patterns:
- Hero scroll sequences
- Text reveal systems
- Parallax depth layers
- Page transitions

### Step 4: Debug
If anything stutters, breaks, or conflicts (especially Lenis + ScrollTrigger):
Use `debug_animation_issue` with a description of the problem.

---

## Cinematic Components Library

Located in `src/components/cinematic/`. Each is a self-contained "use client" component.

### CanvasHero
Scroll-driven frame sequence hero. Falls back to static image when no frames available.
```tsx
<CanvasHero frameCount={121} framePath="/assets/frames/frame-" staticImage="/hero.jpg">
  <h1 style={{ textShadow: "0 4px 30px rgba(0,0,0,.9), 0 2px 10px rgba(0,0,0,.7)" }}>
    Headline
  </h1>
  <span style={{ background: "rgba(12,10,8,0.7)", padding: "4px 14px", backdropFilter: "blur(4px)" }}>
    Subtitle pill
  </span>
</CanvasHero>
```
- Section height: 300vh with sticky canvas
- Content fades out on scroll (opacity 0, y -60 between 10-35%)
- Frame extraction: `ffmpeg -i video.mp4 -vf "fps=24,scale=1280:720" -q:v 4 assets/frames/frame-%04d.jpg`

### TextMaskReveal
Giant outlined text fills with color on scroll via clipPath animation.
```tsx
<TextMaskReveal text="BRAND" fillColor="#D72626" />
```
- Uses `-webkit-text-stroke` for outline, filled copy behind
- GSAP ScrollTrigger scrub drives `clipPath: inset()`

### KineticMarquee
Infinite text strip that accelerates with scroll velocity.
```tsx
<KineticMarquee
  items={["ITEM ONE", "ITEM TWO", "日本語"]}
  baseSpeed={1.5}
  direction="left"
/>
```
- Uses `ScrollTrigger.getVelocity()` to modulate speed
- Triple-cloned content for seamless loop
- requestAnimationFrame-driven

### SpotlightBorderCards
Grid of cards with cursor-tracking border glow.
```tsx
<SpotlightBorderCards
  accentColor="215, 38, 38"
  items={[
    { icon: <svg>...</svg>, title: "Feature", description: "..." },
  ]}
/>
```
- Parent grid tracks mousemove, sets `--mx`/`--my` CSS vars per card
- `::before` pseudo with `radial-gradient(circle 180px at var(--mx) var(--my), ...)`

### OdometerCounter
Mechanical rolling digit counter triggered on scroll.
```tsx
<OdometerCounter value={2023} label="Award Year" suffix="" />
```
- Each digit is a 0-9 vertical strip
- Staggered 0.12s transition delays per digit
- ScrollTrigger `once: true`

### AccordionSlider
Expandable image panels.
```tsx
<AccordionSlider panels={[
  { image: "/photo.jpg", title: "Title", description: "..." },
]} />
```
- `flex: 1` → `flex: 5` on hover/click
- Background zoom, staggered content reveal (0.1s, 0.15s, 0.2s)

### ColorShiftSection
Background/text color shifts when section enters viewport.
```tsx
<ColorShiftSection bgColor="#0D0A2A" textColor="#FAF5EF">
  <div>Content here</div>
</ColorShiftSection>
```
- ScrollTrigger at `top 60%`, 0.8s CSS transition

### StickyStack
Pinned visual + scrolling content cards.
```tsx
<StickyStack items={[
  { visual: <img />, title: "Step 1", description: "..." },
]} />
```
- Left column pinned, visual swaps opacity as right cards scroll
- Section height = items.length × 100vh

### CurtainReveal
Two panels part like curtains on scroll.
```tsx
<CurtainReveal leftText="よい" rightText="時間を">
  <div>Revealed CTA content</div>
</CurtainReveal>
```
- 300vh section, scrub animation
- Panels move `xPercent: ±100`

### HorizontalScroll
Scroll-hijack horizontal gallery.
```tsx
<HorizontalScroll>{panels}</HorizontalScroll>
```
- Section height = panels × 100vh
- Progress bar at bottom

### GradientStrokeText
Animated gradient outlined text.
```tsx
<GradientStrokeText text="RESERVE" colors={["#FAF5EF", "#EED8C3"]} />
```
- `background-size: 300%` with infinite linear animation

### CursorGlow
Page-wide cursor-following radial gradient.
```tsx
<CursorGlow color="#D72626" />
```
- 500px circle, 0.12 easing factor
- Desktop only (touch detection)

### NoiseOverlay
Subtle film grain overlay.
```tsx
<NoiseOverlay opacity={0.035} />
```
- SVG feTurbulence filter
- Fixed position, pointer-events none

### TiltCard
3D perspective tilt with spotlight.
```tsx
<TiltCard className="p-8 bg-card rounded-xl">Content</TiltCard>
```
- `perspective(600px) rotateY(x*12deg) rotateX(-y*12deg) scale(1.02)`

---

## Module Selection — Content-Driven, Not Industry-Templated

**DO NOT assign a fixed module set per industry.** Instead, ask:

| Question | If yes → consider |
|----------|-------------------|
| Does the brand name deserve a dramatic reveal? | TextMaskReveal, CurtainReveal |
| Are there 3+ visual items to showcase? | AccordionSlider, HorizontalScroll |
| Are there impressive numbers to display? | OdometerCounter |
| Does the offering need step-by-step explanation? | StickyStack |
| Are there 4+ services/features to present? | SpotlightBorderCards |
| Does the brand have cultural identity? | KineticMarquee with native script |
| Does the page need mood transitions? | ColorShiftSection |
| Is there a strong conversion moment? | CurtainReveal, MagneticButton |
| Does the brand benefit from ambient texture? | CursorGlow, NoiseOverlay |

The industry table below is a **starting suggestion**, not a recipe:

| Industry | Modules that often work well |
|----------|-------------------|
| Restaurant/Food | ColorShift, AccordionSlider, KineticMarquee |
| Luxury/Jewelry | TextMaskReveal, CurtainReveal, HorizontalScroll |
| Tech/SaaS | SpotlightBorderCards, StickyStack, GradientStrokeText |
| Creative/Agency | AccordionSlider, HorizontalScroll, TextMaskReveal |
| Service Business | OdometerCounter, StickyStack, SpotlightBorderCards |

---

## Page Composition — Narrative-Driven

**Every site tells a different story.** Compose based on the brand's narrative arc, not a fixed template.

### Step 1: Define the arc
- Restaurant: "Enter our world → taste the menu → feel the vibe → reserve"
- SaaS: "Understand the pain → see the solution → trust the proof → start free"
- Portfolio: "See the work → understand the process → hire us"
- Each arc is unique. Figure out the story FIRST, then pick modules to tell it.

### Step 2: Map modules to story beats
- **Establish mood** → CanvasHero, ColorShiftSection, CursorGlow
- **Reveal identity** → TextMaskReveal, GradientStrokeText, CurtainReveal
- **Build energy** → KineticMarquee, AccordionSlider
- **Show offerings** → SpotlightBorderCards, StickyStack, HorizontalScroll
- **Prove credibility** → OdometerCounter, TiltCard
- **Drive action** → CurtainReveal, MagneticButton

### Step 3: Edit ruthlessly
A tight 5-section page beats a bloated 9-section page. Use 4-7 sections. Cut anything that doesn't serve the narrative.

---

## Extended Cinematic Library (34 Components)

Beyond the 14 core modules above, the scaffold includes 20 additional cinematic components:

### Video & Media
- **VideoBackground** — Autoplay/loop MP4 background with IntersectionObserver pause, configurable playback rate, poster fallback
- **ZoomParallax** — Scroll-driven zoom with parallax depth layers
- **ImageTrail** — Mouse cursor leaves trail of images behind it

### Text & Typography
- **TextScramble** — Scrambles between character sets before resolving to final text
- **Typewriter** — Character-by-character text reveal with cursor
- **CircularText** — Text wrapped along SVG circular path with rotation
- **GlitchEffect** — Multi-layer glitch with color channel separation

### Layout & Navigation
- **SplitScreen** — Two-column layout with independent scroll or interaction
- **DockNav** — macOS-style dock navigation with icon magnification
- **DynamicIsland** — Morphing container that expands/contracts like iOS Dynamic Island
- **StickyCards** — Cards stack and offset as they reach scroll position

### Interactive
- **FlipCards** — 3D card flip on hover/click revealing back content
- **DragPanGrid** — Draggable infinite grid that pans in all directions
- **CoverflowCarousel** — 3D carousel with perspective rotation
- **MagneticGrid** — Grid elements attract toward cursor position
- **ParticleButton** — Button that explodes into particles on click
- **CursorReveal** — Cursor acts as a spotlight revealing hidden content beneath

### Visual Effects
- **MeshGradient** — Animated multi-point gradient mesh background
- **SVGDraw** — Scroll-driven SVG path drawing animation (stroke-dasharray)
- **ViewTransitionMorph** — CSS View Transitions API for morphing between states

All located in `src/components/cinematic/`. Use them to match the 5 Pillars (Story, Structure, Hierarchy, Motion, Interaction) — never add a module just because it looks cool.

---

## Performance Notes

- All GSAP is dynamically imported (code-split) — zero initial bundle impact
- ScrollTrigger instances cleaned up via `gsap.context()` in useEffect return
- Lenis smooth scroll only for cinematic/luxury/creative presets
- `will-change: transform` on animated elements only during animation
- `prefers-reduced-motion` check should disable scroll-driven effects
- GSAP Master MCP `optimize_for_performance` handles the rest
