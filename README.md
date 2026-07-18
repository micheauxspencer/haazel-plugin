# Haazel — Client Site Factory for Claude Code

Build client-grade websites of ANY archetype from a one-line brief:
cinematic brand sites, SaaS marketing, dashboards/app UIs, local lead-gen,
e-commerce drops, editorial. Interactive gated workflow, tokenized design
systems, a layout-first component library, Higgsfield/FAL asset pipeline,
and model-tiered agent delegation. Git-first — deployment stays manual.

**v0.2.0** — see [GAP-ANALYSIS.md](GAP-ANALYSIS.md) for what this release
closes on the road from template sites to $10k-tier builds, and
[RELEASING.md](RELEASING.md) for the release/sync process.

## Skills (7)

| Skill | Purpose |
|---|---|
| `/haazel-build` | The orchestrator: 10-phase interactive chain (intake → recon → scaffold → direction boards → design system → content architecture → assets → sections → hygiene → QA → git) with approval gates at every consequential step |
| `/haazel-design` | The section surgeon — improve any single section/layout against the project design system + a 15-item anti-pattern checklist, with before/after proof |
| `/haazel-design-system` | Brand → `design/tokens.json` + `DESIGN_SYSTEM.md` + `DESIGN_SYSTEM.html` (visual preview), applied to the scaffold via `npm run tokens:apply` |
| `/haazel-brand-analyzer` | Live-DOM brand extraction (computed-style color frequency, fonts, voice) → `extraction.json` + `BRAND_BRIEF.md`, with a browser→WebFetch detection ladder |
| `/haazel-assets` | Provider-abstracted assets: Higgsfield MCP · FAL scripts · verified stock · CSS-only, with staged cost gates and a per-asset manifest |
| `/haazel-cinematic` | The GSAP motion system for cinematic-family builds; components live in the scaffold's catalog; GSAP Master MCP is a detected enhancement |
| `/haazel-auto-blog` | Sanity CMS + scheduled ACE auto-blogging with generated images |

## Agents (model-tiered)

Planning, design, copy leads, and review run in the main thread. Execution
delegates to plugin agents: `haazel-scout` (haiku — crawling/verification),
`haazel-section-builder` (sonnet — sections from briefs), `haazel-copywriter`
(sonnet — copy expansion), `haazel-asset-runner` (haiku — CLI generation),
`haazel-qa` (haiku — mechanical checks).

## Archetypes

`references/archetypes/{cinematic,saas,app,leadgen,commerce,editorial}.md` —
each defines layout grammar, type/color guidance, a motion policy with
banned modules, section recipes, copy voice, and SEO shape. Global law:
`references/hard-rules.md`.

## The scaffold

Builds clone [`micheauxspencer/haazel-scaffold`](https://github.com/micheauxspencer/haazel-scaffold)
(pinned `#v0.2.0`): **82 components** — 9 layout primitives (the
anti-generic layer: LayeredHeadline, OverlapField, EditorialSplit,
OffsetGrid, BleedImage, CaptionRail, ScrollingText, DeviceFrame,
SectionShell), 35 cinematic GSAP modules (all reduced-motion-safe,
pointer-gated, token-driven), and 38 section components across saas/app/
leadgen/commerce/shared packs — plus the token codegen pipeline
(`tokens:apply`), ship-hygiene pruning (`prune`), asset scripts, and a
`/showcase` harness. Single source of truth:
`src/components/COMPONENT_CATALOG.md`.

## Install

```bash
claude plugin marketplace add micheauxspencer/haazel-plugin
claude plugin install haazel@haazel
```

Local development: `claude plugin marketplace add ./haazel-plugin`.

## Prerequisites

Required: Node 20+, npm, git. Optional (runtime-detected, everything
degrades gracefully): Higgsfield MCP connector or `FAL_KEY` (premium
assets), ffmpeg (CanvasHero frames), browser tools (live-DOM recon),
Sanity MCP + scheduled-tasks (auto-blog), GSAP Master MCP (animation
authoring), `RESEND_API_KEY` (quote-form delivery).

## Quick starts

```
/haazel-build new acme.com — SaaS site
/haazel-build redesign yokaiizakaya.ca
/haazel-design            (then: "improve the pricing section")
/haazel-design-system     ("regenerate the palette, keep the fonts")
/haazel-assets            ("hero video for the fairway shot")
```
