# Haazel Gap Analysis — basic sites → $10k-tier websites

Where the system stood at v0.1, what v0.2 closes, and what still separates a
haazel build from a top-tier agency engagement. Audit-verified against the
plugin, the scaffold, and five real builds (the-classic-tee, yokai-izakaya,
torotoro-site, skyfitness, hmj-railings).

## The ladder

| Tier | What it looks like | Who delivers it |
|---|---|---|
| Template site (~$0–500) | Theme preset, stock sections, default fonts, no system | Any builder |
| v0.1 haazel | Good cinematic one-pagers — but hand-made each time (~1,400 lines of manual work per site), one archetype only | Haazel 0.1 |
| v0.2 haazel | Multi-archetype, tokenized design systems, layout-DNA component library, gated interactive pipeline, agent delegation | **Haazel 0.2 (this release)** |
| $10k engagement | Everything below **plus** the human column | Agency + haazel |

## Gap map

| Dimension | v0.1 reality (audit evidence) | v0.2 closes it with | Still human ($10k tier) |
|---|---|---|---|
| **Archetypes** | Cinematic-only; HARD RULES mandated CursorGlow/NoiseOverlay on every build, contradicting its own presets | 6 archetypes (cinematic, saas, app, leadgen, commerce, editorial) each with its own reference: layout grammar, motion policy, bans, recipes | Novel archetypes / hybrid IA designed per client |
| **Design system** | Hand-authored per site (DESIGN_SYSTEM.md/.html existed only where someone wrote them); broken setup-brand.ts; light-scheme sites literally impossible (`dark` hardcoded on `<html>`, Geist hardcoded in `@theme`) | `design/tokens.json` → `tokens:apply` codegen (oklch colors, next/font pairing incl. axes, scheme class, brand.config, package name); MD + **HTML visual preview** mandatory; WCAG contrast math before approval | Full brand identity design; print/social systems; licensed type |
| **Component library** | 8 generic demo sections + 34 cinematic modules with 0/34 reduced-motion, 2/34 touch handling, hex defaults (`#8b5cf6`), phantom components in docs | 9 layout primitives (LayeredHeadline, OverlapField, EditorialSplit, OffsetGrid, BleedImage, CaptionRail, ScrollingText, DeviceFrame, SectionShell) + 5 section packs (~37 components) composing them; all 35 cinematic modules reduced-motion-safe, pointer-gated, token-driven; single COMPONENT_CATALOG.md + `check:catalog` drift gate | Bespoke signature interactions (WebGL, shaders, custom cursors beyond library) |
| **Layout quality** | Sections read as blocks; overlap/font-pairing/broken grids only when hand-built (classic-tee's 1,388 bespoke lines) | Layout DNA is the library: pairing collages, deliberate overlap, 62/38 splits, offset grids, kinetic type — banned-pattern QA greps enforce it | Art-direction iterations with the client across rounds |
| **Interactivity of the workflow** | "PAUSE" prose; no real gates; no direction choice | AskUserQuestion gates: batched intake, extraction corrections, **2–3 HTML direction boards to pick from**, design-system approval, section plan, staged asset approvals | Workshops, stakeholder alignment |
| **Cost control / models** | Everything sequential in one frontier-model context | Fable plans/designs/reviews; haiku agents scout/run-assets/QA; sonnet agents build sections/copy — declared in plugin `agents/` with model frontmatter | — |
| **Assets** | FAL-only; hardcoded WaveSpeed curl loops + litterbox.catbox.moe temp hosting; manual polling | Provider matrix with runtime detection: **Higgsfield MCP** (main-thread) / FAL scripts (`@fal-ai/client` native upload — litterbox and WaveSpeed loops deleted) / verified stock / CSS-only; staged image→video gates; per-asset cost manifest; ffmpeg frame extraction with auto frameCount manifest | Real photo/video shoots; talent; location |
| **Copy** | Model-written inline, voice rules scattered | Voice tokenized (tone/banned/style); orchestrator writes leads, copywriter agent expands; [NEEDS-FACT] markers forbid fabrication | Conversion copywriting engagement; message testing |
| **SEO** | Metadata lib existed; sitemap listed dead routes; JSON-LD emitted empty NAP fields | Route registry drives sitemap; archetype-correct JSON-LD; programmatic city-page pattern (leadgen); meta limits enforced in copy step | Keyword research; content strategy; link building |
| **Conversion** | Forms were `setTimeout` stubs shipped to prod | QuoteForm posts to real `/api/quote` (Resend via env, honeypot); phone-forward leadgen architecture; StickyBuyBar; CTA architecture per archetype | Analytics, A/B testing, CRO cycles (cro-audit skill pairs well) |
| **Accessibility** | Zero `prefers-reduced-motion` anywhere in src/; hover-only affordances broken on touch | Library-wide reduced-motion settled states + `usePointerFine` gates; contrast floors in hard rules + design-system math; labels/focus-visible in section spec + QA | Full WCAG audit with assistive-tech testing |
| **Ship hygiene** | Stale scaffold demo routes shipped to production (classic-tee /about had agency demo copy + broken image); package.json stayed "scaffold" on 5 of 7 sites | `prune-site.ts` (routes, nav, Footer, sitemap, package name) + QA leftover-reference warnings; hygiene is Phase 8, not an afterthought | Staging environments; launch runbooks; monitoring |
| **Maintenance** | Commands were byte-copies of skills (~1,249 duplicated lines, already drifted); 14-vs-34 component contradiction; stale Sanity tool names; unpinned degit; installed cache one commit stale | Thin command wrappers; catalog single-source + drift gate; verified Sanity surface; degit pinned to tags; RELEASING.md documents the three-copy sync | — |
| **Performance** | Unmeasured; committed multi-MB assets | Asset budgets in QA (600KB img / 8MB video); build-green gate | Lighthouse budget CI; CDN/image pipeline tuning |
| **Legal/ops** | Privacy/terms demo pages, untouched | Prune-or-keep decision at intake; flagged in gap analysis per build | Reviewed policies; cookie compliance |

## What v0.2 deliberately does NOT automate

Custom photography · brand strategy · paid checkout flows (commerce links
out to Stripe/Shopify) · analytics/experimentation · WCAG certification ·
deployment (git-first stays manual by design).

## Per-build honesty

Every v0.2 build ships its own `design/GAP-ANALYSIS.md` (template in
`plugins/haazel/templates/gap-analysis.md.tpl`) so the client-facing story
of "what you got vs what $10k more buys" is generated per project, not
asserted generically.
