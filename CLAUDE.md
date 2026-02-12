# Ashtrail

## What is this?

Cyberpunk post-apocalyptic roguelike — Oregon Trail-style travel with 2D platformer combat encounters. Character stats and gear affect both travel choices and platforming movement/attacks. 2D pixel art aesthetic.

Currently building a **proof-of-concept** focused on a single platforming encounter with stat-driven movement and combat. All placeholder art (colored rectangles).

## Key Documents

- `GAME_DEV_PROCESS.md` — Development phases, process rules, current status
- `BACKLOG.md` — Epics, work items with acceptance criteria, work order
- `TECH_DESIGN.md` — Engine choice, project structure, node trees, data model
- `CONCEPT.md` — Game concept, PoC scope, and out-of-scope boundaries
- `PLAYTEST_LOG.md` — Playtest observations linked to work items and commits
- `BRANCHING_STRATEGY.md` — Git workflow (feature branch → PR → squash merge)

## Tech Stack

- **Engine:** Godot 4.6 (installed via Flatpak)
- **Language:** GDScript
- **Display:** 640x400 viewport, 2x scale to 1280x800 (Steam Deck native)
- **Target:** Cross-platform, initially Steam Deck

## Conventions

### Git
- Never commit directly to `main` — always feature branch → PR → squash merge
- Branch naming: `feature/`, `spike/`, `fix/`, `chore/`, `phase/` prefixes
- After merge: pull main, delete local branch, delete remote branch
- Git identity: keithPHBC / 3keithjordan3@gmail.com (repo-local config)

### Development
- All implementation work is tracked in BACKLOG.md — no untracked work
- Update backlog status and acceptance criteria checkboxes as items complete
- Update GAME_DEV_PROCESS.md current status when completing items or changing phases
- Log every playtest in PLAYTEST_LOG.md before opening PRs
- Validate with `flatpak run org.godotengine.Godot --headless --path . --quit` before pushing

### Godot-Specific
- `.gd.uid` and `.import` files are editor-generated metadata — track them in git
- `.godot/` directory is cache — gitignored
- Tile collision polygons use center-relative coordinates, not top-left
- Use `preload()` for cross-script references rather than relying on `class_name` registry

## Project Structure

```
scenes/
  player/    — player scene + script
  enemies/   — enemy scenes + scripts
  level/     — level scenes + scripts
  ui/        — HUD and menu scenes
scripts/
  autoload/  — singletons (GameManager)
  resources/ — shared resources (Stats)
```

## Current Focus

Check `GAME_DEV_PROCESS.md` Current Status section and `BACKLOG.md` for latest state.
