<!--
  DESIGN_SYSTEM.md skeleton — filled by the haazel-design-system skill from
  design/tokens.json. Every {{PLACEHOLDER}} gets real values; every table row
  must be actionable (a builder should be able to obey it without asking).
  Delete guidance comments when rendering.
-->
# {{CLIENT_NAME}} — Design System

**Archetype:** {{ARCHETYPE}} · **Scheme:** {{COLOR_SCHEME}} · **Generated:** {{DATE}} by haazel {{VERSION}}
Source of truth: `design/tokens.json` → applied via `npm run tokens:apply`. Never hand-edit generated regions.

## Positioning

{{ONE_PARAGRAPH — who this brand is, who it's for, and the feeling the site
must produce. Concrete, no marketing perfume.}}

## Color

| Token | Value | Usage share | Role & rules |
|---|---|---|---|
| {{name}} | {{hex}} | {{max share %}} | {{where it may/may not appear}} |

Rules: {{colors.rules as bullet list — e.g. "accent never fills blocks"}}
Contrast verified: body {{fg/bg ratio}}, muted {{ratio}}, primary button {{ratio}} (floors: 4.5 / 4.5 / 3).

## Typography

**Pairing:** {{display family}} (display) × {{heading family}} (heading) × {{body family}} (body) × {{mono family}} (mono)
**Signature move:** {{the one recognizable gesture — e.g. "serif-italic overlay word breaking every display line, rotated -2°"}}

| Role | Face | Size | Line | Weight | Tracking | Notes |
|---|---|---|---|---|---|---|
| hero | {{...}} | {{clamp}} | {{lh}} | {{w}} | {{tr}} | {{transform/style}} |

## Spacing & shape

Grid {{8}}pt · section gap `{{sectionGap}}` · container `{{containerMax}}` · gutter `{{gutter}}`
Radius `{{radius}}` ({{what that posture means}}) · hairline `{{hairline formula}}`

## Layout grammar

- Splits: {{62/38 etc — the sanctioned ratios}}
- Overlap moves: {{which primitives, where}}
- Rhythm: {{density alternation rule for this site}}
- {{2-4 more concrete rules}}

## Motion

Policy **{{policy}}** — {{one line of what that means here}}.
Easing `{{standard}}` · durations {{fast/base/slow/reveal}} · reduced-motion: settled states (scaffold-enforced).
Ambient: {{noise/cursorGlow status}}.
**Banned modules:** {{list}} — QA greps for these.

## Imagery

Style **{{style}}** · {{cameras/lenses/lighting/grade summary}}
Formula: `{{image formula}}`
Avoid: {{avoid list}}

## Voice

Tone: {{tone}} · Adjectives: {{adjectives}}
Style: {{writingStyle}}
**Banned phrases:** {{list}}

## Per-section audit checklist

Before any section ships: tokens only · pairing present (no solo-face
sections) · asymmetry or written reason · hairlines visible · reduced-motion
settled state · copy passes voice rules · mobile 375 clean.
