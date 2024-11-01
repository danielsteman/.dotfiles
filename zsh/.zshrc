# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc..zsh
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(/opt/homebrew/bin/brew shellenv)
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Poetry
fpath+=~/.zfunc
autoload -Uz compinit && compinit

# the following to 
# ~/.zprofile (for login shells)
# and ~/.zshrc (for interactive shells) :

# Deno
export DENO_INSTALL="/Users/danielsteman/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# show history from 1
alias hist='history 1'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls --human-readable --size -1 -S --classify'
alias c='clear'

# virtual env
alias av='cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" && . .venv/bin/activate && which python3'
alias dv="deactivate"

# pip
alias pi="pip install -r requirements.txt&&pip install -r requirements-dev.txt"

# pre-commit install
alias pci="pre-commit install --install-hooks -t pre-commit -t commit-msg"

# git
alias gd='git diff'
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gcp='git checkout production'
alias gc='git checkout'
alias gsh='git stash'
alias gshp='git stash pop'
alias gmp='git merge production'
alias gmm='git merge main'
alias gmd='git merge development'
alias grmc='gcp&&gpl&&gc -&&gmp&&gph'
alias cdr='cd "$(git rev-parse --show-toplevel || echo .)"'

gca() {
  orig_dir="$(pwd)"
  cd "$(git rev-parse --show-toplevel 2>/dev/null || echo .)" || return
  git add .
  git commit -m "$1"
  cd "$orig_dir" || return
}

# expose .env, hence: ee
ee() {
  if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
    echo "yeeted .env in env"
  else
    echo ".env not found in this dir"
  fi
}

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

kgsy() {
  local svc
  svc=$(kubectl get svc -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf)
  kubectl get svc "$svc" -o yaml
}

kgpy() {
  local pod
  pod=$(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf)
  kubectl get pod "$pod" -o yaml
}

# terraform
alias tf='terraform'

# neovim
alias vim='nvim'
alias v='nvim .'

# rust
alias cr='cargo run'

# python
alias python='python3'
alias prun='poetry run python'

# databricks
alias d='databricks'

# databricks create asset bundle from template
bundleinit() {
    local options="ml
entity
source"

    local selected_template=$(echo "$options" | fzf)
    databricks bundle init https://gitlab.com/b5087/data-platform/bundle-templates --template-dir "templates/$selected_template"
}

# databricks: start pipeline
dsp() {
    d pipelines start-update $1
}

# databricks get pipelines
dgp() {
    local pipeline_id
    pipeline_id=$(d pipelines list-pipelines | jq -r '.[] | .name + "\t" + .pipeline_id' | xargs printf "%-40s %-40s\n" | fzf | awk -F ' +' '{print $2}')

    operations=("start" "stop")
    operation=$(echo "${operations[@]}" | tr ' ' '\n' | fzf)


    if [ "$operation" == "start" ]; then
        d pipelines start-update $pipeline_id
    elif [ "$operation" == "stop" ]; then
        d pipelines stop $pipeline_id
    else
        echo "Invalid operation selected."
    fi
}

# databricks get catalogs
dgc() {
    local catalogs
    catalogs=()

    local tables
    tables=()

    # Fetch all catalogs
    while read -r catalog; do
        catalogs+=("$catalog")
    done < <(databricks catalogs list | awk '{print $1}' | tail -n +3)

    # for catalog in "${catalogs[@]}"; do
    #     echo "$catalog"
    # done

    for catalog in "${catalogs[@]}"; do
        local schemas
        schemas=()

        # Fetch all schemas for the current catalog
        while read -r schema; do
            schemas+=("$schema")
        done < <(databricks schemas list "$catalog" | awk '{print $1}' | tail -n +2)

        for schema in "${schemas[@]}"; do

            echo $schema

            # Fetch tables for each schema in the current catalog
            while read -r table; do
                tables+=("$table")
            done < <(databricks tables list "$(echo "$string" | cut -d'.' -f1)" "$(echo "$string" | cut -d'.' -f2-)")
        done
    done

    # Do something with the collected tables
    # Example: Print all tables
    for table in "${tables[@]}"; do
        echo "$table"
    done
}

# add install location of poetry to path
export PATH="$HOME/.local/bin:$PATH"

# java
jcar() { javac $1.java && java $1 "$@"; }

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

# List repos in azure devops
# Pull or `cd` the selected repo
function azgetrepo() {
  local name
  name=$(\
    az repos list \
    --organization https://dev.azure.com/asrnl \
    --project analyticslab-p \
    --query "[].name" -o tsv \
    | sort -f \
    | fzf \
  )
  echo "$name"
}

# Utils
killport(){
  sudo kill -9 $(sudo fuser -n tcp $1 2> /dev/null);
}

ccd() {
  local repo
  repo=$(ls ~/repos | fzf)
  code ~/repos/$repo
}

# keybinds
bindkey ";5C" forward-word
bindkey ";5D" backward-word

SAVEHIST=10000
HISTSIZE=10000
HISTFILE=~/.zsh_history

. "$HOME/.cargo/env"
source "$HOME/.rye/env"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# source nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
