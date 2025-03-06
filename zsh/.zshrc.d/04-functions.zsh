# 04-functions.zsh
# -------------------------------------------------------------
# General-purpose shell functions that are not domain-specific.

# Kill a process on a given port
killport(){
  sudo kill -9 "$(sudo fuser -n tcp "$1" 2> /dev/null)" 2> /dev/null
}

# ccd: fuzzy pick a repo under ~/repos and open in VSCode
ccd() {
  local repo
  repo=$(ls ~/repos | fzf)
  [ -n "$repo" ] && code "$HOME/repos/$repo"
}

# Load .env as environment variables
ee() {
  if [ -f .env ]; then
    export "$(grep -v '^#' .env | xargs)"
    echo "yeeted .env in env"
  else
    echo ".env not found in this dir"
  fi
}

# Set kitty (or iTerm) tab title to repo or directory name
function set_tab_name {
    if git_repo=$(git rev-parse --show-toplevel 2>/dev/null); then
        printf "\033]2;%s\007" "$(basename "$git_repo")"
    else
        printf "\033]2;%s\007" "$(basename "$PWD")"
    fi
}

# Called when you change directories
chpwd() { set_tab_name }

# Called before each prompt
precmd() { set_tab_name }

