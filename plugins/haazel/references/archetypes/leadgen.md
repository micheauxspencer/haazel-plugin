# Archetype — Local Lead-Gen

Local-service site for a homeowner comparing three contractors on a phone, in
one sitting, deciding on trust signal and price expectation. The job isn't to
impress — it's to reach "call now" or "request a quote" before they tab back
to a competitor.

## Layout grammar

- Conversion architecture IS the layout, not a layer on top of it: the phone
  number is visible in every viewport (sticky header on desktop, sticky
  bottom call bar on mobile — a real `tel:` link, not a form detour), and a
  quote CTA repeats roughly every two viewports down the page, not just top
  and bottom.
- Trust chips travel WITH the CTA, not off in their own section — license
  number, years in business, review stars sit next to the button that asks
  for the click, because that's the exact moment the homeowner is deciding
  whether this is a real business.
- Recipe pack: `LocalHero`, `ServiceCards`, `ProcessSteps`, `ReviewsWall`,
  `ServiceAreaList`, `QuoteForm` (posts to `/api/quote`), `BeforeAfterGallery`,
  `TrustBadges` (SECTION_SPEC §7 leadgen pack).
- Programmatic city pages are the scale play: `/{service}-{city}` (e.g.
  `/aluminum-railings-toronto`) reusing the same trust architecture with real
  per-page difference — the neighborhoods actually served, a local
  testimonial if one exists — not a find-and-replace city name over identical
  copy. Thin pages hurt the exact ranking they're built to chase.
- Asymmetric splits (hard-rules #5) still apply — a homeowner's trust scan
  moves faster against a clearly-hierarchied 62/38 layout than a centered
  wall of icon cards.

## Type & color

- Sturdy grotesque + mono, not editorial serif. This audience isn't judging
  brand sophistication — they're confirming "is this a real, competent
  business" in under two seconds on a small screen. A grotesque built for
  small-screen legibility (Public Sans, Work Sans, DM Sans class — wide
  x-height, unambiguous numerals) beats anything with personality-first
  letterforms.
- Mono for every phone number, price, and address. A phone number set in a
  display face is a UX bug, not a style choice — digits must be unmistakable
  at a glance and tap-to-call ready.
- colorScheme usually `light` — daylight, trustworthy, legible register; a
  dark hero reads "agency portfolio," not "call this plumber." One accent
  color for every CTA, used consistently so the eye learns "that color means
  click here" within one scroll.
- radius mid-range, 0.5–0.75rem — soft enough to feel approachable, not so
  soft it reads as a consumer app.

## Motion policy: `restrained`

Entrance reveals (masked rise, ≤24px translate, once) and micro-interactions
only — this homeowner is comparing three tabs, not watching a campaign film.
`bannedModules`: essentially the entire scroll-scrub category — `CanvasHero`,
`TextMaskReveal`, `CurtainReveal`, `HorizontalScroll`, `ColorShiftSection`,
`StickyStack`, `StickyCards`, `SplitScreen`, `ZoomParallax` (cinematic drama
reads "agency," not "contractor") — plus the cursor toys (`CursorGlow`,
`ImageTrail`, `MagneticGrid`, `DragPanGrid`) and decorative ambient
(`MeshGradient`, `GlitchEffect`, `TextScramble`, `CircularText`,
`GradientStrokeText`).
Allowed and purposeful: `OdometerCounter` for a real stat ("500+ jobs
completed"); `ScrollProgress`; `KineticMarquee` at low speed for a
service-area or certification ticker; `Typewriter` cycling real services;
`VideoBackground` if real job-site footage exists; `SpotlightBorderCards` or
`TiltCard` as subtle hover polish on `ServiceCards`; `SVGDraw` for a small
trust-badge flourish — the one scroll.md exception to the blanket ban,
because a line-drawing checkmark isn't a scroll-hijack. The one exception to
the no-cursor-toy rule is `CursorReveal`'s `WipeReveal`: a draggable
before/after divider isn't decoration, it's the proof-of-work mechanic
`BeforeAfterGallery` needs.

## Section recipe (home)

1 `LocalHero` (service + city + phone all above the fold, `TrustBadges`
visible without scrolling) → 2 `ServiceCards` → 3 `ProcessSteps` (how the
quote → job → done flow works, lowers the "will they ghost me" fear) → 4
`BeforeAfterGallery` (the real proof-of-work moment) → 5 `ReviewsWall` (real
reviews only — hard-rules #8, never fabricated counts or quotes) → 6
`ServiceAreaList` → 7 `QuoteForm` with `TrustBadges` repeated nearby → phone
number repeated in the footer. 6–8 sections; cut anything that delays the
quote ask.

## Copy voice

Specific service language over adjectives — "Emergency drain repair in
Etobicoke, same-day" beats "Quality service you can trust." Price anchors
build trust faster than vague reassurance: a real diagnostic fee, a real
starting price, a real timeframe. City names belong in H1s, both for local
search and for the two-second "yes, they serve my area" scan. Banned clichés:
"quality service," "customer satisfaction guaranteed," "affordable," "we
treat you like family" — say the specific thing instead of the generic
promise.

## SEO shape

`LocalBusiness` JSON-LD on every page, with NAP (name/address/phone) matching
byte-for-byte across footer, schema, and every city page — inconsistent NAP is
a local-SEO trust signal killer. `aggregateRating` in schema only if the
reviews are real and current (hard-rules #8 — never fabricate).
`/{service}-{city}` pages are the money pages; title pattern `{Service} in
{City} | {Business}`, meta description includes the phone number when the
character budget allows.

## Reference notes (describe, never copy)

- Thumbtack / Angi — the trust-before-ask architecture: reviews, licensing,
  and response time sit right next to the request-a-quote action, never
  tucked into a separate "why us" section the homeowner has to go find.
- Google Local Services / Google Business Profile — the badge-and-star-rating
  pattern homeowners already trust on sight; echoing that visual language
  near a CTA borrows credibility a brand-new site hasn't earned yet.
- The drag-to-compare slider pattern generally — the single interactive
  centerpiece worth building for real: earn it with an actual `WipeReveal`,
  not a gallery of static before/after pairs pretending to be interactive.
