# ~/.zshrc

# -------------------------------------------------------------
# 1) Powerlevel10k instant prompt (keep near top of .zshrc)
# -------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------------------------------------
# 2) Source all configs in ~/.zshrc.d
# -------------------------------------------------------------
for rcfile in $HOME/.zshrc.d/*.zsh; do
  [ -r "$rcfile" ] && source "$rcfile"
done

