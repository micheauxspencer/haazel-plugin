---
name: haazel-assets
description: Generate visual assets for a site — hero videos, section imagery, CanvasHero frame sequences — through whichever provider is actually available: Higgsfield MCP, FAL.ai scripts, verified stock, or CSS-only. Staged approvals (images before any paid video), per-asset cost manifest. Trigger on "generate a hero video", "make images for the site", "asset pipeline", or /haazel-assets. Also invoked as Phase 6 of haazel-build.
---

# Haazel Assets — provider-abstracted pipeline

Turn an asset plan into files in `public/`, spending nothing the user
hasn't approved, and manifest everything in `design/ASSETS.md`.

## Step 1 — Detect providers (silent, every invocation)

| Provider | Detection | Runs where |
|---|---|---|
| Higgsfield MCP | ToolSearch for `generate_image`/`generate_video` (+ `upscale_image`, `remove_background`, `models_explore`) | **Main thread** — connector MCP; subagents may not see it |
| FAL | `FAL_KEY` in env or project `.env.local` | `haazel-asset-runner` agent via `npm run gen:image`/`gen:video` |
| Stock | always available | scout verifies 200s before use |
| CSS-only | always available | no generation; tokens carry the visuals |
| ffmpeg | `ffmpeg -version` exit 0 | frames for CanvasHero; absent → mp4 `VideoBackground` fallback |

Present only what exists. Higgsfield absent + user wants it → tell them to
connect the Higgsfield connector (claude.ai connectors) or set up FAL
(`FAL_KEY`), then continue with what's available.

## Step 2 — Plan + cost gate

Build the plan table (from SECTION_PLAN or the request): asset name →
section → type (image/video/frames) → provider → size/model → prompt →
est. cost (numbers from `references/asset-costs.md`). Show the table with
the total. **Gate: approve the plan** (skip only if haazel-build already
gated this exact plan). Images may be approved as a batch; **every video
clip is its own explicit cost acknowledgment** — no exceptions.

## Step 3 — Prompts

Compose from `design/tokens.json` imagery: formulas + cameras/lenses/
lighting/grade + avoid list, subject from the section's job. One prompt per
asset, written down BEFORE generating (they go in the manifest). Brand
consistency beats per-image creativity — same grade, same lens language
across the set.

## Step 4 — Images first

- **Higgsfield path (main thread):** when unsure of the best model, call
  `models_explore(action:'recommend')` with the goal; then `generate_image`
  per asset. Download outputs to `public/images/<name>.jpg`. Post-process
  (resize/optimize) via `haazel-asset-runner` if needed.
- **FAL path (delegate):** hand `haazel-asset-runner` the approved plan
  rows; it runs `npm run gen:image -- <name> "<prompt>" [size] [--model …]`.
- **Stock path:** scout verifies candidate URLs (200 + image content-type),
  download keepers, record source URLs for attribution.

**Gate — image review:** show every image (paths + open in browser).
Regenerate rejects with adjusted prompts (note the adjustment). Nothing
proceeds to video until stills are approved — video seeds come from
approved stills.

## Step 5 — Video (paid, per-clip gate already given)

- **Higgsfield:** `generate_video` from the approved seed still + motion
  prompt (subtle, loopable: "slow push-in", "drifting fog", no cuts).
  `upscale_video` only if the plan says so.
- **FAL:** `npm run gen:video -- <name> <seed> "<prompt>" [--model standard|pro]`
  via asset-runner.
- Verify: file plays, duration ≈ expected, loops acceptably (first/last
  frame proximity). One re-roll per clip max without going back to the user.

## Step 6 — Frames or fallback

CanvasHero sequences: `npm run frames -- public/videos/<name>.mp4 <sequence>
--count 120` (asset-runner). The script writes `manifest.json` with the
exact `frameCount` + `framePath` — wire those props from the manifest,
never hand-count. ffmpeg missing (exit 2): use `VideoBackground` with the
mp4 + poster instead, and record the degradation.

## Step 7 — Manifest

Update `design/ASSETS.md`: table of asset → section → provider → model →
prompt → file → bytes → cost (actual), plus running total and rejected
takes (with why). This is the receipt the delivery summary quotes.

## Editing existing assets

Prefer the dedicated Higgsfield tools over re-generation:
`upscale_image`/`upscale_video` (resolution), `outpaint_image` (extend
composition), `remove_background` (cutouts), `reframe` (aspect change).
FAL-only setups: regenerate with the adjusted prompt.

## Rules

- Nothing paid without its recorded approval; when in doubt, re-ask.
- Every generated file lands under `public/` with a manifest row — no
  orphan assets.
- Optimize before ship: images >600KB get resized/recompressed (sharp via
  asset-runner); videos >8MB get re-encoded or trimmed.
- No text, watermarks, or fake UI in generated imagery (enforce via avoid
  list).
