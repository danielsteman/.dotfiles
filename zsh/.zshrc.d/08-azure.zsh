# 08-azure.zsh
# -------------------------------------------------------------
# Azure CLI helpers and fuzzy-finders.

# Switch between azure subscriptions
azctx() {
  local sub
  sub=$(az account list --query "[].name" -o tsv | sort -f | fzf -q "$1")
  if [ -n "$sub" ]; then
    az account set --subscription "$sub"
    echo "Switched to subscription: $sub"
  else
    echo "No subscription selected."
  fi
}

# Fuzzy select an Azure repo
azgetrepo() {
  local name
  name=$(
    az repos list \
    --organization https://dev.azure.com/asrnl \
    --project analyticslab-p \
    --query "[].name" -o tsv \
    | sort -f \
    | fzf
  )
  echo "$name"
}

