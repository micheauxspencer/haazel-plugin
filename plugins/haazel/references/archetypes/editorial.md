# Archetype — Portfolio / Editorial

Type-first, not motion-first: the audience came to read and look, and the
typographic system carries the brand before any animation does. Case studies
and articles, not landing pages.

## Layout grammar

- The primitives carry the identity: `LayeredHeadline` (display + serif-italic
  overlay) for title cards and pull-quotes, `ScrollingText` for connective
  tissue between pieces, `BleedImage` as the primary imagery unit (full-bleed,
  never a cropped card), `OffsetGrid` for tear-sheets and index listings.
  Cinematic modules get used selectively, on top of that system — never as
  the system itself. That's the line that separates editorial from the
  cinematic archetype: cinematic is motion-first with type in support;
  editorial is type-first with motion in support.
- Case-study structure: hero (project, client, year), the brief (what was
  asked), the work (image-heavy — `BleedImage` sequences, `OffsetGrid`
  tear-sheets), the outcome and credits (`CaptionRail` — real names, real
  dates, never decorative filler).
- Article structure: headline + dek + byline/date (`CaptionRail`), body copy
  in a constrained reading column even when imagery bleeds full-width around
  it, pull-quotes at `LayeredHeadline` scale, a related/next-piece link at
  the close.
- Marginalia is a deliberate move, not leftover white space: small notes,
  numbers, and dates set in the margin via `CaptionRail` carry real
  information (photographer, location, edition number) — never decoration
  for its own sake.
- Oversized folios: page/section numbers rendered as a design element in
  their own right (`SectionShell`'s numbered rail, taken further than the
  marketing archetypes take it) — a magazine-native move that also reinforces
  how far the reader is into a long piece.

## Type & color

- Expressive display serif (Fraunces, Cormorant, Canela class) or a hard
  grotesque with real presence — commit to drama in the display face,
  because the display face IS the brand here. Body face stays quiet and
  highly readable; the contrast between the two is the point.
- colorScheme: often `light` (paper/gallery-white, ink-black text) or a
  restrained `dark` for moodier studio work — either way, one canvas tone
  dominates and imagery supplies the color, not the palette.
- radius 0 as the default posture, the same instinct as the cinematic
  archetype: editorial reads as printed matter, and printed matter doesn't
  have rounded corners.

## Motion policy: `expressive`

Reveals and one kinetic band, the same tier as commerce but in service of
reading rhythm, not product comprehension. Scroll-scrub is available but
type carries the page even at zero motion — turn everything off and a
well-set article still works, which is the test cinematic sections don't
have to pass.
`bannedModules`: modules that fight legibility or feel like a marketing
gimmick — `GradientStrokeText`, `MeshGradient`, `ParticleButton`,
`DynamicIsland`, `ViewTransitionMorph`, `Typewriter`, `TiltCard`,
`SpotlightBorderCards`.
Allowed: `TextMaskReveal` or `CurtainReveal` for a title-card moment (one per
piece, not per section); `HorizontalScroll` or `AccordionSlider` for a
gallery sequence; `ZoomParallax` or `SVGDraw` for a single image-detail
moment; `TextScramble`/`GlitchEffect` where the subject matter earns a
rougher register (rare — most editorial work doesn't); `CircularText` for a
colophon or credits mark; `CursorReveal` for image comparisons where the work
calls for it; `CanvasHero` as a situational alternative to a static title
card, not a default.

## Section recipe (case study)

1 title card (`LayeredHeadline` or index-as-hero — see reference notes) → 2
the brief (`EditorialSplit`, contained reading column) → 3 the work
(`BleedImage` sequence, `OffsetGrid` tear-sheets, `ScrollingText` between
clusters) → 4 one oversized image or pull-quote moment (the crescendo) → 5
outcome + credits (`CaptionRail` marginalia, colophon) → 6 next-piece link.
Article template: headline/dek/byline → body in a constrained column with
full-bleed imagery breaks → pull-quote → related pieces. 5–7 sections; a
case study that needs more than that is really two case studies.

## Copy voice

Precise and unhurried — the sentence can take its time because the reader
already chose to be here. Specifics over adjectives, the same discipline as
every other archetype: name the material, the process, the year, the
outcome. Credits and colophon information is factual, not stylized filler
("Photography: [real name], 2025," never "shot with love"). No FAQ-section
instinct here — editorial doesn't answer objections, it makes a case.

## SEO shape

Per-piece metadata with a real OG image (the piece's own lead image, not a
site template), `Article`/`CreativeWork` JSON-LD with real author and date.
An index page (see reference notes) often serves as both the homepage and
the primary crawl entry point — make sure every piece is actually linked
from it, not just reachable by a slug.

## Reference notes (describe, never copy)

- Readymag-class editorial portfolios — the index-as-hero move: the
  homepage is just the list of work, typographically rich enough that no
  photograph is needed to make it feel designed.
- Swiss/International-Style-influenced studio portfolios — grid discipline
  taken seriously enough that the grid itself becomes visible as a design
  choice: oversized folios, consistent marginalia, nothing centered by
  default.
- Longform digital magazine features — the case-study pacing this archetype
  borrows: a constrained reading column that breaks for full-bleed image
  moments and comes back, rather than choosing one mode for the whole piece.
