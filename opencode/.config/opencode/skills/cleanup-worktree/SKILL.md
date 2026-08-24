---
name: cleanup-worktree
description: Clean up and close a git worktree through Herdr. Use when the user asks to delete a branch or after filing and merging a PR. Requires HERDR_ENV=1.
---

## Invariants

- Herdr is the sole owner of Git worktrees and worktree workspaces. Do not use an OpenCode worktree plugin or run `git worktree` commands directly.
- Operate only when `HERDR_ENV=1`. If `HERDR_ENV` is not 1, stop and explain that worktree orchestration must run inside Herdr.
- Treat the worktree, local branch, and remote branch as separate resources.
- Never transfer, copy, commit, or discard uncommitted changes before cleaning up or removing a new worktree.

## Clean up worktree

### 1. Resolve the worktree

- Read Herdr's worktree metadata:
```bash
worktrees_json="$(herdr worktree list --cwd "$PWD" --json)"

source_workspace_id="$(
  printf '%s' "$worktrees_json" |
    jq -er '.result.source.source_workspace_id'
)"

source_checkout_path="$(
  printf '%s' "$worktrees_json" |
    jq -er '.result.source.source_checkout_path'
)"

target_json="$(
  printf '%s' "$worktrees_json" |
    jq -ce --arg workspace "$HERDR_WORKSPACE_ID" '
      .result.worktrees[]
      | select(.open_workspace_id == $workspace)
    '
)"

branch="$(printf '%s' "$target_json" | jq -er '.branch')"

worktree_path="$(printf '%s' "$target_json" | jq -er '.path')"

is_linked_worktree="$(
  printf '%s' "$target_json" |
    jq -er '.is_linked_worktree'
)"
```
### 2. Check For Local Changes
- Check tracked and untracked changes.
- If the git status is non-empty, stop.
- Never use `herdr worktree remove --force`.
- Never commit, stash, transfer, discard, or delete local changes automatically

### 3. Verify The Pull Request
- Search for a merged pull request for the branch:
```bash
merged_pr_json="$(
  gh pr list \
    --head "$branch" \
    --state merged \
    --limit 1 \
    --json number,url,mergedAt,baseRefName
)"
```
- Continue with cleanup if and only if: a merged PR was found, the worktree is clean, and no unpushed commits were found.
- Otherwise, ask for explicit permission from the User before proceeding, and explain what could be lost. Example:
```
No pull request can be found for <branch>. Proceeding with clean up will permanently delete the local worktree and local branch. The remote branch will remain unchanged. Continue?
```

### 4. Clean the worktree
- Record the current commit before detaching:
```bash
head="$(git -C "$worktree_path" rev-parse HEAD)"
```
- Detach the worktree so its local branch can be deleted:
```bash
git -C "$worktree_path" switch --detach "$head"
```
- Attempt to safely delete branch:
```bash
git -C "$source_checkout_path" branch -d -- "$branch"
```
- If abandonment was explicily confirmed by the user, hard delete:
```bash
git -C "$source_checkout_path" branch -D -- "$branch"
```
- If branch deletion fails, restore the worktree with:
```bash
git -C "$worktree_path" switch "$branch"
```
- Focus the source workspace:
```
herdr workspace focus "$source_workspace_id"
```
- Remove the current worktree:
```bash
herdr worktree remove \
  --workspace "$HERDR_WORKSPACE_ID" \
  --json
```
- Never attempt to remove the remote branch

