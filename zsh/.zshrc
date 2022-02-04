# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /home/daan/.linuxbrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls --human-readable --size -1 -S --classify'
alias c='clear'

# virtual env
alias cv="virtualenv venv"
alias av=". venv/bin/activate"
alias dv="deactivate"
alias v="cv; av"

# git
alias gca='git add .&&git commit -m'
alias gpl='git pull'
alias gph='git push'
alias gcp='git checkout production'
alias gc='git checkout'
alias gmp='git merge production'
alias grmc='gcp&&gpl&&gc -&&gmp&&gph'

# kubectl
alias k='kubectl'
alias kd='kubectl describe pods'
alias kgp='kubectl get pods'
alias kgap='k get pods --all-namespaces'
alias ksc='k config set-context --current --namespace='
kshell() {
	k exec --stdin --tty $1 -- /bin/bash
}

# docker
dockerdebug() {
	docker run -it $1 /bin/bash
}

# switch between azure subscriptions
function azctx() {
    local sub
    sub=$(az account list --query "[].name" -o tsv | sort -f | fzf -q "$1")
    [ -n "$sub" ] && az account set --subscription "$sub"
}

