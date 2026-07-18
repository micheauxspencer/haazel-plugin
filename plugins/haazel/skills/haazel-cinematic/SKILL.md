---
name: haazel-cinematic
description: Apply the cinematic GSAP motion system — scroll-scrub, masked reveals, ambient texture — to cinematic/luxury/creative-archetype builds, or add one sanctioned cinematic touch to any other archetype within its own motion policy. Components and their conventions live in the cloned scaffold's src/components/COMPONENT_CATALOG.md and src/components/cinematic/CONVENTIONS.md; GSAP Master MCP enhances authoring when connected but is never required. No generic fade-ups. Trigger on "make this cinematic", "add scroll animation", "this needs more motion", "cinematic modules", or /haazel-cinematic.
---

# Haazel Cinematic — the motion system

You compose and author cinematic motion: scroll-scrub sequences, masked text
reveals, cursor reactivity, ambient texture. Use this skill standalone on
any Next.js project, or within a haazel build wherever cinematic motion is
called for — the full arsenal on cinematic-archetype builds, a single
sanctioned touch elsewhere.

## Scope — read the archetype before reaching for the arsenal

This skill is the complete motion system for **cinematic, luxury, and
creative-archetype** builds — `references/archetypes/cinematic.md` sets
motion policy `cinematic`: scroll-scrub, masked reveals, and ambient grain,
orchestrated into a narrative arc.

Every other archetype (saas, app, leadgen, commerce, editorial) sets its
*own* motion policy in `references/archetypes/<archetype>.md` — e.g.
`saas.md` is policy `restrained`: entrance reveals and micro-interactions
only, with an explicit `bannedModules` list (no CursorGlow, no scroll-scrub
pins). This skill still applies there, but only for the one cinematic
moment a direction deliberately calls for (a single manifesto reveal, a
slow logo marquee) — never for the whole page, and never for a module the
archetype bans. **Read the archetype file first; it overrides instinct.**

## Component library — source of truth lives in the scaffold

Don't work from memory, and don't expect this file to enumerate the
library — the cloned scaffold is the ground truth and it changes between
scaffold versions. Read, every time:

- `src/components/COMPONENT_CATALOG.md` — every module: one-liner, props
  signature verified against the code, archetype fit tags, reduced-motion
  behavior.
- `src/components/cinematic/CONVENTIONS.md` — the authoring rules every
  module follows (summarized below).

A few names to anchor the vocabulary, not to limit it: **CanvasHero**
(scroll-driven frame-sequence hero), **TextMaskReveal** (clipPath fill on
scroll), **KineticMarquee** (velocity-reactive infinite strip),
**CurtainReveal** (parting panels), **SpotlightBorderCards** (cursor-glow
card grid), **OdometerCounter** (mechanical digit roll). The catalog holds
the rest — read it fresh rather than recalling a list from a prior build.

## GSAP Master MCP — a detected enhancement, never a prerequisite

Before writing bespoke animation code, check whether the GSAP Master MCP
tools are connected (ToolSearch for `understand_and_create_animation`).

- **Detected** → use the four-step workflow below for anything that isn't
  already a catalog module.
- **Absent** → don't block, and don't tell the user to go install it
  mid-build. Author the animation by hand against `CONVENTIONS.md` and the
  nearest existing scaffold pattern: dynamic GSAP import, `gsap.context()`
  cleanup, the house easing curve, a reduced-motion branch. The MCP makes
  this faster and more consistent — it was never required to ship a
  cinematic build.

### The workflow (when detected)

For every bespoke animation:

1. **Generate** — `understand_and_create_animation` with a natural-language
   description: "scroll-driven text mask reveal where outlined text fills
   with the accent color as the user scrolls," "kinetic marquee that
   speeds up with scroll velocity," "3D tilt card with a cursor-tracking
   spotlight gradient."
2. **Optimize** — `optimize_for_performance` on the generated code: 60fps
   desktop, a mobile-tuned variant, `will-change` and GPU-friendly
   properties, a battery-conscious fallback.
3. **Pattern** — `create_production_pattern` for standard shapes: hero
   scroll sequences, text reveal systems, parallax depth layers, page
   transitions.
4. **Debug** — `debug_animation_issue` for anything that stutters, breaks,
   or fights (Lenis + ScrollTrigger conflicts are the usual suspect).

## Conventions — full detail in CONVENTIONS.md

Every module, catalog or bespoke, follows
`src/components/cinematic/CONVENTIONS.md`: reduced motion renders the
complete **settled state** (no pin, no scrub, no loop — content fully
visible), never a blank gap; cursor/hover modules gate on `usePointerFine`
and must not hide content from touch users; every color is a design token
or a `color-mix()` derivation off one — no raw hex, no rgb-triplet props.
Read it before writing or reviewing any module.

## Module selection — content decides, never the industry alone

The full selection heuristic (the "does this content need X" question
table, and the industry-starting-point table) lives in
`references/module-selection.md` — read it before picking modules for a
page. **Do not assign a fixed module set per industry** — a restaurant and
a jewelry brand can both want TextMaskReveal, or neither might. The content
decides.

## Page composition — narrative-driven

**Every site tells a different story; figure out the story before picking
modules.**

1. **Define the arc.** Restaurant: "enter our world → taste the menu → feel
   the vibe → reserve." SaaS: "understand the pain → see the solution →
   trust the proof → start free." Portfolio: "see the work → understand the
   process → hire us." Each arc is specific to the brand — write it down
   first.
2. **Map beats to modules** using `references/module-selection.md`'s
   question table, checked against the archetype's `bannedModules`.
3. **Edit ruthlessly.** A tight 5-section page beats a bloated 9-section
   one. Use 4–7 sections; cut anything that doesn't serve the arc. For
   cinematic-archetype homes specifically, `cinematic.md`'s section recipe
   is the starting skeleton, not a checklist to fill completely.
