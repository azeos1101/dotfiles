# Dotfiles

> These are my dotfiles 🎉 ...

```
     _       _    __ _ _
  __| | ___ | |_ / _(_) | ___  ___
 / _` |/ _ \| __| |_| | |/ _ \/ __|
| (_| | (_) | |_|  _| | |  __/\__ \
 \__,_|\___/ \__|_| |_|_|\___||___/
```

![license](https://img.shields.io/github/license/andrewthauer/dotfiles?style=flat-square)
![for hackers](https://img.shields.io/badge/built%20for-hackers-50dd7e.svg?logo=dependabot&style=flat-square)
![awesome](https://img.shields.io/badge/pretty-awesome-ffc24b.svg?logo=sourcegraph&style=flat-square)

## Features

- **extremely fast startup!** with lazy loading for expensive operations.
- **limited dependencies** make it very portable.
- **[`stow`](https://www.gnu.org/software/stow/) powered:** symlink dotfiles and
  thus keep them always up-to-date.
- **topical organized** packages by topic for easy reuse across different
  machines.
- **[xdg compliance](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)**
  when possible to keep `$HOME` clean <sup id="a1">[1](#f1)</sup>.
- **install scripts** for brand new systems and specific topic areas.
- **posix compliant** so it works with most shells (`bash`, `zsh`).
- **optimized for zsh** with auto-completion & syntax highlighting.
- **useful aliases & utilities** for maximum productivity.
- **vim & nvim** work interchangeably.
- **[homebrew](https://brew.sh) compatible** packages with smart fallbacks.

## Pre-requisites

- [`make`](https://www.gnu.org/software/make/)
- [`stow`](https://www.gnu.org/software/stow/stow.html)

## Installation

1. Clone the repo
   `git clone git@github.com:andrewthauer/dotfiles.git ~/.dotfiles`
2. Change directories `~/.dotfiles`
3. Run `make` to run core setup
4. Install desired package via `stow <directory>`
5. Restart your shell ...

### For Brand New Systems:

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/master/install.sh)"
```

See

- [macOS](opt/macos/README.md)
- [Linux](opt/linux/README.md)
- [Windows](opt/windows/README.md)

## Documentation

Each directory contains a `README.md` file that describes it's purpose. Most
directories are topic packages that can be installed by running
`stow <directory>`. This will create symlinks to the appropriate locations
within the `$HOME` directory.

## Directories

- `bin` - General purpose scripts which are added to the path.
- `etc` - Common shell configurations.
- `lib` - Core utilities used throughout. Must be sourced up front.
- `local` - Local system configs & secrets that should never be committed.
- `opt` - Optional packages that can be stowed.
- `opt/{system}` - OS specific package settings.
- `test` - Used to run some basic tests.

_NOTE: Directories starting with an `_underscore` will be ignored by stow._

## Local Customization

The `local` directory (git ignored) can be used to customize the dotfiles for a
particular environment. It is also a good place to store an secret information
you don't want to commit to source control.

## Commands

- `make chklink` - reports links that are not installed or potentially broken.

## Testing

A fresh machine setup can be tested by running `docker-compose` up in the
[test](./test) directory. This will run the install script that is intended to
bootstrap a new system.

### Profiling

It is very important to make sure the shell startup is fast. To help ensure this
there is built-in support for profiling the startup time.

- The `time-zsh` command can be used to profile `zsh` startup time.
- The `time-bash` command will display the execution time for loading a `bash`
  shell

## Inspiration

- [dotfiles.github.io](https://dotfiles.github.io/)
- [F-dotfiles](https://github.com/Kraymer/F-dotfiles)
- [Cowboy](https://github.com/cowboy/dotfiles)
- [holman](https://github.com/holman/dotfiles)
- [b4b4r07](https://github.com/b4b4r07/dotfiles)
- [matiasbynens](https://github.com/mathiasbynens/dotfiles)
- [sorin-ionescu](https://github.com/sorin-ionescu/dotfiles)
- [prezto](https://github.com/sorin-ionescu/prezto)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

## License

MIT © Andrew Thauer

---

<i id="f1">1</i>
[Arch Linux wiki for XDG Base Directory Support](https://wiki.archlinux.org/index.php/XDG_Base_Directory)
