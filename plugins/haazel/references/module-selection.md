# Module Selection

Cross-archetype reference for choosing WHICH module, not which archetype uses
which — that's each `archetypes/*.md` file's job. This file answers three
different questions: what does the content need, where does it sit in the
page's arc, and what's the rhythm rule that stops a page from becoming a wall
of scroll-scrub. Component names here are verified against
`src/components/cinematic/.catalog/{scroll,click,ambient,cursor}.md` and
SECTION_SPEC §2's nine primitives — if a name isn't in one of those five
sources, it doesn't exist; don't reach for it from memory or from an older
doc.

A note on "Fits" tags: the cinematic catalog's `Fits` field is a starting
signal, not a ceiling. Archetype files layer explicit allows/bans on top of
it, and the archetype file wins when the two disagree —
`cinematic.md`'s own section recipe uses `OdometerCounter` for proof-of-numbers
even though that module's catalog `Fits` tag doesn't list `cinematic`. Trust
the archetype file over the tag.

## Content-driven selection

Ask what the content actually IS before reaching for a module — never assign a
fixed set because of the industry. The old `haazel-cinematic` command's
industry table (restaurant → ColorShift/AccordionSlider, luxury →
TextMaskReveal/CurtainReveal, etc.) is a starting suggestion at best; this
table answers the better question.

| Content need | Reach for |
|---|---|
| Real video footage exists | `VideoBackground` (straight loop) or `CanvasHero` (frame-sequence, scroll-scrubbed) |
| Number-heavy proof, one hero stat | `OdometerCounter` |
| Number-heavy proof, a row of stats | `StatBand` (shared pack) with `OdometerCounter` inside it |
| Long list of visual items (5+) | `AccordionSlider` (expand on hover/click) or `HorizontalScroll` (gallery pan) |
| Long list of scannable items, not visual-first | `ServiceCards`/`FeatureBento`-class pack component, or `OffsetGrid` directly |
| The brand name/word deserves a reveal | `TextMaskReveal` or `CurtainReveal` |
| Step-by-step process needs explaining | `StickyStack` (pinned visual + scrolling cards) or `ProcessSteps` (leadgen pack) |
| Before/after or variant comparison | `CursorReveal`'s `WipeReveal` (draggable divider) |
| Cultural/native-script identity | `KineticMarquee` with native script content, or `CircularText` |
| Section-to-section connective tissue | `ScrollingText` (primitive, quieter) or `KineticMarquee` (fuller, velocity-reactive) |
| Product needs to be understood from all angles | `CanvasHero` turntable sequence, or `ZoomParallax` into detail |
| Long page needs an orientation cue | `ScrollProgress` — functional, near-universally allowed |
| A CTA moment needs real weight | `CurtainReveal` (dramatic reveal-to-CTA), or a plain inverted `CtaPanel` |
| Feature/service grid needs hover polish | `SpotlightBorderCards` or `TiltCard` |
| A genuine milestone/success moment | `ParticleButton` — sparingly, earned only |
| App-shell utility navigation | `DockNav`, or `CommandPalette` (app pack) |
| A notification/status surface | `DynamicIsland` |
| A state toggle that should morph, not cut | `ViewTransitionMorph` |
| A logo/icon should feel hand-drawn | `SVGDraw` |
| Premium ambient texture (desktop) | `NoiseOverlay` + `CursorGlow` together |
| An exploratory canvas (map, mood board) | `DragPanGrid` |
| A tech/hacker/glitch register is actually earned | `TextScramble` or `GlitchEffect` |
| A typing/chat-like reveal | `Typewriter` |
| A playful cursor-attract background | `MagneticGrid` |
| A mood/atmosphere shift between sections | `ColorShiftSection` |
| Cards should stack and resolve on scroll | `StickyCards` |
| Two columns need independent parallel motion | `SplitScreen` |
| An art/fashion cursor flourish is on-brand | `ImageTrail` |
| A card should reveal a back-face detail | `FlipCards` |
| No photography, need ambient color | `MeshGradient` (CSS-only tier friendly) |
| A hero word needs a shifting gradient outline | `GradientStrokeText` |

## Narrative-arc energy mapping

Four beats, per archetype. Not every archetype has all four — say so when one
doesn't apply rather than forcing the pattern onto it.

- **cinematic** — *Opening*: full-bleed mood statement (`CanvasHero`/
  `VideoBackground` + `LayeredHeadline`). *Build*: identity reveal
  (`TextMaskReveal`/`CurtainReveal`) into a `ScrollingText`/`KineticMarquee`
  connective band. *Crescendo*: the one scrub-hero-class moment, plus
  `StatBand`/`OdometerCounter` proof. *Resolve*: quiet invite — inverted
  `CtaPanel` or `ContactSplit`; energy drops after the crescendo.
- **saas** — *Opening*: clarity statement (`SaasHero`, no theatrics). *Build*:
  proof interleaved with features (`LogoCloud`, `FeatureBento`/`FeatureTabs`),
  never stacked at the bottom. *Crescendo*: inverted `MetricsBand` — the one
  tempo break — plus `TestimonialWall`. *Resolve*: `PricingTable` →
  `FaqCompact` → `CtaPanel`; decision clarity, not drama.
- **app** — the arc model doesn't apply, and that's the useful finding, not a
  gap to fill in. There's no opening (the user lands mid-task; `KpiCards`/
  `ChartPanel` are the landing, not a statement), no build (`DataTablePro` is
  a steady state, not rising tension), no authored crescendo (a chart spike
  or an alert state is data-driven, not composed), no narrative resolve
  (`CommandPalette`/`SettingsForm` are always-available exits). Forcing this
  pattern onto a dashboard produces theatrical onboarding tours and
  unnecessary page-load animation — skip it.
- **leadgen** — *Opening*: `LocalHero` — service, city, phone, trust visible
  immediately. *Build*: `ServiceCards`/`ProcessSteps` — what and how, still
  restrained. *Crescendo*: `ReviewsWall`/`BeforeAfterGallery` — the real
  proof-of-work moment. *Resolve*: `QuoteForm` with `ServiceAreaList` context,
  phone repeated, low-friction.
- **commerce** — *Opening*: `ProductHero`, `StickyBuyBar` engaged
  immediately. *Build*: `ProductGallery` + editorial story block, one kinetic
  band. *Crescendo*: the one product-cinema scrub moment — showing, not just
  telling. *Resolve*: `SpecsTable`/`BundleCards` decision block,
  `DropCountdown` if real, buy always reachable.
- **editorial** — *Opening*: title card or index-as-hero — type is the
  opening. *Build*: `BleedImage` sequences + `OffsetGrid` tear-sheets,
  `ScrollingText` between clusters. *Crescendo*: one oversized image or
  pull-quote moment. *Resolve*: credits/colophon marginalia, next-piece link
  — quiet close, no hard sell.

## Rhythm rules

- Never stack two scroll-scrub pins back to back — `CanvasHero` directly into
  `CurtainReveal`, or `StickyStack` into `StickyCards`, hijacks the scroll
  gesture twice in a row and reads as broken, not premium. Land a
  normal-flow section between any two pinned moments.
- Quiet after loud: every crescendo-class module (a scrub hero, a marquee at
  speed, a big reveal) is followed by a section with LESS motion, not
  more — the same rule `cinematic.md` states for its own arc, generalized to
  every archetype.
- No three quiet sections in a row either (SECTION_PLAN's own rule, Phase 5
  of `haazel-build`) — a wall of static fade-ins is as flat a page as a wall
  of scrub pins is chaotic.
- Energy is a function of module class AND content density, not motion
  alone — a static section carrying a huge `OdometerCounter` stat can still
  read "loud." Judge the rhythm by what it feels like, not by whether GSAP is
  attached.
- Cursor-reactive ambient modules (`CursorGlow`, `TiltCard`,
  `SpotlightBorderCards`, `MagneticGrid`) are a continuous background
  register, not a per-section beat — they're set once, usually in
  `layout.tsx` via `tokens.json`'s `motion.ambient`, and don't count toward
  "how many loud sections in a row."

## Per-archetype allowed / banned summary

✓ fits and encouraged · △ situational — use sparingly, or only where the
archetype file names a specific case · — off-register for this archetype,
treat as banned by default even where the catalog's `Fits` tag doesn't
explicitly exclude it.

### Scroll-scrub (`cinematic/.catalog/scroll.md`)

| Module | cinematic | saas | app | leadgen | commerce | editorial |
|---|---|---|---|---|---|---|
| TextMaskReveal | ✓ | △ | — | — | △ | ✓ |
| CanvasHero | ✓ | — | — | — | △ | △ |
| CurtainReveal | ✓ | — | — | — | △ | ✓ |
| HorizontalScroll | ✓ | — | — | — | △ | ✓ |
| ColorShiftSection | ✓ | — | — | — | △ | △ |
| StickyStack | ✓ | ✓ | — | — | △ | △ |
| StickyCards | ✓ | ✓ | — | — | △ | △ |
| SplitScreen | ✓ | — | — | — | △ | △ |
| ZoomParallax | ✓ | — | — | — | △ | △ |
| SVGDraw | ✓ | ✓ | — | △ | △ | △ |

### Click/tap (`cinematic/.catalog/click.md`)

| Module | cinematic | saas | app | leadgen | commerce | editorial |
|---|---|---|---|---|---|---|
| CoverflowCarousel | ✓ | △ | — | — | △ | △ |
| ParticleButton | △ | △ | △ | — | — | — |
| DynamicIsland | △ | △ | △ | — | — | — |
| DockNav | — | △ | ✓ | — | — | — |
| ViewTransitionMorph | △ | — | △ | — | — | — |
| OdometerCounter | ✓ | ✓ | ✓ | ✓ | ✓ | △ |

### Ambient/kinetic (`cinematic/.catalog/ambient.md`)

| Module | cinematic | saas | app | leadgen | commerce | editorial |
|---|---|---|---|---|---|---|
| KineticMarquee | ✓ | ✓ | — | ✓ | ✓ | ✓ |
| CircularText | ✓ | — | — | — | — | ✓ |
| GlitchEffect | ✓ | — | — | — | — | △ |
| GradientStrokeText | ✓ | — | — | — | — | — |
| MeshGradient | ✓ | — | — | — | — | — |
| TextScramble | ✓ | — | — | — | — | △ |
| Typewriter | ✓ | ✓ | — | ✓ | — | — |
| VideoBackground | ✓ | — | — | ✓ | △ | △ |
| NoiseOverlay | ✓ | △ | — | △ | △ | △ |
| ScrollProgress | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |

### Cursor/hover (`cinematic/.catalog/cursor.md`)

| Module | cinematic | saas | app | leadgen | commerce | editorial |
|---|---|---|---|---|---|---|
| CursorGlow | △ | — | — | — | — | △ |
| TiltCard | ✓ | ✓ | — | ✓ | ✓ | — |
| SpotlightBorderCards | ✓ | ✓ | — | ✓ | ✓ | — |
| AccordionSlider | ✓ | — | — | △ | △ | ✓ |
| FlipCards | ✓ | △ | — | △ | ✓ | △ |
| CursorReveal | ✓ | — | — | ✓ | ✓ | ✓ |
| ImageTrail | ✓ | — | — | — | — | △ |
| MagneticGrid | ✓ | △ | — | — | — | △ |
| DragPanGrid | ✓ | — | — | — | — | △ |

### Primitives (SECTION_SPEC §2)

| Primitive | cinematic | saas | app | leadgen | commerce | editorial |
|---|---|---|---|---|---|---|
| SectionShell | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| LayeredHeadline | ✓ | △ | — | △ | ✓ | ✓ |
| CaptionRail | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| EditorialSplit | ✓ | ✓ | △ | ✓ | ✓ | ✓ |
| OverlapField/OverlapItem | ✓ | ✓ | — | △ | ✓ | ✓ |
| OffsetGrid | ✓ | ✓ | △ | ✓ | ✓ | ✓ |
| BleedImage | ✓ | △ | — | ✓ | ✓ | ✓ |
| ScrollingText | ✓ | △ | — | △ | ✓ | ✓ |
| DeviceFrame | — | ✓ | △ | — | △ | — |

`app`'s OffsetGrid is marked △, not ✓ or — : the archetype file names
functional aligned grids as the default and offset/asymmetric grids as the
situational exception (dashboards occasionally need an asymmetric bento for a
genuinely uneven feature set, e.g. one big chart plus small KPI tiles) — the
reverse weighting from every other archetype, worth reading as △ rather than
either extreme.
