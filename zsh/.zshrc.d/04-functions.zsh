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
  [ -n "$repo" ] && cursor "$HOME/repos/$repo"
}

# Load .env as environment variables
ee() {
  if [ -f .env ]; then
    set -a
    source .env
    set +a
    echo "yeeted .env in env"
  elif [ -f .env.dev ]; then
    set -a
    source .env.dev
    set +a
    echo "yeeted .env.dev in env"
  else
    echo "No .env or .env.dev found in this dir"
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

# fzf tf workspace list
tfc() {
  # Ensure terraform is available
  if ! command -v terraform >/dev/null 2>&1; then
    echo "terraform not found in PATH" >&2
    return 1
  fi

  # If a workspace name is given, try to select it directly
  if [[ -n "$1" ]]; then
    if terraform workspace list | sed 's/*//; s/^[[:space:]]*//; s/[[:space:]]*$//' | grep -qx "$1"; then
      terraform workspace select "$1"
      return $?
    fi
    # If not found, fall through to fzf
  fi

  # Fallback to interactive selection
  local ws
  ws=$(terraform workspace list \
        | sed 's/*//; s/^[[:space:]]*//; s/[[:space:]]*$//' \
        | fzf --prompt='Terraform workspace> ' --ansi) || return 1

  terraform workspace select "$ws"
}

add-zsh-hook chpwd set_tab_name
add-zsh-hook precmd set_tab_name
