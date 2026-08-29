---
name: file-pr
description: File a concise pull request. Use when the user asks to file, open, or create a PR.
---

# File PR

Before filing, check whether a PR for this branch already exists. Review the diff locally against `origin/main` to make sure its contents match the goal. 

PR titles usually become commit messages, so follow the repository's title conventions. Look at recently merged PRs and git histories for examples. Prefer a concise, human-readable title that explains what the change does and why it matters.

BAD:
> fix(backend): negotiate permessage-deflate on the websocket

GOOD:
> fix(backend): cut websocket frame size by 70 percent with gzipping

Open the description with a simple explanation of the problem based on the user's prompts. Then briefly explain the solution. Do not lead with an implementation inventory.

BAD:
> Removed implicit workspace carry-over from every "new thread" entry point (cmd+n / cmd+shift+o, sidebar v1/v2 buttons, command palette). New threads inherit only the project from context; branch, worktree, and env mode always come from the configured defaults. Deleted buildContextualThreadOptions, startNewThreadInProjectFromContext, and the v1 sidebar's seed-context machinery.

GOOD:
> My "new worktree" default was ignored when starting new threads on existing worktrees. Super unituitive. Now your preferences always apply. 

Assume, unless otherwise specified by the user, that the PR is **not** stacked. But, if it **is** a stacked PR, make sure to use the `gh stack` commands, rather than the typical git commands.

Open a real PR, not a draft, so that review bots run. If the user also asked to babysit it, continue with the `babysit-pr` skill.
