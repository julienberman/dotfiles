---
name: create-branch
description: Create or open a Git branch or worktree through Herdr. Use when the user asks to create or switch to a branch, or to create or open a worktree.
---

## Resolve the request
- Set the repository root
```bash
root="$(git rev-parse --show-toplevel)"
```
- If the user has provided a branch name, inspect local branches to see if the branch already exists
- If 
- If the user asks for a new worktree, continue with the 

- Herdr is the sole owner of Git worktrees and worktree workspaces. Never use an OpenCode worktree plugin or run `git worktree add` directly.
- Operate only when `HERDR_ENV=1`. Otherwise, stop and explain that worktree orchestration must run inside Herdr.
- Treat worktrees, local branches, and remote branches as separate resources.
- Never infer that a branch is new. Search for it before asking for a base branch.
- Never transfer, copy, commit, stash, or discard uncommitted changes automatically.

## Resolve the request


```bash
Before asking for a base branch or proposing creation, inspect both Herdr worktrees and Git branches:
worktrees_json="$(herdr worktree list --cwd "$root" --json)"

local_ref="$(
  git -C "$root" for-each-ref \
    --format='%(refname)' \
    "refs/heads/$branch"
)"

remote_refs="$(
  git -C "$root" for-each-ref \
    --format='%(refname)' \
    "refs/remotes/*/$branch"
)"
Do not continue until these commands have run.
Choose exactly one action
Existing worktree
If Herdr already has a worktree for the branch, do not create another checkout.
If it is already open, focus its workspace:
herdr workspace focus "$workspace_id"
If it is closed, open it:
open_json="$(
  herdr worktree open \
    --cwd "$root" \
    --branch "$branch" \
    --focus \
    --json
)"
Stop after opening or focusing the existing worktree. Do not create a duplicate worktree or session.
Existing local branch
If the local branch exists but has no worktree, create a worktree without a base:
action_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --label "$branch" \
    --no-focus \
    --json
)"
Existing remote branch
If no local branch exists and exactly one remote branch matches, use that remote ref as the base:
action_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --base "$remote_ref" \
    --label "$branch" \
    --no-focus \
    --json
)"
If multiple remote branches match, ask the user which remote to use.
New branch
Only when no worktree, local branch, or remote branch matches should you ask for a base branch.
Then create the branch and worktree:
action_json="$(
  herdr worktree create \
    --cwd "$root" \
    --branch "$branch" \
    --base "$base" \
    --label "$branch" \
    --no-focus \
    --json
)"
Check local changes
Before creating a worktree, inspect the current checkout:
git -C "$root" status --short
Uncommitted changes remain in the current worktree. If the requested task depends on them, stop and ask the user how to proceed.
Do not perform this check merely to focus an existing workspace.
Start OpenCode
After creating a worktree, retrieve its workspace and pane:
workspace_id="$(
  printf '%s' "$action_json" |
    jq -er '.result.workspace.workspace_id'
)"

pane_id="$(
  printf '%s' "$action_json" |
    jq -er '.result.root_pane.pane_id'
)"
Start OpenCode and focus the workspace:
herdr pane run "$pane_id" opencode --agent plan
herdr workspace focus "$workspace_id"
The original OpenCode session remains in the parent workspace as the coordinator.
