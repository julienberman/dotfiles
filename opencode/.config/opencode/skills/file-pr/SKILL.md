---
name: file-pr
description: File a concise pull request. Use when the user asks to file, open, or create a PR.
---

# File PR

Before filing, check whether a PR for this branch already exists. Review the diff locally against `origin/main` to make sure its contents match the goal. Identify the branch where PRs are meant to merge. E.g. `main`, `master`, `develop`.

PR titles usually become commit messages, so follow the repository's title conventions. Look at recently merged PRs and git histories for examples. Prefer a concise, human-readable title that explains what the change does and why it matters. Titles should be simple and easy to understand.

- Identify the branch where PRs are meant to merge. E.g. `main`, `master`, `develop`.


BAD:
> fix(backend): negotiate permessage-deflate on the websocket

GOOD:
> fix(backend): cut websocket frame size by 70 percent with gzipping


PR descriptions should aim for simplicity. Open with a minimal, clear description of the problem. Follow up with a brief explanation of how you solved the problem. Do not lead with an implementation inventory.

BAD:
> Removed implicit workspace carry-over from every "new thread" entry point (cmd+n / cmd+shift+o, sidebar v1/v2 buttons, command palette). New threads inherit only the project from context; branch, worktree, and env mode always come from the configured defaults. Deleted buildContextualThreadOptions, startNewThreadInProjectFromContext, and the v1 sidebar's seed-context machinery.

GOOD:
> My "new worktree" default was ignored when starting new threads on existing worktrees. Super unituitive. Now your preferences always apply. 

Assume, unless otherwise specified by the user, that the PR is **not** stacked. If it **is** a stacked PR, continue with the `gh-stack` skill.

Open a real PR, not a draft, so that review bots run. If the user also asked to babysit it, continue with the `babysit-pr` skill.
