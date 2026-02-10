# Concept Document

## Game Title (Working)

TBD — cyberpunk post-apocalyptic Oregon Trail roguelike

## Elevator Pitch

A cyberpunk post-apocalyptic roguelike where you guide a party across a ruined world Oregon Trail-style — managing resources, making stat-driven choices, and fighting through 2D platforming encounters shaped by your gear and abilities.

## Full Vision (for context — NOT the PoC scope)

- Oregon Trail-style journey with node-based travel, resource attrition, random events
- RPG stats and abilities gate dialogue/travel choices
- Some events trigger 2D platforming combat encounters
- Character gear and abilities affect platformer movement and attacks
- Party management, permadeath, roguelike progression
- Cyberpunk post-apocalyptic pixel art aesthetic

---

## PoC Focus: Single Platforming Encounter

### Core Mechanic

A 2D side-scrolling platforming encounter where a single character navigates a short level, fights enemies, and reaches an exit. The character has stats that visibly affect how they move and fight.

### Concrete Definition

- **One character** with a few stats (e.g., Speed, Jump, Attack)
- **One short level** with platforms, obstacles, and a few enemies
- **Movement** feels responsive: run, jump, attack
- **Stats affect gameplay**: higher Speed = faster run, higher Jump = higher/further jumps, higher Attack = more damage or wider hit
- **Enemies** are simple: patrol a platform, deal contact damage, die in 1-2 hits
- **Win condition**: reach the end of the level
- **Lose condition**: HP reaches zero

### PoC Feature List (in scope)

1. Character movement (run, jump, land)
2. Character attack (melee, one type)
3. 2-3 character stats that visibly modify movement/combat
4. One hand-crafted test level with platforms
5. 2-3 simple patrol enemies
6. HP system (player takes damage, can die)
7. Win state (reach end) and lose state (die)
8. Restart on win or loss

### Explicitly OUT of Scope

- Travel/journey map
- Multiple characters or party management
- Inventory, equipment, or loot
- Multiple levels or procedural generation
- Narrative, dialogue, or stat-gated choices
- Sound, music, or screen shake
- Menus, HUD beyond basic HP display
- Save/load
- Pixel art (use colored rectangles)
- Any networking or multiplayer

### Game Flow

```
[Start] → [Spawn in level] → [Platforming: run, jump, fight] → [Reach exit OR die]
                                                                       |
                                                              [Show outcome] → [Restart]
```

---

## Decision Log

| Decision | Reasoning |
|----------|-----------|
| PoC focuses on platforming, not travel layer | Platforming is the riskiest mechanic — if it doesn't feel fun, the game concept fails. The travel layer is a known formula. |
| Single character, not party | Simplest way to test movement/combat feel. Party mechanics are a layer on top. |
| Stats affect movement/combat directly | This is the bridge between the RPG and action layers — needs to be proven early. |
| Colored rectangles, no art | Tiny scope. If it's fun with rectangles, it'll be fun with art. |
