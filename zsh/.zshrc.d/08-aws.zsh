# 09-aws.zsh
# -------------------------------------------------------------
# AWS CLI login helper.

aws_login() {
  local aws_config_file="${AWS_CONFIG_FILE:-$HOME/.aws/config}"
  local chosen_profile

  if [[ ! -f $aws_config_file ]]; then
    echo "AWS config file not found at $aws_config_file"
    return 1
  fi

  chosen_profile=$(
    grep -E '^\[profile ' "$aws_config_file" \
      | sed -E 's/^\[profile (.+)\]$/\1/' \
      | fzf
  )

  if [[ -n $chosen_profile ]]; then
    # Use the selected profile in the command
    eval "$(aws configure export-credentials --profile "$chosen_profile" --format env)"
    echo "Switched to profile: $chosen_profile"
  else
    echo "No profile selected."
  fi
}

