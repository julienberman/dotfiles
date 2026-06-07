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

### Notes

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


