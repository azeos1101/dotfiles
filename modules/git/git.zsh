#
# Displays the current Git branch.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

function current_branch {
  if ! git rev-parse 2> /dev/null; then
    print "$0: not a repository: $PWD" >&2
    return 1
  fi

  local ref="$(git symbolic-ref HEAD 2> /dev/null)"

  if [[ -n "$ref" ]]; then
    print "${ref#refs/heads/}"
    return 0
  else
    return 1
  fi
}
