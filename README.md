BAR

### Dotfiles

Configuration files for various tools:
- `ghostty`: terminal emulator
- `nvim`: text editor
- `hyprland`: linux window manager (runs on Wayland)
- `hyprlock`: lock screen for hyprland
- `hypridle`: sleep / shutdown logic for hyprland
- `hyprpaper`: themes for hyprland
- `hyprmocha`: colors for hyprland
- `waybar`: status bar on top of screen
- `wofi`: search menu (think: spotlight search on OSX)

Clone this repository. Then install `GNU stow` which can be installed as follows:
Macos:
```
brew install stow
```

Archlinux:
```
sudo pacman -S stow
```
```
yay -S stow
```

Run the following command to create symlinks of the dotfiles for each tool:
```
stow -t "$HOME" [package]
```


### Neovim Notes

Here are notes to myself of things to work on in order to use my neovim config more efficiently.

1) Base vim, normal mode
- Registers
    - Yank to register with `"ay`
    - Paste from register with `"ap`
    - Yank register, `"0`, saves last yank (but not deletes!)
    - Numbered registers, `"1-9`, saves recently deleted (but not yanked!)
- Macros
    - `q[register]` -> record macro to given register
    - `@[register]` -> apply macro from given register
- Case changing
    - gu[OBJECT] gU[OBJECT] -> change to uppercase / lowercase
2) Base vim, edit mode
- `Ctrl+t` / `Ctrl+d` -> add / remove indent
- `Ctrl+w` -> delete word
- `Ctrl+R [register]` -> paste from register
3) Mini.ai
- `vab` and `vib` -> select around / in brackets
- `vaq` and `viq` -> select around / in quotations
- `vae` and `vie` -> select around / in expression (loop, conditional, function)
    - Note: repeating `ae` or `ie` will select the next level up
- `cana` and `cina` -> edit around / in next argument
4) Mini.surround
- `sai[TEXTOBJECT][CHARACTER]` -> surround textobject with character
    - E.g. `saiw]` -> surround word with `]`
    - E.g. `saib}` -> surround brackets with `}`
    - Note: Open `(`, `[`, and `{` includes a space. Closed `)`, `]`, and `}` does not.
- `sd[CHARACTER]` -> remove characters surrounding cursor
- `sr[CHARACTER]` -> remove characters surrounding cursor
- `sdf` -> remove function declaration
5) Mini.comment
- `gcc` -> comment line
- `gc[OBJECT]` -> comment text object
- `gcgc` -> uncomment comment block
- `dgc` -> delete comment block


### Git Notes

Here are notes to myself for how to use git more effectively.
***ADDING MERGE CONFLICT HERE***
- Info from "main" branch.

1) Plumbing
- Three types of objects -> commits, trees, and blobs.
    - Commits -> points to the project root tree and adds metadata ( parent commit, author, committer, timestamp, message ). This is a pointer to a snapshot of the project.
    - Tree -> way that git stores a directory. Contains blobs and other trees.
    - Blob -> way that git stores a file. Contains the contents of the file.
    - ***NOTE:*** Git reuses tree/blob hashes between commits if the contents of the tree/blob does not change!
- `git cat-file -p [hash]` -> cat out contents of git object
2) The git log
- `git log --graph --oneline --all` -> cat out commit history


3) The HEAD
- Git's pointer to the snapshot of the repo that is currently checked out
- Typically points to a branch, (e.g. HEAD -> main -> fa56def), but can also point directly to a commit. This is called a "detached HEAD".

4) Git branches
- A branch is a named pointer to a commit
- `git branch` -> lists local branches. Branch I am on is marked with a *.
- `git switch [branch]` -> move HEAD to [branch]. `-c` creates a new branch. Uses current commit as branch base.
- `git switch [branch] [hash]
- `git branch -m oldname newname` -> rename branch
- `git branch -d [branch]` delete the branch pointer (not necessarily the commits!)
- `git reset [hash]` -> moves branch pointer to commit. `--hard` discards uncommitted changes. `--soft` keeps changes staged

5) Git merges
- `git merge [target_branch]` -> If on `source_branch`, merges `target_branch` into `source_branch`. The following occurs:
    - Find the "best common ancestor" commit of the two branches.
    - Replay the changes from `source_branch`, starting from the best common ancestor, into a new commit.
    - Replay the changes from `target_branch` onto `source_branch`, starting from the best common ancestor.
    - Record the result as a new commit with two parents.
- Fast-forward merge -> If `target_branch` has all the commits that `source_branch` has, then git just moves the pointer of `source_branch` to the tip of `target_branch`.

6) Git rebases
- `git rebase [target_branch]` -> If on `source_branch`, rebases `source_branch` onto `target_branch`. The following occurs:
    - Find the "best common ancestor" commit of the two branches.
    - Replay the commits of `source_branch` onto the tip of the `target_branch`. ***NOTE:*** Creates new commit hashes.
    - ***NOTE:*** Should never rebase public branches (like `main`). This is because a rebase rewrites commits, and if other devs have those commits, could create problems.
- Now, can switch to `target_branch` and merge `source_branch` into `target_branch`. This will create a fast-forward merge, which preserves history.

7) Remotes
- A `remote` is just a named reference to another repository that is treated as the ultimate source of truth. It is in contrast to `local`, which is a copy of the repository.
- The default name for the `remote` associated with a `local` repository is `origin`
- `git remote add [name] [uri]` -> add [name] (which is located at [uri]) as the remote for a local repository
- `git fetch` -> copies contents of `.git/objects` from `remote` into `local`. ***NOTE:*** does not update local branches or change tree
- `git merge [remote]/[branch]` -> merge remote branch into local branch. ***NOTE:*** updates local branches
- `git pull [remote] [branch]` -> Just combines `git fetch` and `git merge [remote]/[branch]`
- `git push [remote] [branch]` -> send local commits on [branch] to remote [branch]

8) Merge conflicts





