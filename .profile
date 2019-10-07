#!/usr/bin/env sh
#
# Common environment settings
#

# Dotfiles directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# XDG configuration
export XDG_DATA_HOME="${XDG_DATA_HOME:-"$HOME/.local/share"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"$HOME/.cache"}"

# Terminal
export TERM=xterm

# Editor
export EDITOR=vi
export VISUAL="${EDITOR}"

# Colors
export CLICOLOR=1

# Pager
PAGER='less'
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
LESSKEY="${XDG_CONFIG_HOME}/less/keys"
LESS='-F -g -i -M -R -S -w -X -z-4'
LESSCHARSET='utf-8'

# Set the Less input preprocessor
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN='|lesspipe.sh %s'
fi

# Load a local profile (if exists)
if [[ -f "${XDG_CONFIG_HOME}/.profile.local" ]]; then
  source "${XDG_CONFIG_HOME}/.profile.local"
fi