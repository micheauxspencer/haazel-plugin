# Archetype — SaaS Marketing

Product-led marketing site for a software product. The audience is a buyer
evaluating in minutes: clarity converts, decoration doesn't.

## Layout grammar

- Hero: asymmetric OverlapField — statement type left, DeviceFrame product
  shot bleeding right (`SaasHero`). Never a centered headline over a
  full-bleed screenshot.
- Section spine: numbered CaptionRails ("01 — Product") keep long pages
  scannable.
- Proof density beats feature density: logos, metrics, testimonials
  interleaved between feature moments, not ghettoed at the bottom.
- Bento over uniform grids (`FeatureBento` 1-large+4-small); comparison and
  pricing use uneven emphasis (featured column wider + raised).
- Signature moves: DeviceFrame glow as the only "gradient" in the system;
  one inverted MetricsBand as the mid-page tempo break.

## Type & color

- Pairing: geometric or grotesque display (Sora, Bricolage Grotesque,
  General Sans class) + humanist body (Figtree, Albert Sans) + mono for
  metrics/labels (IBM Plex Mono, Geist Mono class). A serif display works
  for "calm infrastructure" positioning (Instrument Serif) — commit, don't
  hedge. Avoid the AI-default tells: Inter-everywhere, Space Grotesk
  reflex, purple-gradient-on-white.
- colorScheme: usually `light` or `dual` — decide, don't drift. One primary
  action color; one sharp accent (electric lime/coral class) at ≤5% share;
  backgrounds warm-white or true near-black, not gray mush.
- radius: 0.5–1rem family; hairlines from foreground mixes (borders must
  survive white).

## Motion policy: `restrained`

Entrance reveals (masked rise, ≤24px translates, once) + micro-interactions
(hover lifts ≤2px, border color shifts). NO scroll-scrub pins, no cursor
toys, no noise overlay, no CursorGlow.
`bannedModules`: CursorGlow, MeshGradient, GlitchEffect, ImageTrail,
CurtainReveal, DragPanGrid, CanvasHero (screenshot-scrub heroes are a
different product tier — allow only by explicit direction).
Allowed cinematic modules: OdometerCounter (metrics), ScrollProgress,
KineticMarquee only as a logo strip at low speed, TextMaskReveal for one
manifesto moment max.

## Section recipe (home)

1 `SaasHero` (announcement pill when there's real news) → 2 `LogoCloud` →
3 `FeatureBento` or `FeatureTabs` (tabs when workflows differ by persona) →
4 `MetricsBand` (inverted) → 5 `TestimonialWall` → 6 `IntegrationsGrid`
(when the ecosystem is a selling point) → 7 `PricingTable` →
8 `FaqCompact` → 9 `CtaPanel`. Cut, don't cram: 6–8 sections beats 10.
Secondary pages: /pricing (PricingTable + ComparisonTable + FaqCompact),
/product per feature cluster.

## Copy voice

Benefit-first, concrete, numbers over adjectives ("Save 12 hours a week"
not "supercharge productivity"). H1 ≤ 8 words. Banned clichés for this
archetype: game-changer, revolutionize, unleash, supercharge, seamless,
all-in-one, "AI-powered" as a benefit.

## SEO shape

Home + /pricing + product pages; Organization JSON-LD (+ FAQPage where FAQs
render); comparison keywords ("X vs Y") are the money pages — plan them in
scope when the user wants search traffic.

## Reference notes (describe, never copy)

- Linear.app — restraint as identity: one typeface family, near-black,
  motion only where state changes; density feels engineered.
- Stripe.com — proof interleaving and diagram-as-hero; gradients earn their
  place because everything else is disciplined.
- Vercel.com — mono-labels + hairline system on near-black/white; the
  DeviceFrame glow move done right.
