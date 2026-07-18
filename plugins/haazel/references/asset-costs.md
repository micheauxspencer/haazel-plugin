# Asset Costs

Cost reference for the intake and asset-generation gates (`haazel-build` Phase
0's asset-tier question, the `haazel-assets` skill's plan+cost table). Quote
these at the gate, then re-verify live — provider pricing moves; these are
estimates, not invoices. Hard-rules #11: nothing that costs money runs without
an explicit approval recorded at the gate.

## Per-asset costs

| Provider / model | Unit | Estimated cost | Notes |
|---|---|---|---|
| FAL `recraft-v3` | 1 image | ≈ $0.04 | Atmospheric/illustrative scenes — the cheaper default for volume image needs |
| FAL `nano-banana-pro` | 1 image | ≈ $0.15 | Cleaner product-shot quality, ~4x recraft-v3 — reach for it on hero-facing shots |
| FAL Kling — standard | 5s clip | ≈ $0.25 | Base video tier |
| FAL Kling — pro | 5s clip | ≈ $0.50 | Higher-fidelity motion, ~2x the standard tier |
| Higgsfield (any model) | varies | credits-based | Cost depends on plan/model — always quote live, see below |
| Stock (Unsplash, verified license) | 1 image | $0 | Verify the URL returns 200 and the license actually permits the intended use before relying on it |
| CSS-only (gradients, SVG, type) | — | $0 | Token-derived, no generation step at all |

Kling cost scales with duration — the numbers above are the 5s base unit;
quote longer clips live rather than multiplying blind, since per-second
scaling isn't confirmed linear across tiers.

## Higgsfield — always quote live

Higgsfield is credits-based and varies by plan and model — there is no stable
flat per-asset number to hardcode here. When the Higgsfield MCP is connected,
check its balance/plans tools for the live figure before quoting a cost to the
user. When it isn't connected and a live number can't be pulled, say so
plainly: "typically cents per image, tens of cents to low dollars per clip" —
and flag that the real number needs confirming once the connector is
available, rather than presenting a guess with the confidence of a quote.

## Typical build totals

| Asset tier | Estimated total (per site) |
|---|---|
| CSS-only | $0 |
| Stock (verified) | $0 |
| Images-only (FAL, ~15–25 images) | $0.50–2 |
| Images + 2 video clips (FAL) | $1–4 |

These assume a Home + a few pages scope on the FAL pipeline. A full
multi-page build with programmatic SEO pages, or a Higgsfield premium tier,
costs more — recompute per `BRIEF.md`'s actual scope; don't reuse this table
as a quote for a bigger build.

## Rule

Every number on this page is an estimate to re-verify at runtime, not a
promise. Quote the estimate at the gate, generate, then record the ACTUAL
provider/model/prompt/cost per asset in `design/ASSETS.md` (Phase 6) — the
manifest is the real number; this file is only the planning estimate.
