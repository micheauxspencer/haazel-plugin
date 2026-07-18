# Haazel Hard Rules — every build, every archetype

These are global. Archetype-specific rules (motion mandates, module bans)
live in `references/archetypes/<archetype>.md` — a cinematic rule is not a
SaaS rule. When old skill text and this file disagree, this file wins.

1. **Tokens only.** No hardcoded hex/rgb in sections or pages — colors come
   from `design/tokens.json` via CSS vars (`var(--primary)`,
   `color-mix(in oklab, var(--foreground) 12%, transparent)`). One easing
   curve site-wide: `var(--ease-standard)`.

2. **Inline SVG or lucide-react for icons. Never emoji.** Never icon fonts.

3. **Contrast floors.** Body text ≥ 4.5:1 against its background; large
   display type ≥ 3:1. Text over imagery gets a scrim, gradient panel, or
   backdrop pill — never raw text on a busy photo.

4. **Borders must be visible.** Hairlines are
   `color-mix(in oklab, var(--foreground) 10–15%, transparent)` minimum on
   the actual background they sit on.

5. **Asymmetry is the default.** 62/38 and 58/42 splits, offset grids,
   overlapping layers. A 50/50 split or uniform icon-card grid needs a
   written reason. Center-aligning everything is a template tell.

6. **Type pairs, never solos.** Display face for statements, heading/serif
   for asides, mono for labels and numbers. Use the scale utilities
   (`text-hero`, `text-display`, `text-overline`) — no ad-hoc font sizes.

7. **Reduced motion is law.** Every animated element renders a complete
   settled state under `prefers-reduced-motion` (the scaffold's
   `useReducedMotion` + CONVENTIONS.md). Hover-only affordances gate on
   `usePointerFine` and never hide content from touch users.

8. **Real content or clearly-demo content.** No lorem ipsum. Never fabricate
   testimonials, review counts, client names, or statistics — placeholder
   content is labelled as demo and flagged in QA_REPORT.md.

9. **Ship hygiene is part of the build.** `npm run prune` before QA; nav,
   sitemap, and package name must match the routes that exist. No scaffold
   demo copy may reach a client build.

10. **Cultural/brand adaptation over template instinct.** Layout grammar,
    imagery, and voice adapt to the client (a Japanese izakaya, a Toronto
    railing contractor, and a SaaS startup do not share a hero formula).

11. **Money gates.** Nothing that costs money (video generation, paid APIs)
    runs without an explicit user approval recorded at a gate. Deployment is
    always manual — git commit yes, deploy no.

12. **Verify, don't assume.** Component props come from the cloned scaffold's
    `src/components/COMPONENT_CATALOG.md`, not from memory. `npm run build`
    green before handoff, always.
