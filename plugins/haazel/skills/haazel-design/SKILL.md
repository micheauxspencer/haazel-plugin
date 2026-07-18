---
name: haazel-design
description: Improve, polish, restyle, or fix any single section, layout, hero, page, or component — in haazel projects or any web project. Enforces the project design system (design/tokens.json + DESIGN_SYSTEM.md become law when present), applies the haazel anti-pattern checklist, verifies in the browser with before/after. Trigger on "improve this section", "make this hero better", "this layout feels generic", "polish the pricing section", "fix the spacing here", or /haazel-design.
---

# Haazel Design — the section surgeon

Improve ONE section, layout, or component at a time to client-grade quality.
Like a design review with commit access: diagnose against the checklist,
propose, apply, prove with before/after.

## Step 1 — Load the law

Walk up from the working file/directory looking for `design/tokens.json` +
`design/DESIGN_SYSTEM.md` (and `design/BRIEF.md` for the archetype).

- **Found → they are law.** Every fix must use those tokens, that type
  scale, that layout grammar, that motion policy. Read the archetype file in
  this plugin's `references/archetypes/` too. Never introduce values from
  outside the system; if the system itself is the problem, say so and offer
  haazel-design-system instead.
- **Not found (non-haazel project) → generic craft mode.** Extract the de
  facto tokens first (grep the project's CSS vars / tailwind theme), work
  within them, and flag drift you find. Offer to formalize with
  haazel-design-system.

In a haazel scaffold, also read `src/components/COMPONENT_CATALOG.md` and
`src/components/sections/SECTION_SPEC.md` — fixes should compose existing
primitives (SectionShell, LayeredHeadline, CaptionRail, EditorialSplit,
OverlapField, OffsetGrid, BleedImage, ScrollingText, DeviceFrame) before
inventing new structure.

## Step 2 — Diagnose

Read the target's code fully. If a dev server is available, screenshot the
section at 1440 and 375 (plus dark/light if the project is dual-scheme).
Then run the checklist and write down every hit — the diagnosis is the
deliverable's spine.

## The anti-pattern checklist

Each item: the tell → the fix recipe.

1. **Uniform card grid** (3+ identical cells, icon-top-center) → break it:
   OffsetGrid stagger, one emphasized cell, or a ruled list. Give ONE thing
   visual priority.
2. **Emoji as icons** → inline SVG / lucide, sized and colored via tokens.
3. **Invisible borders** (border on same-luminance bg) → hairline formula:
   `color-mix(in oklab, var(--foreground) 10–15%, transparent)`.
4. **Hardcoded hex/rgba** → nearest semantic token or color-mix derivation.
5. **50/50 split** → EditorialSplit 62/38 or 58/42; give the dominant side
   the content that earns it.
6. **Motion wrong for policy** — generic fade-up where the system demands a
   masked rise (cinematic), or scroll-scrub inside a restrained archetype →
   match `motion.policy`; one orchestrated entrance beats five twitches.
7. **Missing reduced-motion / hover-only affordances** → `useReducedMotion`
   settled states; `usePointerFine` gates; content never hover-locked.
8. **Text over busy imagery** → scrim panel, gradient band, or backdrop
   pill; body text never sits raw on a photo.
9. **Muted-on-muted** (text below 4.5:1) → step up the foreground token;
   `--muted-foreground` is for captions, not body.
10. **Type solo / off-scale sizes** (one family everywhere; ad-hoc px) →
    pair display/heading/mono per the system; sizes from the scale
    utilities (`text-display`, `text-overline`…).
11. **Flat rhythm** (every block same padding/width) → vary density with
    the spacing tokens; full-bleed moment or inverted band to break the
    scroll monotony.
12. **Centered everything** → left-align the default; center only what
    earns it (a manifesto, a single statement).
13. **Orphaned headline words / widows** → rebreak lines by meaning
    (`<br/>` or max-width in `ch`); no single-word last lines in display
    type.
14. **Demo/lorem remnants, dead links, "scaffold" naming** → replace with
    real content or clearly-marked demo; fix targets.
15. **Gradient abuse / banned modules** (per tokens `motion.bannedModules`
    and colors.rules) → strip to the system's sanctioned treatments.

## Step 3 — Propose (gate only when large)

Rank the fixes by visual impact. Small scope (≤2 files, no API changes):
apply directly. Larger or destructive (rewriting a section's structure):
present the ranked list + intended structure first and get a yes.

## Step 4 — Apply

Make the edits. Respect the section contract (SECTION_SPEC.md) in haazel
projects: SectionShell wrapper, required-props content, server-by-default,
tokens only. Keep the diff scoped to the target section — resist adjacent
"while I'm here" edits; list them as follow-ups instead.

## Step 5 — Prove

Rebuild/reload, re-screenshot the same viewports, and present before/after
with one line per checklist item fixed. If a fix regressed anything
(overflow at 375, contrast, hydration), fix before presenting. In haazel
projects finish with `npm run tokens:check` to prove no token drift.

## Scope discipline

One section per invocation unless explicitly asked for a page-wide pass.
Page-wide: run per-section top to bottom, then one rhythm pass across the
seams (spacing cadence, alternating density, section transitions).
