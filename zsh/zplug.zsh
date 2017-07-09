#
# Zplug plugins
#

# zplug "zplug/zplug", hook-build:'zplug --self-manage'

# Local zsh setup
zplug "${DOTFILES_DIR}/zsh", from:local, use:"_init.zsh": defer:2

# prezto
zplug "sorin-ionescu/prezto", use:"init.zsh": defer:0
zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/history-substring-search", from:prezto, defer:2

# docker completions
zplug "docker/cli", use:contrib/completion/zsh
zplug "docker/compose", use:contrib/completion/zsh

# oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh

# zsh-nvm plugin
zplug "lukechilds/zsh-nvm"

# zsh-user plugins
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# local plugins
zplug "${DOTFILES_DIR}/plugins/node", from:local
zplug "${DOTFILES_DIR}/plugins/ruby", from:local
zplug "${DOTFILES_DIR}/plugins/ssh", from:local
# zplug "${DOTFILES_DIR}/plugins/zsh-functions", from:local, use:"functions/*", lazy:on

# zsh theme (async for zsh used by pure)
zplug "mafredri/zsh-async", from:github, defer:0
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme, defer:3

# Load any local packages
if [[ -f "${ZPLUG_LOCAL_LOADFILE}" ]]; then
  source "${ZPLUG_LOCAL_LOADFILE}"
fi