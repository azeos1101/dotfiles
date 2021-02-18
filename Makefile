# Package bundles
OPT_PKGS = $(sort $(notdir $(wildcard ./opt/*)))
LOCAL_PKGS = $(sort $(notdir $(wildcard ./local*)))
DEFAULT_OPT_PKGS = asdf homebrew
SYSTEM_PKG =

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# Sub directories with makefiles
SUBDIRS = etc

# macOS specific settings
ifeq ($(shell uname), Darwin)
	SYSTEM_PKG = macos
	SUBDIRS := $(SUBDIRS) opt/$(SYSTEM_PKG)
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	SYSTEM_PKG = linux
	SUBDIRS := $(SUBDIRS) opt/$(SYSTEM_PKG)
endif

all: setup link $(SUBDIRS)

shellcheck:
	@shellcheck $$(find . -type f -path '*/bin/**' ! -name '*.*' ! -name 'time-zsh')
	@shellcheck $$(find . -name '*.sh')

check-shfmt:
	@shfmt -i 2 -ci -l $$(find . -type f -path '*/bin/**' ! -name '*.*')
	@shfmt -i 2 -ci -l $$(find . -name '*.sh')

lint: shellcheck check-shfmt

dummy:
	echo $(sort $(notdir $(wildcard ./opt*/*)))

setup:
	@mkdir -p $(CURDIR)/local
	@mkdir -p $(XDG_CONFIG_HOME)/{profile.d,shell.d}
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)
	@ln -sf .dotfiles/etc/.stow-global-ignore $(HOME)/.stow-global-ignore

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S etc local
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(DEFAULT_OPT_PKGS)
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKG)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S etc local
	@stow -D -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKG)

chklink:
	@echo "\n--- Files from 'etc' currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S etc
	@echo "\n--- System package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(SYSTEM_PKG)
	@echo "\n--- Optional package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@echo "\n--- Local packages currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S local
	@stow -n -v -t $(HOME) -d $(CURDIR)/local-opt -S $(LOCAL_OPT_PKGS)
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(XDG_BIN_HOME)
	@chkstow -a -b -t $(XDG_LIB_HOME)
ifeq ($(shell uname), Darwin)
	@chkstow -a -b -t $(LAUNCH_AGENTS)
endif

clean:
	@rm -f $(HOME)/.bashrc
	@rm -f $(HOME)/.bash_profile
	@rm -f $(HOME)/.hushlogin
	@rm -f $(HOME)/.zsh*
	@rm -rf $(HOME)/.ssh/config.d
	@rm -f $(HOME)/.stowrc
	@rm -f $(HOME)/.stow-global-ignore

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: .DEFAULT $(SUBDIRS)
