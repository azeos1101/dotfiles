# SSH helpers

# Create a composite ssh config file
#
# SSH_CONFIGS=(
#   "$DOTFILES_DIR/secrets/ssh/config.base"
#   "$DOTFILES_DIR/secrets/ssh/config.personal"
#   "$DOTFILES_DIR/secrets/ssh/config.work"
# )
#
# Usage: ssh_config_merge
#
ssh_config_merge() {
  local dest_config=

  # if [ -z "$src_configs" ]; then 'No source configs provided'; return; fi

  # Defaults
  [ -z "$dest_config" ] && dest_config="~/.ssh/config"

  # Truncate the file
  if [ -e "$HOME/.ssh/config" ]; then
    echo -n "Do you want to replace the existing '${dest_config}' file [y/N]?"
    read reply
    if [[ $reply =~ ^[Yy]$ ]]; then
      cat /dev/null >! ~/.ssh/config
    fi
  fi

  # Append configs to the ~/.ssh/config
  for conf in "${SSH_CONFIGS[@]}"; do
    cat "$conf" >> ~/.ssh/config
    echo "" >> ~/.ssh/config
  done

  # Update permissions
  chmod 600 ~/.ssh/config
}

# helper aliases
alias sshconfig="$EDITOR ~/.ssh/config"