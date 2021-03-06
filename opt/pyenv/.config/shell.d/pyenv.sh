#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

_pyenv_init() {
  # expensive operation
  eval "$(pyenv init - --no-rehash)"

  # Rehash in the background
  # (pyenv rehash &) 2> /dev/null
}

_pyenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'pyenv init'
  export PYENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  prepend_path "${PYENV_ROOT}/shims"

  # lazy initialize
  lazyfunc _pyenv_init pyenv
}

# Load package manager installed pyenv into shell session
if command_exists "pyenv"; then
  _pyenv_lazy_init

# Load manually installed pyenv into the shell session
elif [[ -s "${PYENV_ROOT}/bin/pyenv" ]]; then
  prepend_path "${PYENV_ROOT}/bin"
  _pyenv_lazy_init

# Return if requirements not found
else
  unset PYENV_ROOT
  unset -f _pyenv_lazy_init
  unset -f _pyenv_init
  return 1
fi
