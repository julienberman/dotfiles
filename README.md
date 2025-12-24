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

