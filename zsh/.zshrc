# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# Source Kubesess
source ~/.kube/kubesess/scripts/sh/completion.sh

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

# pip
alias pi="pip install -r requirements.txt&&pip install -r requirements-dev.txt"

# git
alias gca='git add .&&git commit -m'
alias gpl='git pull'
alias gph='git push'
alias gcp='git checkout production'
alias gc='git checkout'
alias gsh='git stash'
alias gshp='git stash pop'
alias gmp='git merge production'
alias grmc='gcp&&gpl&&gc -&&gmp&&gph'

# kubectl
alias k='kubectl'
alias kd='kubectl describe pods'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kgap='k get pods --all-namespaces'
alias ksc='k config set-context --current --namespace='
alias kverbs='kubectl api-resources --verbs=list'
alias krd='kubectl run -i --tty --rm debug --image=busybox --restart=Never -- sh'
alias busyshell='k exec -it busybox -- /bin/sh'

# terraform
alias tf='terraform'

# neovim
alias vim='nvim'

# open shell in pod
kshell() {
	k exec --stdin --tty $1 -- /bin/bash
}

kdebug() {
	k run demo-worker -i --tty --image=$1 -- bash
}

# open shell in container
dockerdebug() {
	docker run -it $1 /bin/bash
}

# switch between azure subscriptions
function azctx() {
    local sub
    sub=$(az account list --query "[].name" -o tsv | sort -f | fzf -q "$1")
    [ -n "$sub" ] && az account set --subscription "$sub"
}

# create azure devops pull request
function pr() {
	local repo=$(basename `git rev-parse --show-toplevel`)
	local branch=$(git rev-parse --abbrev-ref HEAD)
	local target="${TARGET:=production}"
	#az repos pr create --title $0 --description $1 --repository "$repo" --source-branch "$branch" --target-branch "$target" --squash "true"
	echo $1
	echo $2
}

# list azure devops repos
lrps() {
  az repos list | jq ".[].name" | fzf
}

# keybinds
bindkey ";5C" forward-word
bindkey ";5D" backward-word

SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
