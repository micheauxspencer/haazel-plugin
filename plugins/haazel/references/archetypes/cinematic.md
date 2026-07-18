# Archetype — Cinematic Brand Site

Scroll-driven brand experience: restaurants, venues, fashion, premium
services, product drops with story. The audience came to FEEL the brand;
the site is the campaign.

## Layout grammar

- The page is a narrative arc, not a stack: opening statement → build →
  crescendo → resolve → invite. Write the arc in SECTION_PLAN before
  choosing modules; energy must vary (quiet after loud).
- Full-bleed moments (CanvasHero, BleedImage, CurtainReveal) alternate with
  contained editorial passages (EditorialSplit 62/38, LayeredHeadline).
- Overlap is the house move: type over imagery over type (OverlapField),
  serif-italic words breaking display lines (LayeredHeadline overlay).
- Kinetic type bands (ScrollingText / KineticMarquee) as section
  connective tissue — language as texture.
- Cultural adaptation is mandatory when the brand carries one: native
  script in marquees, cultural motifs as SVG dividers, vertical text where
  the culture reads it (see hard-rules #10).

## Type & color

- Pairing with drama: expressive display serif (Fraunces, Cormorant,
  Canela class) or hard grotesque (Druk class energy) + quiet body +
  wide-tracked mono overlines. The overlay-italic move needs a true italic.
- colorScheme: usually `dark`; one canvas color owns ≥70% share, one
  metal/accent at ≤5% (strokes, numerals, keylines — never big fills
  unless the direction says so). Record the shares in tokens `palette`.
- radius 0 is the default posture (heritage/editorial); soften only with
  reason. Hairlines everywhere; shadows rare.

## Motion policy: `cinematic`

The full arsenal, orchestrated: scroll-scrub (CanvasHero, CurtainReveal,
StickyStack, HorizontalScroll, ZoomParallax), masked text reveals, ambient
grain. Discipline:
- ONE scrub-hero-class moment per page (CanvasHero OR CurtainReveal OR
  HorizontalScroll) — two pins fighting is amateur hour.
- `ambient.noiseOverlay` 2–4% on; `cursorGlow` only when the direction
  asks (desktop-only by construction).
- Every module still settles under reduced motion (scaffold handles it —
  don't defeat it).
- GSAP Master MCP: use it for bespoke animation code when its tools are
  detected; otherwise follow the scaffold's CONVENTIONS.md — it is an
  enhancement, never a prerequisite.

`bannedModules`: none globally — the design system's direction bans
per-site (e.g. "no gradients" bans GradientStrokeText/MeshGradient).

## Section recipe (home)

1 hero moment (CanvasHero w/ frames, or VideoBackground + LayeredHeadline)
→ 2 manifesto (TextMaskReveal or LayeredHeadline in a quiet field) →
3 ScrollingText band → 4 story block (EditorialSplit + BleedImage) →
5 offering (AccordionSlider / StickyStack / OffsetGrid cards) →
6 proof (StatBand w/ OdometerCounter, or editorial pull-quote) →
7 gallery moment (HorizontalScroll / DragPanGrid) → 8 invite
(CtaPanel inverted or ContactSplit). 6–9 sections; the arc decides.

## Copy voice

Compressed and concrete — plain product language inside heritage visuals
outperforms perfume prose. Short declaratives. Specifics over adjectives
("Set up in three hours" beats "effortless elegance"). Overlines carry
facts (EST. dates, coordinates, materials).

## SEO shape

Often one-pager + contact: LocalBusiness or Organization JSON-LD, anchors
as nav. Multi-page (menus, private events) → per-page metadata + real OG
image from the asset run.

## Reference notes (describe, never copy)

- Cowboy.com — product cinema: scrub sequences serve comprehension, dark
  canvas, type stays quiet while media performs.
- Aesop.com — editorial restraint at luxury scale: serif discipline,
  muted palette, imagery breathes in full-bleed bands.
- Yeezy/gallery-drop microsites — type-as-image, zero radius, one accent;
  proof that a page of mostly typography can feel expensive.
