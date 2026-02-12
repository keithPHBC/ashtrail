# Technical Design: Ashtrail PoC

## Engine & Framework

**Godot 4.6** (GDScript)

| Factor | Assessment |
|--------|------------|
| Platforming support | `CharacterBody2D` + `move_and_slide()` handles physics, gravity, and collision out of the box |
| Gamepad support | Native. Steam Deck controls map automatically |
| Cross-platform | Exports to Linux, Windows, macOS, web |
| Pixel art | First-class support (nearest-neighbor filtering, pixel snapping) |
| Scope fit | Built-in tilemap, scene system, and signals reduce boilerplate for a tiny PoC |
| Install | Flatpak on Steam Deck, standard install everywhere else |

## Project Structure

```
ashtrail/
├── project.godot
├── scenes/
│   ├── player/
│   │   ├── player.tscn
│   │   └── player.gd
│   ├── enemies/
│   │   ├── patrol_enemy.tscn
│   │   └── patrol_enemy.gd
│   ├── level/
│   │   └── test_level.tscn
│   └── ui/
│       ├── hud.tscn
│       └── hud.gd
├── scripts/
│   ├── autoload/
│   │   └── game_manager.gd
│   └── resources/
│       └── stats.gd
├── GAME_DEV_PROCESS.md
├── CONCEPT.md
├── TECH_DESIGN.md
├── BACKLOG.md
└── BRANCHING_STRATEGY.md
```

## Core Systems

### 1. Player (CharacterBody2D)

```
Player (CharacterBody2D)
├── Sprite2D              — colored rectangle placeholder
├── CollisionShape2D      — capsule or rectangle hitbox
├── AttackArea (Area2D)   — melee hit detection
│   └── CollisionShape2D  — attack hitbox
└── Camera2D              — follows player, pixel-snapped
```

Movement driven by stats: `velocity.x` scaled by Speed stat, jump impulse scaled by Jump stat. Gravity and floor detection via `move_and_slide()` + `is_on_floor()`.

### 2. Enemy (CharacterBody2D)

```
PatrolEnemy (CharacterBody2D)
├── Sprite2D              — colored rectangle placeholder
├── CollisionShape2D      — hitbox
└── RayCast2D             — ground/edge detection for patrol
```

Simple patrol: walk in one direction, reverse at edges or walls. Deal contact damage via `Area2D` overlap or direct body collision. Die in 1-2 hits from player attack.

### 3. Stats (Resource)

A reusable `Resource` class shared by player and enemies.

```gdscript
class_name Stats extends Resource

@export var max_hp: int = 100
@export var current_hp: int = 100
@export var speed: float = 300.0
@export var jump_force: float = 600.0
@export var attack_damage: int = 25

signal hp_changed(new_hp: int)
signal hp_depleted
```

Stats affect gameplay directly:
- **Speed** → horizontal movement velocity
- **Jump** → vertical impulse magnitude
- **Attack** → damage dealt per hit

For the PoC, stats are hardcoded constants. The point is to prove the *architecture* — that swapping stat values produces visibly different gameplay.

### 4. Game Manager (Autoload)

Singleton handling game flow:
- Track game state: `PLAYING`, `WIN`, `LOSE`
- Trigger restart on win/lose
- Reload the level scene

### 5. HUD (CanvasLayer → Control)

Minimal overlay:
- HP bar or HP text
- "You Win" / "You Died" message on game end
- "Press [button] to restart" prompt

### 6. Level (Node2D)

```
TestLevel (Node2D)
├── TileMapLayer          — ground and platforms (simple rectangular tiles)
├── Player                — instanced scene
├── Enemies (Node2D)      — container
│   ├── PatrolEnemy       — instanced x2-3
│   └── ...
├── WinZone (Area2D)      — trigger at end of level
│   └── CollisionShape2D
└── UI (CanvasLayer)
    └── HUD               — instanced scene
```

## Data Model

```
Player
├── stats: Stats (Resource)
│   ├── max_hp: int
│   ├── current_hp: int
│   ├── speed: float
│   ├── jump_force: float
│   └── attack_damage: int
├── velocity: Vector2
└── facing_direction: int (+1 or -1)

PatrolEnemy
├── stats: Stats (Resource)
│   ├── max_hp: int
│   ├── current_hp: int
│   └── attack_damage: int
├── velocity: Vector2
├── patrol_speed: float
└── direction: int (+1 or -1)

GameManager (autoload)
├── state: enum { PLAYING, WIN, LOSE }
└── restart() → reloads scene
```

## Input Mapping

| Action | Gamepad | Keyboard |
|--------|---------|----------|
| Move left | Left stick / D-pad left | A / Left arrow |
| Move right | Left stick / D-pad right | D / Right arrow |
| Jump | A button (South) | Space |
| Attack | X button (West) | J / Left click |
| Restart | Start | R |

## Riskiest Technical Unknown

**Does stat-driven movement feel good in a platformer?**

Platformers rely on tight, tuned controls. Dynamically scaling speed and jump via stats could feel floaty, sluggish, or unpredictable. The spike should test whether variable movement parameters can feel responsive across a range of stat values.

## Display Settings

- Viewport: 640x400 (scaled 2x to 1280x800 for Steam Deck)
- Stretch mode: `canvas_items` (pixel-perfect scaling)
- Texture filter: Nearest (no smoothing)

## Decision Log

| Decision | Reasoning |
|----------|-----------|
| Godot 4.6 | Built-in platformer physics, native Linux/gamepad, scales to full game. Already installed via Flatpak. |
| GDScript (not C#) | Simpler setup, no Mono dependency, faster iteration for a PoC. |
| Stats as Resource | Composable across player/enemies, editable in inspector, signal-driven for UI updates. |
| 640x400 viewport at 2x | Pixel art friendly, fills Steam Deck 1280x800 exactly. |
| Camera on Player | Simplest approach for a single-screen/scrolling level. |
| preload() over class_name | class_name registry requires editor indexing; preload works reliably from CLI-created projects. |
| Programmatic TileMapLayer | Level built from text map in code — avoids hand-writing binary tile data in .tscn files, keeps layout readable and editable. |
| Variable jump height | Playtest feedback: fixed jump height felt binary. Cut upward velocity on early release (0.4 multiplier) for short hops. |
