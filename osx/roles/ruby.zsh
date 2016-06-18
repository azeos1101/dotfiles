#!/bin/zsh

# Bootstrap
source $DOTFILES/init.zsh
dotfiles_require 'brew'

echo "Updating Homebrew formulas ..."
brew update

# -------------------------------------------
# Install brews

brew_install_or_upgrade 'rbenv'
brew_install_or_upgrade 'ruby-build'