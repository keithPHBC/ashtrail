# Game Development Process: Idea to Proof-of-Concept

## Phase 1: Brainstorm & Discovery

**Goal:** Generate and explore game ideas without filtering.

- [ ] Define constraints upfront (platform, tech stack, scope limits)
- [ ] Brainstorm core game concepts (genre, theme, hook)
- [ ] Identify the "core loop" — what does the player do repeatedly?
- [ ] List reference games / inspirations
- [ ] Write a 1-2 sentence elevator pitch for top candidates

**Output:** A short list of candidate ideas with elevator pitches.

---

## Phase 2: Concept Selection & Definition

**Goal:** Pick one idea and define it clearly enough to build.

- [ ] Evaluate candidates against constraints (feasibility, scope, fun factor)
- [ ] Select one concept
- [ ] Define the core mechanic in concrete terms
- [ ] Identify the minimum set of features for a playable proof-of-concept
- [ ] List what is explicitly OUT of scope for the PoC
- [ ] Sketch the game flow (start → play → end state)

**Output:** A concept document (`CONCEPT.md`) with mechanic definition, PoC feature list, and scope boundaries.

---

## Phase 3: Technical Design & Work Planning

**Goal:** Make implementation decisions and break the work into deliverable items.

- [ ] Choose engine/framework and justify the choice
- [ ] Define the project structure
- [ ] Identify core systems needed (rendering, input, state, etc.)
- [ ] Plan the data model (entities, state shape)
- [ ] Identify the riskiest technical unknowns
- [ ] Prototype the riskiest unknown first (spike)
- [ ] Create the product backlog (see Work Item Structure below)

**Output:**
- A technical design doc (`TECH_DESIGN.md`) and a working spike for the biggest risk.
- A product backlog (`BACKLOG.md`) with epics and work items covering Phases 4–5.

---

## Phase 4: Core Mechanic Prototype

**Goal:** Get the core loop playable with placeholder everything.

Work is driven by backlog items from the relevant epics.

- [ ] Implement the core mechanic — nothing else
- [ ] Use placeholder art/sound (rectangles, basic shapes, silence)
- [ ] Make it interactive (player input → visible response)
- [ ] Playtest: Is the core loop *interesting* with zero polish?
- [ ] Iterate on feel/tuning based on playtesting

**Output:** A runnable build where the core mechanic works and can be evaluated.

---

## Phase 5: Proof-of-Concept Build

**Goal:** Expand the prototype into something that demonstrates the full idea.

Work is driven by backlog items from the relevant epics.

- [ ] Add remaining PoC-scoped features
- [ ] Implement basic game flow (start → play → win/lose → restart)
- [ ] Add minimal UI (score, health, menus — whatever applies)
- [ ] Basic juice/feedback (screen shake, sound, particles — pick 1-2)
- [ ] Bug fixing pass
- [ ] Final playtest and evaluation

**Output:** A playable proof-of-concept that answers: "Is this game worth developing further?"

---

## Work Item Structure

All implementation work (Phases 4–5) is organized into **epics** and **work items** following agile conventions.

### Epic

A thematic grouping of related work items that delivers a meaningful slice of functionality.

```
### Epic: [EPIC-ID] — [Title]

**Goal:** [What this epic achieves]
**Phase:** [4 or 5]
**Status:** [Not Started | In Progress | Done]
```

### Work Item

Each work item lives under an epic and follows this template:

```
#### [EPIC-ID]-[NUM]: [Title]

**Type:** [Feature | Spike | Bug | Chore]
**Status:** [To Do | In Progress | Done]
**Priority:** [Must Have | Should Have | Nice to Have]

**Description:**
[What needs to be built and why. Enough context that someone could pick this up cold.]

**Acceptance Criteria:**
- [ ] [Specific, testable condition that must be true when this item is done]
- [ ] [Another condition]
- [ ] ...

**Notes:**
[Optional. Dependencies, open questions, technical considerations.]
```

### Field Definitions

| Field | Purpose |
|-------|---------|
| **Type** | *Feature* = new functionality. *Spike* = research/prototype to reduce uncertainty. *Bug* = defect fix. *Chore* = tech debt, refactoring, tooling. |
| **Priority** | *Must Have* = PoC is broken without it. *Should Have* = important but PoC is playable without it. *Nice to Have* = only if time allows. |
| **Acceptance Criteria** | The definition of done. Each criterion is a concrete, verifiable statement. If all boxes are checked, the item is complete. |

### Backlog Rules

1. Every work item belongs to exactly one epic.
2. Work items are small enough to complete in a single focused session.
3. Acceptance criteria are written before implementation begins.
4. Items are worked in priority order (Must Have → Should Have → Nice to Have).
5. New items discovered during implementation get added to the backlog, not silently built.

---

## Process Rules

1. **Stay in phase.** Don't jump ahead. Each phase has a clear output — produce it before moving on.
2. **Scope is sacred.** If it's not on the PoC feature list, it doesn't go in.
3. **Playtest early.** The core mechanic prototype (Phase 4) is the most important checkpoint. If it's not fun with rectangles, polish won't save it.
4. **Kill bad ideas fast.** It's fine to go back to Phase 2 and pick a different concept if the prototype doesn't work.
5. **Track decisions.** When a decision is made (in conversation, PR review, or playtesting), record it in the decision log of the relevant document before the PR is opened. Concept/scope decisions go in `CONCEPT.md`, technical decisions in `TECH_DESIGN.md`, process decisions in `GAME_DEV_PROCESS.md`.
6. **Work from the backlog.** In Phases 4–5, all work is tracked as work items. No untracked work.
7. **Log every playtest.** After each playtest, record observations and actions in `PLAYTEST_LOG.md` before opening the PR. Link to work items and commits.
8. **Update current status.** Update the Current Status section in this doc when completing a work item or transitioning between phases.
9. **One work item per PR.** Keep work items small and self-contained enough that each one is independently testable and mergeable.

---

## Current Status

**Phase:** 4 — Core Mechanic Prototype
**Status:** In progress — PLAYER-1 and LEVEL-1 complete, PLAYER-2 next

### Phase History

| Phase | Status | Date |
|-------|--------|------|
| 1 — Brainstorm & Discovery | Done | 2026-02-10 |
| 2 — Concept Selection & Definition | Done | 2026-02-10 |
| 3 — Technical Design & Work Planning | Done | 2026-02-10 |
| 4 — Core Mechanic Prototype | In Progress | 2026-02-10 |
