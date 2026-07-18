---
name: haazel-design-system
description: Generate or regenerate a tokenized design system — design/tokens.json (machine source of truth), DESIGN_SYSTEM.md (readable spec), and DESIGN_SYSTEM.html (visual preview) — then apply it to a haazel scaffold via npm run tokens:apply. Trigger on "design system", "design tokens", "tokenize the brand", "regenerate the theme", "change the palette/fonts", or /haazel-design-system. Also invoked as Phase 4 of haazel-build.
---

# Haazel Design System — the tokenizer

One brand → three artifacts, always in this order:

1. `design/tokens.json` — the machine source of truth (schema:
   `templates/tokens.schema.json` in this plugin)
2. `design/DESIGN_SYSTEM.md` — the readable spec
3. `design/DESIGN_SYSTEM.html` — the visual preview (**mandatory** — the
   user reviews pixels, not markdown)

Then `npm run tokens:apply` writes the system into the scaffold
(globals.css oklch vars, layout.tsx fonts + scheme class, brand.config.ts,
package name). Nothing is themed by hand.

## Inputs

From haazel-build: chosen direction board + archetype + BRAND_BRIEF +
inspiration. Standalone: run a mini-intake — one AskUserQuestion batch:
archetype, color scheme (dark/light/dual), 2–3 brand adjectives, any locked
colors/fonts. If a haazel project exists in cwd, read its current
`design/` first — this may be a regeneration, not a green-field.

## Composing tokens.json

Work through the schema top-down. The judgment calls:

**Colors.** Build the semantic sets (18 keys per scheme) from the brand
palette, not the other way around: pick the canvas (background) and its
foreground first, then card/popover as near-canvas steps, then primary =
the brand's action color, accent = the sharp note (may equal primary),
muted/secondary as quiet steps. Every hex; apply-tokens converts to oklch.
- **Verify contrast mathematically before writing the file**: compute WCAG
  ratios for foreground/background, mutedForeground/background,
  primaryForeground/primary, cardForeground/card. Floors: 4.5:1 body pairs,
  3:1 large-type/UI pairs. Adjust lightness until they pass — do not
  eyeball oklch.
- Record usage discipline in `palette` (`maxShare`) and `rules`
  ("accent never fills blocks") — QA reads these.

**Typography.** Four roles (display/heading/body/mono) — a PAIRING, not one
family with weights. Exact Google Fonts names (verify the name exists —
when unsure, WebFetch fonts.google.com for it). Variable-font axes (opsz)
when the face rewards it. Scale: clamp() for hero/display/heading; overline
gets the widest tracking; never reuse a generic default stack the archetype
reference warns against.

**Shape/spacing.** radius is a statement (0px heritage/brutalist,
0.75rem+ friendly SaaS); sectionGap clamp sets the breathing; containerMax
+ gutter per archetype density.

**Motion.** policy from the archetype (cinematic|expressive|restrained|
minimal) unless the direction board said otherwise; easing stays the house
curve unless the direction demands its own; fill `bannedModules` from the
archetype's ban list + anything the direction rules out; `ambient` per
direction (noise/cursorGlow are cinematic-family only).

**Voice + imagery.** From BRAND_BRIEF/intake: tone, adjectives,
bannedPhrases (include the archetype's clichés), writingStyle one-liner;
imagery style + prompt formulas + cameras/lighting/grade the haazel-assets
skill will consume.

Validate mentally against the schema (required keys, hex formats, enums)
before writing. Then write the file.

## Rendering the two documents

**DESIGN_SYSTEM.md** from `templates/design-system.md.tpl`: positioning
paragraph, palette table WITH usage shares and rules, type pairing +
"signature move" (the one recognizable typographic gesture), scale table,
spacing/layout grammar (split ratios, overlap moves, container), module
policy incl. bans, imagery treatment + formulas, voice rules. Concrete —
every row actionable, no vibes-only prose.

**DESIGN_SYSTEM.html** from `templates/design-system.html.tpl`: inline the
actual values (swatches with hex+oklch+share, live Google-Fonts specimen of
the real pairing, type ramp at true sizes, spacing bars, radius/shadow
chips, button/card/hairline specimens, motion policy statement). Fully
self-contained (Google Fonts <link> allowed). This file is what the user
approves.

## Apply + verify

In a scaffold project:

```
npm run tokens:apply
npm run tokens:check
npx next build
```

Report the per-file diff summary apply prints. Build failure = fix tokens
(usually a font name or missing semantic key), re-apply — never hand-edit
inside HAAZEL markers.

**Gate:** open DESIGN_SYSTEM.html (and the scaffold home if the dev server
is running) — "This is the system. Adjustments?" Iterate tokens → apply →
re-render until approved. Small tweaks go through tokens.json + re-apply,
never through the generated files.

No scaffold present (system-only engagement): deliver the trio and stop
after approval.
