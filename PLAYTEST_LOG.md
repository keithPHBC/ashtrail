# Playtest Log

Record of playtest observations during development. Each entry is linked to the work item being tested.

---

## PLAYER-1 — 2026-02-10

**Build:** feature/player-movement @ a2c941c
**Tested:** Basic movement and jumping across test level

### Observations
- Jump feels binary — full height every time, no control over arc
- Movement acceleration/deceleration feels smooth
- Sprite flips correctly

### Actions Taken
- Added variable jump height (JUMP_CUT_MULTIPLIER = 0.4) — a653548
- Retested: short hop vs full jump feels good now

---

## LEVEL-1 — 2026-02-10

**Build:** feature/tilemap-level @ ca44bf1
**Tested:** TileMapLayer level with platforms, scrolling camera

### Observations
- Player rectangle overlaps tiles on the bottom and right edges
- Camera scrolling works, level is wide enough
- Platform layout is navigable

### Actions Taken
- Fixed tile collision polygon to use center-relative coordinates — 710000a
- Retested: player sits flush on all surfaces now

---

## PLAYER-2 — 2026-02-10

**Build:** feature/player-attack @ ad429ee
**Tested:** Melee attack with hitbox visual, cooldown, and direction flipping

### Observations
- Red hitbox flash is visible and correctly positioned in front of player
- Hitbox flips when changing facing direction
- Cooldown prevents spam — feels responsive
- No enemies to test damage dealing yet (ENEMY-1 dependency)

### Actions Taken
- No changes needed — attack feels good as-is
