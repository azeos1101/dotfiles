#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $PROFILE_STARTUP ]] && zmodload zsh/zprof

# Do not throw errors when file globs do not match anything
setopt NULL_GLOB

# Source zsh core scripts
source_files_in $XDG_CONFIG_HOME/zsh/init.d/*.zsh

# Source common interactive shell scripts
source_files_in $XDG_CONFIG_HOME/shell.d/*.sh

# Load the local zsh file
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zshrc.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zshrc.local"
fi
