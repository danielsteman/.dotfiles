# 03-aliases.zsh
# -------------------------------------------------------------
# Central place for simple alias definitions.

# History
alias hist='history 1'

# Some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls --human-readable --size -1 -S --classify'
alias c='clear'

# Virtualenv
alias av='. .venv/bin/activate && which python3'
alias dv='deactivate'

# Pip
alias pi="pip install -r requirements.txt && pip install -r requirements-dev.txt"

# Pre-commit hooks
alias pci="pre-commit install --install-hooks -t pre-commit -t commit-msg"

# Git
alias ga='git add . && echo "All changes in cwd are staged ✨"'
alias gd='git diff'
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gc='git checkout'
alias gcf='git_select_branch'  # we'll define git_select_branch() in 05-git.zsh
alias gsh='git stash'
alias gshp='git stash pop'
alias gmp='git merge production'
alias gmm='git merge main'
alias gmd='git merge development'
alias grmc='gcp && gpl && gc - && gmp && gph'  # If 'gcp' doesn't exist, you can remove it or define it as needed.
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'

# Terraform
alias tf='terraform'

# Neovim
alias vim='nvim'
alias v='nvim .'

# Rust
alias cr='cargo run'

# Python
alias python='python3'
alias prun='poetry run python'

# Docker (for a quick BusyBox shell in a running pod – see k8s aliases)
alias busyshell='k exec -it busybox -- /bin/sh'

# Kubernetes
alias k='kubectl'
alias kgp='k get pods'
alias kgs='k get service'
alias kd='k describe'

# Databricks
alias dbd='databricks bundle deploy'

# Nix
alias dsw='sudo nix run nix-darwin -- switch --flake .'

# macOS
alias lock='open /System/Library/CoreServices/ScreenSaverEngine.app'

# pipenv
alias iv='PIPENV_VENV_IN_PROJECT=1 pipenv install --dev'
