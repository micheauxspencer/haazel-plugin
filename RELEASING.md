# Releasing haazel

Two repos ship together, and the plugin exists as THREE local copies that
must be synced deliberately. Skipping a step is how the installed plugin
ends up a version behind the working copy (it happened at 0.1.0).

## The copies

| Copy | Path | Updated by |
|---|---|---|
| Working repo (this) | `Downloads\haazel\haazel-plugin` | you |
| Marketplace clone | `~\.claude\plugins\marketplaces\haazel` | `claude plugin marketplace update haazel` |
| Installed cache | `~\.claude\plugins\cache\haazel\haazel\<version>` | plugin update/reinstall |

Plus the scaffold repo: `Downloads\haazel\scaffold` → github
`micheauxspencer/haazel-scaffold`. Builds pull it via
`degit micheauxspencer/haazel-scaffold#v<version>` — **the tag must exist on
GitHub or every build breaks at Phase 2.**

## Release steps

1. **Version bump (two files):**
   `plugins/haazel/.claude-plugin/plugin.json` and
   `.claude-plugin/marketplace.json` — same version string.
2. **Scaffold checks** (in `Downloads\haazel\scaffold`):
   `npm run tokens:check` (should fail only if design/ exists — scaffold
   ships without one), `npm run check:catalog`, `npm run build` green.
3. **Skill ↔ scaffold consistency:** the version pinned in
   `skills/haazel-build/SKILL.md` Phase 2 (`#v0.2.0`) matches the tag you
   are about to push.
4. **Commit + push both repos.**
5. **Tag the scaffold:** `git tag v<version> && git push origin v<version>`.
   Verify: `npx degit micheauxspencer/haazel-scaffold#v<version> <temp-dir>`
   resolves (degit caches — use `--force` when re-testing).
6. **Sync the marketplace clone + cache:** from an interactive Claude Code
   session run `/plugin marketplace update haazel` then update/reinstall the
   haazel plugin; or manually `git pull` the marketplace clone and reinstall.
7. **Verify the installed copy:** new version directory appears under the
   cache; the session skill list shows exactly one set of haazel skills at
   the new version (duplicates = a stale second copy is still registered).
8. **Smoke test FROM THE INSTALLED PLUGIN** (not the working repo): run
   `/haazel-design` on any section in a scratch project; confirm it reads
   the new checklist.

## Degit gotchas (Windows)

- `degit` may serve a stale tag from `~/.degit` cache → `--force`.
- Long-path failures → documented fallback in the build skill:
  `git clone --branch v<version> --depth 1` + delete `.git`.
