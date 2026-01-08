# AGENTS.md

Guidelines for AI coding agents working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository managed with **GNU Stow**. Each top-level directory
is a "stow package" that symlinks to `$HOME` using `stow -t "$HOME" [package]`.

**Supported platforms:** macOS (yabai, skhd) and Arch Linux (Hyprland/Wayland ecosystem)

**Theme:** Catppuccin Mocha is used consistently across all tools.

## Build/Lint/Test Commands

This is a configuration repository - there is no centralized build system or test suite.

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

### Tmux
```
prefix + r       # Reload tmux config (prefix is Ctrl+a)
```

### Hyprland
Changes to `hyprland.conf` are applied on save (no restart needed).

## Code Style Guidelines

These rules apply to all code in this repository and any projects where these
dotfiles are used.

### Communication (for agents)
- Be concise. Avoid unnecessary preamble or summary.
- Ask clarifying questions before making assumptions on ambiguous requests.

### General Style
- Prioritize concision, clarity, and readability over cleverness
- **CRITICAL: DO NOT INCLUDE INLINE COMMENTS OR DOCSTRINGS**
- Avoid defining helper functions within the scope of a parent function
- Avoid type hints

### File Organization
Sections separated by two newlines, subsections by one newline:
1. **Imports** - Language-specific deps (alphabetized), then project-specific deps (alphabetized)
2. **Main function** - Global variables (constants, paths), read data, call processing functions
3. **Processing functions** - In order of when they are called by main
4. **Main call** - No other code in this section

### Naming Conventions
| Element | Convention | Example |
|---------|------------|---------|
| Variables, functions, files | snake_case | `clean_data`, `user_name` |
| DataFrame columns | snake_case | `message_id`, `created_at` |
| Classes | CamelCase | `DataProcessor` |
| Global constants | ALL_CAPS | `INDIR_RAW`, `OUTDIR_CLEAN` |
| Data cleaning files | `build_{dataset}` | `build_congress_twitter.py` |
| Data processing files | `process_{dataset}` | `process_congress_twitter.py` |

### File Paths
- Always use `Path` objects for directories and file paths
- Convert to strings only when a service requires it

## Language-Specific Guidelines

### Python / Pandas
- Use method chaining wherever possible
- `.assign()` for creating/mutating columns
- `.query()` for simple filters, `.loc[]` for complex filters
- `.groupby().agg({})` for aggregation, `.transform()` for in-place operations
- `.merge(how=, on=[])` for joins
- Avoid excessive helper functions - each function should accomplish a cohesive task

```python
def clean_data(df):
    df_clean = (
        df
        .clean_names()
        .rename(columns={"id": "message_id"})
        .assign(text=lambda x: clean_text(x["text"], lower=True))
        .drop(columns=["unused_col"])
        .drop_duplicates(subset=["message_id"])
    )
    return df_clean
```

### R
- Use tidyverse syntax wherever possible
- Use `%>%` pipe chaining

### Lua (Neovim)
See detailed Neovim section below.

### Shell Configs (bash, tmux, hyprland)
- Use section headers with comment blocks (e.g., `###### GLOBALS ######`)
- Group related settings together

## Neovim Configuration

Location: `nvim/.config/nvim/`

### Structure
```
nvim/.config/nvim/
├── init.lua              # Main config: globals, options, keymaps, plugin setup
└── lua/plugins/          # Individual plugin configs (one file per plugin)
    ├── nvim-lspconfig.lua
    ├── telescope.lua
    ├── treesitter.lua
    └── ...
```

### Plugin Manager: lazy.nvim
- Plugins are defined in `lua/plugins/*.lua`
- Each plugin file returns a table with the plugin spec
- Check status with `:Lazy`, sync with `:Lazy sync`

### Plugin File Format
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

### Key Conventions
- Leader key: `<Space>`
- Local leader: `<Space>`
- `jj` exits insert mode
- Split navigation: `<C-h/j/k/l>`

### LSP Keymaps (when LSP attached)
| Keymap | Action |
|--------|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

### Adding a New Plugin
1. Create `lua/plugins/<plugin-name>.lua`
2. Return a plugin spec table
3. Add `require("plugins.<plugin-name>")` to `init.lua` in the `lazy.setup()` call
4. Run `:Lazy sync`

### LSP Setup
- Mason manages LSP installations (`:Mason`)
- Add servers to the `servers` table in `nvim-lspconfig.lua`
- Tools like `stylua` are auto-installed via `mason-tool-installer`

### Formatting
- Handled by `conform.nvim` (see `lua/plugins/conform.lua`)
- Lua files formatted with `stylua`

## Configuration File Formats

| Format | Tools | Notes |
|--------|-------|-------|
| Lua | Neovim | Plugin configs return tables |
| TOML | Starship, Yazi | Standard TOML syntax |
| JSON/JSONC | OpenCode, Waybar, clipse | Some support comments |
| Conf | Hyprland, Ghostty, tmux | Tool-specific syntax |
| CSS | Waybar, wofi | Styling for Wayland bars/menus |

## Stow Packages

| Package | Description |
|---------|-------------|
| `nvim` | Neovim editor config |
| `tmux` | Terminal multiplexer |
| `ghostty` | Terminal emulator |
| `git` | Git config (delta pager) |
| `starship` | Cross-shell prompt |
| `hyprland` | Wayland window manager |
| `waybar` | Status bar |
| `wofi` | Application launcher |
| `yazi` | Terminal file manager |
| `opencode` | AI coding assistant rules |
