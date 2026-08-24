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
- Require the name of the reference branch and the name of the new branch. Ask user, if either is omitted.
- If the base is a remote-tracking ref such as origin/develop, fetch that remote before creating the worktree.

### 1. Check existing state 
- Inspect both Herdr worktrees and local branches:
```bash
worktrees="$(herdr worktree list --cwd "$root" --json)"
git -C "$root" show-ref --verify --quiet "refs/heads/$branch"
```
- If the branch already has a worktree, do not create another checkout. Offer to focus or open the existing worktree.
- If the local branch exists without a worktree, explain that Herdr will check out the existing branch and ignore the requested base. Ask whether to resume that branch.
- Inspect uncommitted changes:
```bash
git -C "$root" status --short
```
- Uncommitted changes remain in the current worktree. If the requested task appears to depend on them, ask the user to commit, stash, or choose another base before proceeding.

### 2. Create and focus worktree 
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

### 3. Start a forked OpenCode Session
- Launch OpenCode directly in the worktree pane:
```bash
herdr pane run "$pane_id" "opencode --session $session_id --fork --agent plan"
```

### 4. Hand off the task to the new agent
```bash
herdr agent prompt "$pane_id Continue this task in the new worktree. Work only in this checkout. Task: $task"
```
The original OpenCode session remains in the parent workspace as the coordinator. The user is now focused on the forked session in the worktree.

## Open Existing Worktree
- If the branch already has a closed worktree checkout, open it through Herdr:
```bash
herdr worktree open \
  --cwd "$root" \
  --branch "$branch" \
  --focus \
  --json
```
- If the branch already has an open Herdr workspace, focus that workspace:
```bash
herdr workspace focus "$workspace_id"
```
- Do not create a duplicate checkout or session unless the user explicitly asks for one.
