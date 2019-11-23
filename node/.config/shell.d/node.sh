#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/nodejs" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed nodenv into shell session
elif command_exists "nodenv" || [[ -s "${XDG_DATA_HOME}/nodenv/bin/nodenv" ]]; then
  source_shell_lib 'nodenv'

# Return if requirements not found
elif ! command_exists "node"; then
  unset -f _nodenv_init
  return 1
fi

#
# XDG specifications
#

export NPM_CONFIG_DEVDIR="${XDG_CACHE_HOME}/node-gyp"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/config"
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
# export NPM_CONFIG_TMP="${XDG_RUNTIME_DIR}/npm"
# export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"

#
# Aliases
#

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"

# nodenv
alias nodenv-alias="nodenv alias"
alias nodenv-dpi="nodenv default-packages install --all"
