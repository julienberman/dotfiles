# Editor
export EDITOR="nvim"
export VISUAL=nvim
bindkey -e      # set emacs keybinds

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export LDFLAGS="-L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql-client/include"

# PATH updates
export PATH="/usr/local/opt/mysql/bin:$PATH"            # mysql
export PATH="/Users/julienberman/.local/bin:$PATH"      # hugging face
export R_PROFILE_USER="$HOME/.config/r/.Rprofile"          # r

# Opencode
export OPENCODE_ENABLE_EXA=1

# Yazi shortcut
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Starship
eval "$(starship init zsh)"


# Conda and Mamba configuration
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/opt/homebrew/bin/mamba';
export MAMBA_ROOT_PREFIX='$HOME/.local/share/mamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

export CONDA_CONFIG="$HOME/.config/conda/condarc"
conda config --set changeps1 false


