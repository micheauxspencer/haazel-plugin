# Archetype — Product-Drop Commerce

Single-product energy: the page exists to sell one drop, to someone who
already has some interest and is deciding fast. The job is comprehension
(what is this, exactly) plus trust (is the scarcity real) — not a catalog
browse.

## Layout grammar

- One hero, one product. `ProductHero` is the entire opening statement — this
  is not a multi-product bento; that's a different commerce pattern and out
  of this archetype's scope.
- `StickyBuyBar` persists across the whole page, the same way `AppShell`
  persists for the app archetype — always reachable, never a sequenced
  "section."
- `ProductGallery` carries the angles and detail work; `SpecsTable` carries
  the facts in mono (SECTION_SPEC §3 — numbers never sit in a body or display
  face). `BundleCards` for variant/bundle choice — offset emphasis on the
  recommended option, never a flat row of equal cards (hard-rules #5).
  `DropCountdown` only when the date is real (see Copy voice).
- Between the functional commerce components, editorial story sections
  (`EditorialSplit`, `BleedImage`, `ScrollingText`) carry the material/craft
  narrative — this archetype borrows cinematic's storytelling moves but keeps
  commerce's functional backbone (buy bar, specs, gallery) present
  throughout, never replaced by the story.

## Type & color

- Editorial display for the campaign statement (the drop deserves a real
  typographic moment) + mono for every spec, SKU, and price — never
  body-face numerals on anything a shopper might scan (SECTION_SPEC §3).
- colorScheme: decide, don't hedge. `dark` for hype/streetwear-adjacent drops
  (the product needs to glow against the canvas); `light` gallery-white for
  premium/design-object drops (the product needs to read as the only color
  in the room). Either way, one canvas tone owns the page.
- radius: zero-radius-friendly (SECTION_SPEC §7) — hard edges read "object,"
  soft radius reads "app." Respect `--radius`, but this is the archetype
  where 0 is a legitimate default, not just cinematic's territory.

## Motion policy: `expressive`

Reveals plus one kinetic band, with scroll-scrub reserved for actual
product-cinema — not layered everywhere the way the full cinematic archetype
allows. This sits between saas's restraint and cinematic's full arsenal: a
scrub moment earns its place only if it shows the product (a turntable frame
sequence, a zoom into stitching detail), never just because it looks good.
`bannedModules`: purely decorative texture that doesn't serve product
comprehension — `MeshGradient`, `GlitchEffect`, `TextScramble`,
`CircularText`, `DragPanGrid`, `ImageTrail`, `CursorGlow`.
Allowed: ONE kinetic band (`KineticMarquee` — materials, craft credits, or a
drop-name ticker); `CursorReveal`'s `WipeReveal` for color/material variant
comparison (functional, not decorative); `TiltCard`/`SpotlightBorderCards`
for `BundleCards` hover polish; `FlipCards` for a spec-detail reveal;
`OdometerCounter` for a real stock/units counter; `SVGDraw` for a
construction-line or stitch-detail flourish; `ScrollProgress`. ONE
scrub-hero-class moment (`CanvasHero` turntable OR `ZoomParallax` into
detail) per page — never both, never stacked with ambient/cursor extras on
top of it.

## Section recipe (home)

1 `ProductHero` (`StickyBuyBar` engaged from first scroll) → 2 kinetic band
(materials/craft ticker) → 3 `ProductGallery` → 4 editorial story block
(`EditorialSplit` + `BleedImage` — the material or craft story) → 5 the one
product-cinema scrub moment → 6 `SpecsTable` → 7 `BundleCards` → 8
`DropCountdown` (only if real) → 9 proof (`StatBand`, shared pack — real
numbers only). `StickyBuyBar` runs underneath all of it. 6–9 sections; the
product's own story decides how many earn a spot.

## Copy voice

Campaign-grade confidence, material specificity over adjectives —
"full-grain leather, resoled by hand" beats "premium quality." Specs carry
their own authority in mono; they don't need selling, just stating. Scarcity
language must be literally true: no manufactured urgency, no countdown to a
date that isn't real, no "3 left" unless that's the actual inventory number
(hard-rules #8 — a fabricated scarcity claim is a fabricated statistic).

## SEO shape

`Product` JSON-LD with price/availability/SKU kept in sync with real
inventory — stale schema claiming in-stock on a sold-out drop is worse than
no schema at all. OG image is the actual product shot, not a generic
campaign banner. The single product page is the primary money page; a
drop-archive page for past drops extends SEO life and builds anticipation for
the next one.

## Payments

Checkout links out — Stripe Payment Links or a Shopify buy button/checkout
URL. Building cart or payment collection inside the scaffold is out of
scope: `DropCountdown`, `BundleCards`, and `StickyBuyBar` all terminate in an
outbound link to a hosted checkout, never a custom form that touches card
data.

## Reference notes (describe, never copy)

- Nike SNKRS — drop mechanics done honestly at scale: a real countdown, real
  stock, the product itself as the only hero image, zero filler between
  "here it is" and "buy."
- Apple product pages — specs-as-hero: mono figures given the same visual
  authority as the headline, full-bleed product photography on a stage with
  nothing competing for attention.
- Kith / Aime Leon Dore — editorial-commerce hybrid: the look-book and the
  buy button share a page without either one apologizing for the other.
