# Product Backlog: Ashtrail PoC

---

### Epic: SETUP — Project Scaffolding

**Goal:** Get a runnable Godot project with the correct structure and settings.
**Phase:** 4
**Status:** Done

#### SETUP-1: Initialize Godot project with correct settings

**Type:** Chore
**Status:** Done
**Priority:** Must Have

**Description:**
Create the Godot project file and configure display settings for pixel art on Steam Deck. Set up the directory structure defined in TECH_DESIGN.md.

**Acceptance Criteria:**
- [x] `project.godot` exists with viewport 640x400, stretch mode `canvas_items`, nearest-neighbor filtering
- [x] Directory structure matches TECH_DESIGN.md (`scenes/`, `scripts/`, etc.)
- [x] `.gitignore` configured for Godot 4
- [x] Project opens and runs in Godot (blank window at correct resolution)

#### SETUP-2: Configure input mappings

**Type:** Chore
**Status:** Done
**Priority:** Must Have

**Description:**
Define input actions in the Godot project for movement, jump, attack, and restart. Map both gamepad and keyboard inputs per TECH_DESIGN.md.

**Acceptance Criteria:**
- [x] `move_left`, `move_right`, `jump`, `attack`, `restart` actions defined in project input map
- [x] Gamepad bindings: left stick/d-pad, A (south), X (west), Start
- [x] Keyboard bindings: A/D or arrows, Space, J, R
- [ ] Input actions are testable (print to console on press) — deferred to PLAYER-1

---

### Epic: PLAYER — Player Character

**Goal:** A controllable character with stat-driven movement and attack.
**Phase:** 4
**Status:** Not Started

#### PLAYER-1: Basic player movement (run + jump)

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Create the player scene with CharacterBody2D. Implement horizontal movement and jumping with gravity. Movement speed and jump force should read from the Stats resource so they can be tuned.

**Acceptance Criteria:**
- [ ] Player scene: CharacterBody2D with Sprite2D (colored rectangle) and CollisionShape2D
- [ ] Player moves left/right with acceleration and deceleration (not instant)
- [ ] Player jumps when on floor; cannot jump mid-air
- [ ] Gravity pulls player down when airborne
- [ ] Speed and jump force are driven by Stats resource values
- [ ] Changing stat values produces visibly different movement behavior

#### PLAYER-2: Player melee attack

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Add a melee attack action to the player. When attack is pressed, activate a hitbox in front of the player that can damage enemies. Attack damage reads from the Stats resource.

**Acceptance Criteria:**
- [ ] Pressing attack activates an Area2D hitbox in the player's facing direction
- [ ] Hitbox is active for a brief window (~0.2-0.3s), then deactivates
- [ ] Attack hitbox detects overlap with enemy collision
- [ ] Damage value comes from `stats.attack_damage`
- [ ] Player cannot spam attack (brief cooldown between swings)

#### PLAYER-3: Player HP and damage

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Implement the player's health system. Player takes damage from enemy contact, and dies when HP reaches zero.

**Acceptance Criteria:**
- [ ] Player has `current_hp` and `max_hp` from Stats resource
- [ ] Contact with an enemy deals damage to the player
- [ ] Brief invincibility window after taking damage (prevent instant death from overlap)
- [ ] Player emits `hp_depleted` signal when HP reaches 0
- [ ] Visual feedback on damage (flash or blink)

---

### Epic: ENEMY — Patrol Enemies

**Goal:** Simple enemies that patrol platforms and can be killed.
**Phase:** 4
**Status:** Not Started

#### ENEMY-1: Basic patrol enemy

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Create an enemy scene that patrols back and forth on a platform. Reverses direction at platform edges or walls. Uses CharacterBody2D for movement.

**Acceptance Criteria:**
- [ ] Enemy scene: CharacterBody2D with Sprite2D (colored rectangle, different color from player) and CollisionShape2D
- [ ] Enemy walks in one direction at a constant speed
- [ ] Enemy reverses direction when reaching a platform edge (RayCast2D ground check)
- [ ] Enemy reverses direction when hitting a wall
- [ ] Enemy is affected by gravity (falls if pushed off platform)

#### ENEMY-2: Enemy takes damage and dies

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Enemies have HP (via Stats resource) and take damage from the player's attack. They are removed from the scene when HP reaches zero.

**Acceptance Criteria:**
- [ ] Enemy has its own Stats resource with `max_hp` and `current_hp`
- [ ] Enemy takes damage when overlapping with player's attack hitbox
- [ ] Enemy dies (removed from scene via `queue_free()`) when HP reaches 0
- [ ] Enemy dies in 1-2 hits with default stats
- [ ] Visual feedback on damage (flash or blink)

---

### Epic: LEVEL — Test Level

**Goal:** A hand-crafted level with platforms, enemies, and a win zone.
**Phase:** 4
**Status:** Not Started

#### LEVEL-1: Build test level with TileMap

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Create a short test level using TileMapLayer. Include a floor, some platforms at different heights, and walls. All tiles are simple colored rectangles. Level should be wide enough to require scrolling.

**Acceptance Criteria:**
- [ ] TileMapLayer with a basic tileset (single colored square tile with collision)
- [ ] Level has: ground floor, 3-5 platforms at varying heights, walls at boundaries
- [ ] Level is wider than the viewport (requires camera scrolling)
- [ ] Player can navigate the full level using run and jump
- [ ] Camera follows the player smoothly

#### LEVEL-2: Place enemies and win zone

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Place 2-3 patrol enemies on platforms throughout the level. Add a win zone (Area2D) at the end of the level that triggers the win state when the player enters it.

**Acceptance Criteria:**
- [ ] 2-3 patrol enemies placed on different platforms
- [ ] Enemies patrol their respective platforms without falling off
- [ ] Win zone Area2D placed at the end of the level
- [ ] Entering the win zone triggers a signal or calls GameManager

---

### Epic: FLOW — Game Flow & UI

**Goal:** Complete the start → play → win/lose → restart loop.
**Phase:** 4
**Status:** Not Started

#### FLOW-1: Game Manager (win/lose/restart)

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Create a GameManager autoload that tracks game state and handles transitions. When the player dies or reaches the win zone, the game enters an end state. Pressing restart reloads the level.

**Acceptance Criteria:**
- [ ] GameManager is registered as an autoload singleton
- [ ] Tracks state: `PLAYING`, `WIN`, `LOSE`
- [ ] Player death triggers `LOSE` state
- [ ] Entering win zone triggers `WIN` state
- [ ] Pressing restart input during `WIN` or `LOSE` reloads the level scene
- [ ] Player input is disabled during `WIN`/`LOSE` states

#### FLOW-2: Minimal HUD

**Type:** Feature
**Status:** To Do
**Priority:** Must Have

**Description:**
Add a basic HUD showing the player's current HP. Display outcome text ("You Win" / "You Died") and a restart prompt when the game ends.

**Acceptance Criteria:**
- [ ] HUD displays current HP (text label or simple bar)
- [ ] HP display updates in real-time as player takes damage
- [ ] "You Win" displayed on win state
- [ ] "You Died" displayed on lose state
- [ ] "Press [Restart] to try again" shown during end states
- [ ] HUD is on a CanvasLayer (renders above gameplay)

---

### Epic: SPIKE — Stat-Driven Movement Feel

**Goal:** Validate that variable stats produce fun, distinct movement profiles.
**Phase:** 4
**Status:** Not Started

#### SPIKE-1: Stat tuning and feel validation

**Type:** Spike
**Status:** To Do
**Priority:** Must Have

**Description:**
With the core mechanic working, test at least 3 different stat profiles (e.g., fast/weak, slow/strong, balanced) and evaluate whether each feels distinct and fun to play. Adjust tuning constants (acceleration, friction, gravity, attack timing) as needed. This is the critical validation for the entire PoC.

**Acceptance Criteria:**
- [ ] At least 3 stat profiles defined and testable (swap via code or inspector)
- [ ] Each profile produces visibly and noticeably different gameplay
- [ ] No profile feels broken (e.g., can't make a required jump, attacks too slow to hit)
- [ ] Movement feels responsive across all profiles (no excessive float or sluggishness)
- [ ] Tuning values documented for future reference

**Notes:**
Depends on PLAYER and ENEMY epics being complete. This is the go/no-go checkpoint — if stat variation doesn't feel meaningful, the core concept needs rethinking.

---

## Work Order

Priority sequence for implementation:

1. **SETUP** (scaffolding — everything depends on this)
2. **PLAYER-1** (movement — the foundation)
3. **LEVEL-1** (need somewhere to test movement)
4. **PLAYER-2** (attack)
5. **ENEMY-1** (patrol)
6. **ENEMY-2** (enemy takes damage)
7. **PLAYER-3** (player takes damage)
8. **LEVEL-2** (place enemies + win zone)
9. **FLOW-1** (game manager)
10. **FLOW-2** (HUD)
11. **SPIKE-1** (validate the whole thing)
