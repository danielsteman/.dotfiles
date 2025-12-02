# 05-git.zsh
# -------------------------------------------------------------
# Git-related functions and more advanced aliases.

# FZF-based branch checkout
git_select_branch() {
    # Sort git branches by committer date and checkout selected branch
    branch=$(git branch --sort=-committerdate | fzf)
    if [ -n "$branch" ]; then
        if git checkout "$(echo "$branch" | sed 's/^..//')"; then
            echo ":white_check_mark: Successfully checked out branch: $(git rev-parse --abbrev-ref HEAD)"
        else
            echo ":x: Failed to checkout branch: $branch"
        fi
    else
        echo ":x: No branch selected."
    fi
}

# Add all changes and commit
gca() {
  orig_dir="$(pwd)"
  cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || return
  git add .
  git commit -m "$1"
  cd "$orig_dir" || return
}

# Show tracked files as a tree
gt() {
  git ls-files | awk '{print "./" $0}' | tree --fromfile
}

pr_retrigger_ready() {
  local pr_num
  pr_num=$(gh pr list --author "@me" --json number,title --jq '.[] | "\(.number)\t\(.title)"' | fzf --preview 'echo {}' | cut -f1)

  if [[ -n "$pr_num" ]]; then
    echo "Converting PR #$pr_num to draft..."
    gh pr ready "$pr_num" --undo

    echo "Marking PR #$pr_num as ready for review..."
    gh pr ready "$pr_num"
  else
    echo "No PR selected."
  fi
}

alias prr='pr_retrigger_ready'

# List your remote git branches sorted by creation date, searchable with fzf
# Usage: git-my-branches
# 
# Features:
# - Filters branches by your git user name
# - Sorted by creation date (newest first)
# - Searchable with fzf
# - Shows commit preview when navigating
# - Press Enter to checkout the selected branch
git-my-branches() {
  # Check if fzf is installed
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf is not installed. Please install it first." >&2
    return 1
  fi

  # Check if we're in a git repository
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "Error: Not in a git repository." >&2
    return 1
  fi

  # Fetch latest remote branches
  git fetch --all --prune >/dev/null 2>&1

  # Get your git user name
  local user_name
  user_name=$(git config user.name)
  
  if [[ -z "$user_name" ]]; then
    echo "Error: Git user.name is not configured." >&2
    return 1
  fi

  # List and filter branches, then pipe to fzf
  git for-each-ref --sort=-committerdate \
    --format='%(refname:short)	%(committerdate:iso8601)	%(authorname)' \
    refs/remotes/origin | \
    awk -F'\t' -v user="$user_name" \
      '$3 == user {gsub(/^origin\//, "", $1); print $1, $2}' | \
    fzf \
      --preview='git log --oneline --graph --decorate origin/{1} -10' \
      --header="Your remote branches (sorted by creation date) - $(echo $user_name)" \
      --bind='enter:execute(git checkout {1})+abort' \
      --bind='ctrl-o:execute(git checkout {1})+abort' \
      --height=40% \
      --border
}

alias gcfzf=git-my-branches
