---
name: create-worktree
description: Create or open a git worktree through Herdr. Use when the user asks to create or open a worktree.
---

# Create worktree
- Operate only when `HERDR_ENV=1`. Otherwise, stop and explain that worktree orchestration must run inside Herdr.
- Before creating a worktree, check whether a worktree for this branch already exists. If it does, skip the worktree creation flow, and simply open and focus the existing worktree.
- Do not create a duplicate checkout or session unless the user explicitly asks for one.
- Uncommitted changes should remain in the current worktree.

### Create the worktree with Herdr
- If the branch already exists:
```bash
create_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --label "$branch" \
    --no-focus \
    --json
)"
```
- If the branch does not yet exist, prompt the user for the base branch:
```bash
create_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --label "$branch" \
    --no-focus \
    --json
)"
```

### Switch to new worktree
- Retrieve workspace and pane IDs from Herdr's JSON:
```bash
workspace_id="$(
  printf '%s' "$create_json" |
    jq -er '.result.workspace.workspace_id'
)"

pane_id="$(
  printf '%s' "$create_json" |
    jq -er '.result.root_pane.pane_id'
)"
```
Start OpenCode and focus the workspace:
```bash
herdr pane run "$pane_id" opencode --agent plan
herdr workspace focus "$workspace_id"
```
