---
name: create-worktree
description: Create and switch to a git worktree through Herdr. Use when the user asks to create a new branch or open a new worktree. Requires HERDR_ENV=1.
---


## Invariants

- Herdr is the sole owner of Git worktrees and worktree workspaces. Do not use an OpenCode worktree plugin or run `git worktree add` directly.
- Operate only when `HERDR_ENV=1`. If `HERDR_ENV` is not 1, stop and explain that worktree orchestration must run inside Herdr.
- Treat the worktree, local branch, and remote branch as separate resources.
- Never transfer, copy, commit, or discard uncommitted changes before creating and switching to a new worktree.

## Create worktree
- If the branch already exists, no base branch is necessary

### 1. Check whether branch exists
- Search existing branches
```bash
git -C "$root" show-ref --verify --quiet "refs/heads/$branch"
```
- If the requested branch does not exist, prompt user for the base branch.
- If the requested branch does exist, do not prompt user for the base branch.

### 2. Check whether existing worktree is clean
- Inspect uncommitted changes:
```bash
git -C "$root" status --short
```
- Uncommitted changes remain in the current worktree. If the requested task appears to depend on them, ask the user to commit, stash, or choose another base before proceeding.

### 3. Check whether worktree exists
- Inspect herdr worktrees
```bash
worktrees="$(herdr worktree list --cwd "$root" --json)"
```
#### If branch already has a worktree
- Do not create another checkout.
- If the worktree is closed, open it through Herdr:
```bash
herdr worktree open \
  --cwd "$root" \
  --branch "$branch" \
  --focus \
  --json
```
- If the worktree is open in a Herdr workspace, focus that workspace:
```bash
herdr workspace focus "$workspace_id"
```
- Do not create a duplicate checkout or session unless the user explicitly asks for one.

#### If branch exists, but has no worktree
- Create the worktree with no base:
```bash
create_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --label "$branch" \
    --focus \
    --json
)"
```

#### If neither branch nor worktree exists
- Create the worktree and branch with the base branch specified:
```bash
create_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --base "$base" \
    --label "$branch" \
    --focus \
    --json
)"
```

### 4. Focus worktree 
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
Retrieve workspace and pane IDs from Herdr's JSON.

### 5. Start a forked OpenCode Session
- Launch OpenCode directly in the worktree pane:
```bash
herdr pane run "$pane_id" "opencode --session $session_id --fork --agent plan"
```

### 6. Hand off the task to the new agent
```bash
herdr agent prompt "$pane_id Continue this task in the new worktree. Work only in this checkout. Task: $task"
```
The original OpenCode session remains in the parent workspace as the coordinator. The user is now focused on the forked session in the worktree.
