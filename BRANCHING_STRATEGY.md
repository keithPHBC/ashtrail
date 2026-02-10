# Branching Strategy: Feature Branch Workflow

A lightweight branching model for small teams (1-2 contributors).

## Branches

### `main`

- Always in a stable, working state
- All completed work merges here
- Never commit directly to `main` — always merge from a feature branch

### Feature Branches

- Created from `main` for every unit of work
- Naming convention: `<type>/<short-description>`
- Merged back to `main` when complete, then deleted

#### Branch Type Prefixes

| Prefix | Use For |
|--------|---------|
| `feature/` | New functionality |
| `spike/` | Research, prototyping, technical exploration |
| `fix/` | Bug fixes |
| `chore/` | Docs, config, tooling, refactoring |
| `phase/` | Phase-level deliverables (design docs, backlogs) |

#### Examples

```
feature/player-movement
spike/physics-engine-test
fix/collision-detection
chore/update-process-doc
phase/tech-design
```

## Workflow

1. **Start work:** Create a branch from `main`
   ```
   git checkout main
   git checkout -b feature/player-movement
   ```

2. **Do work:** Make commits on the feature branch. Commit messages should be concise and describe the "why."

3. **Push and open a PR:** Push the branch to origin and create a pull request.
   ```
   git push -u origin feature/player-movement
   gh pr create --title "Feature: player movement" --body "..."
   ```

4. **Review and merge:** Review the PR, then squash merge via GitHub (use the "Squash and merge" button or CLI).
   ```
   gh pr merge --squash
   ```

5. **Clean up:** Pull main and delete the feature branch locally and remotely.
   ```
   git checkout main
   git pull origin main
   git branch -d feature/player-movement
   git push origin --delete feature/player-movement
   ```

## Rules

1. One branch per logical unit of work (roughly maps to one epic or work item).
2. Keep branches short-lived — merge frequently rather than letting branches diverge.
3. If `main` has moved ahead, rebase or merge `main` into your branch before opening the PR.
4. Commit early, commit often on feature branches. Squash when merging to `main` via PR to keep history clean.
5. All merges to `main` go through a pull request — no direct local merges.
6. Tag releases or milestones on `main` (e.g., `v0.1-poc`).
