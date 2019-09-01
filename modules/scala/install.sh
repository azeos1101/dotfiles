#!/usr/bin/env bash
#
# Installs scala toolchain
#

set -e

install_with_brew() {
  # install build tool
  brew install sbt
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/modules/sdkman/init.sh"

  # install build tool
  sdk install sbt

  # install latest version
  sdk install scala

  # reload shell
  exec $SHELL -l
}

install_with_sdk
