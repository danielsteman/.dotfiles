# 02-environment.zsh
# -------------------------------------------------------------
# General environment variables, PATH changes, shellenv, etc.

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Poetry completions
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Show more history
export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE=~/.zsh_history

# Add install location of Poetry to PATH
export PATH="$HOME/.local/bin:$PATH"

# Java / Postgres (libpq) 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# Python - Rye
if [ -f "$HOME/.rye/env" ]; then
  source "$HOME/.rye/env"
fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT/bin" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi
eval "$(pyenv init -)"

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Docker
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# Go
export PATH="$PATH:$HOME/go/bin"
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Keybindings for moving word by word
bindkey ";5C" forward-word
bindkey ";5D" backward-word

