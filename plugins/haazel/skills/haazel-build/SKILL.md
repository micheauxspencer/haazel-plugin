---
name: haazel-build
description: End-to-end client website builder for any archetype — cinematic brand sites, SaaS marketing, dashboards/app UIs, local lead-gen, e-commerce drops, editorial. Interactive phase chain with approval gates, tokenized design systems (tokens.json + DESIGN_SYSTEM.md/.html), Higgsfield or FAL asset pipeline, model-tiered agent delegation, git-first (deployment manual). Trigger on "build a site", "new client site", "redesign <domain>", "spin up a website for X", or /haazel-build.
---

# Haazel Build — the orchestrator

You are building a client-grade website from a one-line brief. This skill is
the conductor: it gathers decisions at gates, delegates execution to cheap
agents, and keeps taste, planning, and review in the main thread.

**Model & delegation policy (read once, apply throughout):**
- The MAIN THREAD (the frontier model) does: interpretation, design
  direction, copy leads, section briefs, all reviews, and every user
  interaction. Subagents cannot ask the user questions — gather everything
  at gates BEFORE delegating.
- DELEGATE to the plugin agents (they carry cheaper models):
  `haazel-scout` (bulk crawling/verification), `haazel-copywriter` (copy
  expansion), `haazel-section-builder` (section implementation from briefs),
  `haazel-asset-runner` (CLI asset generation/post-processing),
  `haazel-qa` (mechanical checks). Launch independent agents in parallel.
- Connector-level MCPs (Higgsfield, browser tools, Sanity) are called from
  the MAIN THREAD only — never assume a subagent can reach them.

**Rules:** `references/hard-rules.md` is global law. The chosen archetype's
file in `references/archetypes/` layers its own mandates (motion policy,
module bans, section recipes). Read both before Phase 3.

**Artifacts:** every phase writes to the project's `design/` directory:
`BRIEF.md`, `extraction.json`, `BRAND_BRIEF.md`, `directions/board-*.html`,
`tokens.json`, `DESIGN_SYSTEM.md`, `DESIGN_SYSTEM.html`, `SECTION_PLAN.md`,
`COPY.md`, `ASSETS.md`, `QA_REPORT.md`, `GAP-ANALYSIS.md`. These are the
project's memory — later phases and future sessions read them instead of
re-deriving.

---

## Phase 0 — Intake (one gate, everything decided)

Parse the invocation first. `/haazel-build new acme.com — SaaS site` pre-answers
domain + archetype; `redesign <url>` sets mode=redesign. Don't re-ask what
the one-liner already said.

**Silent runtime detection (before asking anything):** determine which asset
tiers are actually available —
- Higgsfield MCP: ToolSearch for `generate_image` / `generate_video`
  (Higgsfield server tools). Present only if found.
- FAL: `FAL_KEY` in env or `.env.local`.
- ffmpeg: `ffmpeg -version` exit 0 (affects CanvasHero frame sequences; if
  absent, video heroes use the mp4 VideoBackground path).
- Browser tools (for recon): Claude Browser pane tools, else claude-in-chrome,
  else WebFetch-only degraded mode.

**Gate 0 — ONE batched AskUserQuestion (≤4 questions):**
1. **Archetype** (skip if given): cinematic brand site / SaaS marketing /
   dashboard-app UI / local lead-gen / commerce drop (editorial via Other).
2. **Source**: analyze an existing domain / net-new brand / redesign
   in-place of an existing repo.
3. **Scope + CMS**: Home one-pager / Home + up to 3 pages / full multi-page
   with programmatic SEO pages; blog+CMS yes/no.
4. **Asset tier** (options limited to what detection found, with costs from
   `references/asset-costs.md`): Premium AI (Higgsfield MCP) / Premium AI
   (FAL) / Stock (verified Unsplash) / CSS-only (token-derived gradients,
   SVG, type). Note: video is a separate per-clip approval later regardless.

Then confirm working directory + slug in one short message, and offer the
inspiration intake: "Drop screenshots or URLs into `design/inspiration/`
(or paste URLs now) and I'll fold them into the direction work — optional."

Write `design/BRIEF.md` recording every answer + detection results.

## Phase 1 — Recon (only when a source domain exists)

Main thread: run the live-DOM extraction from
`references/extraction-snippets.md` on the domain (computed-style color
frequency, font stacks, logo, nav map, socials/phones/emails) + full-page
screenshots of home and 1–2 inner pages. Never settle for a quick WebFetch
when browser tools exist; if only WebFetch is available, mark
`"confidence": "low"` in the output.

In parallel, launch `haazel-scout`: bulk copy dump per page, link map,
contact/hours/service inventory; for leadgen archetype also the market scan
(competitor headlines, review counts, city/service keywords).

The main thread interprets both into `design/extraction.json` +
`design/BRAND_BRIEF.md` (what the brand IS vs what the old site merely
looks like — flag dated-but-loved elements vs accidental defaults).

**Gate 1:** present the Brand Extraction Report (colors ranked by actual
usage, fonts, voice read, imagery read). Ask: "Corrections before this
becomes the design foundation?"

## Phase 2 — Scaffold clone (mechanical, early on purpose)

```
npx degit micheauxspencer/haazel-scaffold#v0.2.0 <slug>
cd <slug> && npm install
```
Pin the tag. If degit fails (Windows long paths, cache staleness — retry
with `--force` first), fall back to
`git clone --branch v0.2.0 --depth 1 https://github.com/micheauxspencer/haazel-scaffold <slug>`
then delete `.git` and `git init`.

Cloning now means every later phase grounds against the real
`src/components/COMPONENT_CATALOG.md` — never plan against remembered
component names.

## Phase 3 — Direction boards (main-thread taste, user's choice)

Read `references/archetypes/<archetype>.md` + BRAND_BRIEF + anything in
`design/inspiration/`. Compose **2–3 distinct art directions** as
self-contained HTML boards from `templates/direction-board.html.tpl` into
`design/directions/board-{a,b,c}.html` — each: palette swatches with usage
shares, Google-Fonts type specimen (pairings live-rendered), radius/density
feel, one hero sketch block, motion-policy statement, three adjectives.
Directions must genuinely differ (e.g. "heritage editorial" vs "electric
minimal"), not three tints of one idea.

**Gate 3:** open the boards in the browser; user picks A/B/C or a mix
("A's type with B's palette" is a valid answer — merge deliberately).

## Phase 4 — Design system (invoke haazel-design-system)

Invoke the **haazel-design-system** skill with: chosen direction, archetype,
BRAND_BRIEF, scope. It produces `design/tokens.json` (validated against the
plugin's `templates/tokens.schema.json`, WCAG-checked), renders
`DESIGN_SYSTEM.md` + `DESIGN_SYSTEM.html`, then runs:

```
npm run tokens:apply && npm run tokens:check && npx next build
```

**Gate 4:** open `DESIGN_SYSTEM.html` (the visual spec is the deliverable —
never markdown alone). Approve or adjust; re-run apply until approved.

## Phase 5 — Content architecture

Main thread writes `design/SECTION_PLAN.md`: the sitemap (per scope), and per
page a narrative arc table — section order, its job in the story, energy
level (the rhythm must vary: no three quiet sections in a row, no wall of
loud), the component/module for it (FROM the catalog + archetype recipes),
the asset it needs, the copy lead. Check module choices against
`design/tokens.json` `motion.bannedModules` and the archetype's bans.

Main thread writes the load-bearing copy itself: H1s, hero lines, manifesto,
section headlines — voice per tokens.json. Then launch `haazel-copywriter`
with SECTION_PLAN + voice rules to expand supporting copy into
`design/COPY.md` (body paragraphs, FAQs, microcopy, meta descriptions).
Review the expansion — banned phrases, fabricated claims, flat rhythm.

**Gate 5:** present SECTION_PLAN (this is the cheapest moment to change
course — say so).

## Phase 6 — Assets (invoke haazel-assets)

Invoke the **haazel-assets** skill with SECTION_PLAN's asset table. It
enforces its own staging: plan+cost table → approval → images → **image
review gate** → per-clip video cost acknowledgment → generation → frames
(ffmpeg) or mp4 fallback. Higgsfield runs in the main thread (MCP); FAL runs
through `haazel-asset-runner` (`npm run gen:image` / `gen:video`). Everything
lands in `public/` and is manifested in `design/ASSETS.md` with per-asset
provider, prompt, and cost.

CSS-only tier: skip generation; the design system's gradient/SVG/type rules
carry the visuals.

## Phase 7 — Build sections

For each page, the main thread writes a **build brief**: section list with
exact component choices + props, token utilities to use, copy refs (COPY.md
anchors), asset paths, layout notes (which primitives, where the overlap
breaks, rhythm), and the banned list. Include the scaffold's
`src/components/sections/SECTION_SPEC.md` + `src/components/COMPONENT_CATALOG.md`
paths as required reading.

Launch `haazel-section-builder` agents in parallel — one per page (or one
per 3–4 sections on heavy pages). They write `src/components/sections/<slug>/`
compositions and the page files.

The main thread then does the integration pass ITSELF: nav wiring, footer,
cross-page rhythm, section transitions, `layout.tsx` ambient modules per
tokens (`motion.ambient`), metadata/OG per page.

## Phase 8 — Ship hygiene

```
npm run prune -- --keep <kept-routes> --write
```
Then verify: navLinks/Footer match live routes, `sitemap.ts` clean,
`package.json` name = slug, `robots.ts`, OG image set, JSON-LD type right
for the archetype (leadgen → LocalBusiness with real NAP from BRIEF),
`.env.example` accurate. Fix every prune warning.

## Phase 9 — QA (mechanical agent + main-thread eye)

Launch `haazel-qa`: `npm run build`, `npm run tokens:check`,
`npm run check:catalog`, internal-link check, image 200s/paths, grep gates
(emoji, hex literals in sections/, lorem, banned phrases, banned modules,
`href` to pruned routes). It writes the mechanical half of
`design/QA_REPORT.md`.

Main-thread visual pass (never delegated): dev server up, screenshot every
page at 375 / 768 / 1440 + `prefers-reduced-motion`, judge against
DESIGN_SYSTEM.md and the haazel-design checklist. Fix or delegate fixes;
re-shoot until it passes. For any section that fights you twice, invoke the
**haazel-design** skill on it.

Write `design/GAP-ANALYSIS.md` from `templates/gap-analysis.md.tpl`: what a
template would have given / what this build did (bespoke type system, asset
direction, motion system, SEO architecture, hygiene) / what still separates
it from a top-tier engagement (custom photography, conversion copy audit,
analytics, full a11y audit, perf budget, legal pages) — honest, itemized.

## Phase 10 — Git + optional CMS

```
git init && git add -A && git commit
```
Commit message: what was built, archetype, direction chosen. **Never deploy
automatically** — hand the user the repo + `npx vercel` instructions.

If BRIEF said blog: invoke **haazel-auto-blog** now (Sanity project, schema,
scheduled task), second commit.

Delivery summary: what shipped, the design-system trio paths, ASSETS costs
total, QA results, GAP-ANALYSIS highlights, exact next steps (deploy, DNS,
env vars, real content swaps).

---

## Redesign mode

Same chain with: Phase 1 mandatory and deeper (screenshot EVERY template,
inventory what ranks — don't break URLs that earn traffic); Phase 2 asks
"fresh scaffold + migrate" (default) vs "in-place restyle" (then tokens:apply
+ section-by-section replacement, no prune of live routes without a redirect
plan); Phase 8 adds a redirect map for any changed URL.

## Failure discipline

- A gate answer of "Other" is an instruction, not an obstacle — fold it in.
- If a phase's tool is missing (no browser, no ffmpeg, no FAL key), degrade
  along the documented path and RECORD the degradation in BRIEF.md; never
  silently skip quality.
- If `npm run build` breaks after an agent's work, the agent that wrote it
  gets the error verbatim to fix; the main thread only hand-fixes after two
  failed rounds.
