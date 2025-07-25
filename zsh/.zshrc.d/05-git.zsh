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
