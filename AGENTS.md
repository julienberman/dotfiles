# AGENTS.md

Guidelines for AI coding agents working in this dotfiles repository.

## Repository Overview
Personal dotfiles repository managed with **GNU Stow**. Each top-level directory is a package that symlinks to `$HOME`. Supports MacOS and Arch Linux.

## Theme
Consistently use Catppuccin Mocha for all tools, unless otherwise specified.

## Organization
/backgrounds # pngs for desktop background 
/clipse # 
/ghostty # terminal emulator
/git # git version control settings 
/hypridle # idle daemon for hyprland (triggers actions on inactivity, e.g. screen lock)
/hyprland # hyprland compositor config
/hyprlock # lock screen for hyprland
/hyprmocha # catppuccin mocha theme for hyprland
/hyprpaper # wallpaper daemon for hyprland 
/hyprsunset # blue light filter for hyprland 
/ipython # interactive python shell config (startup scripts, etc.)
/nvim # Neovim editor config (keymaps, plugins, LSP settings, etc.)
/opencode # Settings for AI assistant CLI tool
/visidata # VisiData configuration
/skhd # Hotkey daemon for MacOS (keybindings)
/starship # Cross-shell prompt customization
/swaync # Notification daemon for wayland
/tmux # Terminal multiplexer config
/waybar # Status bar for wayland compositors 
/wofi # Application launcher for wayland
/yazi # Terminal file manager
/zathura # Minimal pdf document viewer 

## Commands

### Installation
```bash
stow -t "$HOME" <package>    # Symlink a package to $HOME
stow -D -t "$HOME" <package> # Remove symlinks for a package
```

### Neovim
```
:Lazy sync       # Sync plugins to match config
:Lazy update     # Update all plugins
:Mason           # Manage LSP servers and tools
:checkhealth     # Diagnose configuration issues
```

## Specific configurations

### Neovim 
- Location: `nvim/.config/nvim/`
- Structure:
```
nvim/.config/nvim/
├── init.lua              # Main config: globals, options, keymaps, plugin setup
└── lua/plugins/          # Individual plugin configs (one file per plugin)
    ├── nvim-lspconfig.lua # Each plugin file returns a table with the plugin spec
    ├── telescope.lua
    ├── treesitter.lua
    └── ...
```
- All plugins should be added as a separate file in plugins/
- Plugin file format
```lua
return {
    "author/plugin-name",
    dependencies = {
        "dep/one",
        { "dep/two", opts = {} },
    },
    config = function()
        -- Plugin configuration
    end,
}
```

## Style

### Configs 
- Use section headers with comment blocks (e.g., `###### GLOBALS ######`)
- Group related settings together
- Split configs into multiple files when necessary


