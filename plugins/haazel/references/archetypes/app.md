# Archetype — App / Dashboard UI

Inside-the-product interface for users who already converted — logging in daily
to get work done, not to be persuaded. Clarity and speed win; brand drama has no
seat at this table. Marketing pages for the same product are a different
archetype (`saas.md`) — this file governs everything behind the login wall.

## Layout grammar

- Skeleton is `AppShell` (sidebar + topbar), not sections in the marketing
  sense. Every screen composes inside AppShell's content slot; AppShell itself
  is chrome, never counted as a "section" in a build brief.
- Density over drama: hairlines separate every panel
  (`color-mix(in oklab, var(--foreground) 10–15%, transparent)`, hard-rules #4),
  not shadow stacks. Tight, consistent padding — screen real estate is for
  data, not breathing room.
- 8pt spacing discipline: every gap, padding, and offset is a multiple of 8px
  (4px for the tightest table/label spacing). No ad-hoc 13px/17px/22px
  paddings — a dashboard's calm comes from a spacing grid the eye stops
  noticing.
- Aligned grids are the justified exception to hard-rules #5's asymmetry
  default — `KpiCards` rows and `DataTablePro` columns are uniform on
  purpose, because scanability beats asymmetry when comparing rows and
  values instead of reading a narrative. That's the written reason rule #5
  asks for; bento/offset compositions stay on the marketing site.
- `EmptyState` is a first-class screen, not a placeholder — design it with
  the same care as the populated state: what's missing, why, and the one
  action that fixes it. `CommandPalette` (cmdk) is the power-user's front
  door, reachable from anywhere as global chrome, never a page section.

## Type & color

- One workhorse family, not a pairing. This is the one archetype where an
  Inter/Geist-class grotesque is correct, not a tell — dashboards need proven
  legibility at 13px in a dense table, not brand personality. Pick one and
  stop; no display face, no serif aside, no display drama.
- Mono for every number that means something: table figures, IDs, timestamps,
  diffs, currency. `font-mono` small, never body-face numerals for anything a
  user might scan down a column (SECTION_SPEC §3).
- Semantic color is functional, not decorative: destructive/success/warning
  tokens apply ONLY to state (error banners, destructive-button confirms,
  status pills, chart deltas) — never as a page accent. If nothing is wrong,
  nothing is red.
- `colorScheme: dual` is mandatory here, not a choice — a product people sit
  in for hours must respect the OS/user theme preference. Marketing sites can
  commit to one scheme; the product surface can't.
- radius tighter than the marketing site's, 0.375–0.5rem — reads "workhorse."
  The marketing site's larger radius reads "brand." They're allowed to
  differ.

## Motion policy: `minimal`

Per the tokens schema, `minimal` means transitions only: state changes
(hover, focus, open/close, sort, filter) animate at `--duration-fast`/
`--duration-base`; nothing animates on load, nothing animates just to be
noticed. `motion.ambient` is off (`cursorGlow: false`,
`noiseOverlay.enabled: false`) — that's marketing-site atmosphere with no
job here.
`bannedModules`: every scroll-scrub and cursor/hover module (the full
`scroll.md`/`cursor.md` catalog fragments), plus every ambient module except
`ScrollProgress` — a pinned scrub or a cursor-trailing glow reads as a bug in
a dashboard, not a feature.
Allowed, sparingly: `ScrollProgress` (functional on a long settings/
onboarding flow); `OdometerCounter` (a KPI that just updated is worth a
roll, not a fade); `DockNav`; `DynamicIsland` (a notification surface, if
the product wants one). `ParticleButton` and `ViewTransitionMorph` are
fit-tagged for app but earned-rarely (a genuine milestone, a tier-switch
morph) — default off; the bar is "does this help someone finish a task
faster."

## Section recipe (primary authenticated view)

`AppShell` (persistent chrome) wraps: 1 `KpiCards` (top-line numbers, the
first thing a returning user checks) → 2 `ChartPanel` (trend context for those
numbers, dependency-free SVG) → 3 `DataTablePro` (the actual work surface —
sort, filter, row actions) → 4 `ActivityFeed` (secondary, sidebar or below the
fold) → `EmptyState` (conditional — first-run or filtered-to-nothing) →
`CommandPalette` (global, not sequenced). Secondary pages: `SettingsForm` per
settings section — one form, one save state, inline validation, never a giant
single-page form.

## Copy voice

Interface writing, not marketing writing. Verb-first button labels ("Create
project," "Invite teammate" — never "New" alone or a marketing "Get started"
repurposed as a button). Empty states name what's missing AND the one action
that fixes it, in that order. Error text is specific and actionable — say what
broke and what to do; "Something went wrong" is a bug in the copy, not a real
error message. Destructive-action confirmations name the actual consequence
("Delete 14 invoices — this can't be undone," not "Are you sure?"). Sentence
case everywhere; reserve caps for overlines and status badges. No marketing
adjectives inside the product — "seamless," "powerful," "effortless" have no
button to stand on.

## SEO shape

N/A behind auth. Every app route is `noindex`; the marketing pages for the
same product (home, /pricing, /docs) are a separate surface using the `saas`
archetype and carry the SEO obligations. If a build has both, keep them as
genuinely different route groups with different metadata defaults — don't let
the app shell's minimal-metadata habit leak onto the marketing pages, or vice
versa.

## Reference notes (describe, never copy)

- Linear's app — keyboard-first density: cmd+K reaches everything, one
  accent color reserved for state (not brand), hairlines do all the
  separating work shadows would otherwise do.
- Vercel dashboard — deployment status (building/ready/error) is the only
  saturated color allowed to be loud; every hash, timestamp, and build ID is
  mono so the eye never has to guess what's a number.
- Stripe dashboard — dense tables stay legible because typographic hierarchy
  (weight and size, not color) tells you what matters; sparklines sit inline
  with the row they describe instead of migrating to a separate chart
  section.
