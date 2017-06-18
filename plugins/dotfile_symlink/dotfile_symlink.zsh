#!/usr/bin/env zsh

# gets the symlink director
function dotfile_symlink_target_dir () {
  dir=$1
  root_dir=$2
  if [ "$dir" = "${root_dir}" ]; then
    dir="$HOME"
  else
    dir="$HOME/.${dir}"
  fi
  echo $dir
}

# symlinks all dot files & directories inside a directory
function symlink_dotfile_dir () {
  root_dir=$1

  # Symlink rc files
  for file in ${root_dir}/**/*; do
    # get parent directory info
    parent_dir="$(dirname "$dir")"
    in_symlink_dir=
    # does parent_dir contain .symlink
    test "${parent_dir#*$.symlink}" != "$parent_dir" && in_symlink_dir=true

    # Symlink the entire directory
    if [ -d "$file" ] && [ "${file:e}" = "symlink" ]; then
      dir="${file}"
      dir=$(dirname $dir)
      dir=$(dotfile_symlink_target_dir ${dir#${root_dir}/} ${root_dir})
      symlink_dotfile $file $dir
      echo
    fi

    # Handle files
    if [ "${file:e}" = "symlink" ] && [ "$in_symlink_dir" != "true" ]; then
      dir="${file:h}"
      dir=$(dotfile_symlink_target_dir ${dir#${root_dir}/} ${root_dir})
      symlink_dotfile $file $dir
      echo
    fi
  done
}

# symlinks a dot file (myfile.symlink)
function symlink_dotfile () {
  rcfile=$1
  dest_dir=$2

  # Default to home
  [ -z "$dest_dir" ] && dest_dir=$HOME

  # Prefix file with '.' if dir is ~
  prefix=""
  [ "$dest_dir" = $HOME ] && prefix="."

  # Setup RC file symlinks
  src=$(cd $(dirname $rcfile); pwd)/$(basename $rcfile)
  dest="$dest_dir/$prefix$(basename $src .symlink)"

  # Remove existing symlinks
  if [ -L "$dest" ]; then
    echo "Removing symlink for $dest"
    rm $dest
  fi

  # Create new symlink
  if [ -e "$rcfile" ]; then
    echo "Symlinking '$src' to '$dest'"
    ln -s "$src" "$dest"
  fi
}
