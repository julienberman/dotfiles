## Nvim config

Always a work in progress. Built from [kickstart](https://github.com/nvim-lua/kickstart.nvim).

### System Dependencies

#### MacOS

```bash
brew install neovim
brew install git
brew install ripgrep            # Fast grep (used by picker)
brew install node               # Required for some LSPs and tools
brew install npm                # Required for markdown-preview
brew install tree-sitter-cli    # Required for treesitter language parsers
```

#### ArchLinux

```bash
pacman -S neovim
pacman -S git
pacman -S ripgrep               # Fast grep (used by picker)
pacman -S nodejs                # Required for some LSPs and tools
pacman -S npm                   # Required for markdown preview
pacman -S tree-sitter-cli       # Required for treesitter language parsers
pacman -S base-devel            
pacman -S wl-clipboard          # Required for neovim to paste from system clipboard
```

### Fonts (required)

#### MacOS

```bash
brew install --cask font-caskaydia-cove-nerd-font
```

#### ArchLinux

```bash
sudo pacman -S ttf-cascadia-code-nerd
```

### Language toolchains

```bash
# TODO
```
