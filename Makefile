# Package bundles
OPT_PKGS = \
	asdf aws docker dotnet git goenv gradle java jenv kotlin kubernetes nodejs \
	maven nodenv openvpn postgres python powershell pyenv rbenv redis ruby rust \
	scala sdkman ssh
LOCAL_PKG = local
DEFAULT_OPT_PKGS = asdf git ssh
SYSTEM_PKG =

# XDG directories
XDG_CONFIG_HOME := $(HOME)/.config
XDG_DATA_HOME := $(HOME)/.local/share
XDG_CACHE_HOME := $(HOME)/.cache
# Non standard
XDG_BIN_HOME := $(HOME)/.local/bin
XDG_LIB_HOME := $(HOME)/.local/lib

# Sub directories with makefiles
SUBDIRS = etc opt/java

# macOS specific settings
ifeq ($(shell uname), Darwin)
	SYSTEM_PKG = macos
	SUBDIRS := $(SUBDIRS) system/$(SYSTEM_PKG)
	LAUNCH_AGENTS = $(HOME)/Library/LaunchAgents
endif

# Linux specific settings
ifeq ($(shell uname), Linux)
	SYSTEM_PKG = linux
	SUBDIRS := $(SUBDIRS) system/$(SYSTEM_PKG)
endif

all: setup link $(SUBDIRS)

setup:
	@stow -t $(HOME) -d $(CURDIR) -S stow
	@mkdir -p $(CURDIR)/$(LOCAL_PKG)
	@mkdir -p $(XDG_CONFIG_HOME)/profile.d
	@mkdir -p $(XDG_CONFIG_HOME)/shell.d
	@mkdir -p $(XDG_DATA_HOME)/shell.d
	@mkdir -p $(XDG_BIN_HOME)
	@mkdir -p $(XDG_LIB_HOME)

link: setup
	@stow -t $(HOME) -d $(CURDIR) -S etc $(LOCAL_PKG)
	@stow -t $(HOME) -d $(CURDIR)/opt -S $(DEFAULT_OPT_PKGS)
	@stow -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)

unlink: setup
	@stow -D -t $(HOME) -d $(CURDIR) -S etc
	@stow -D -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@stow -D -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)

chklink: setup
	@echo "\n--- Files from `etc` currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR) -S etc $(LOCAL_PKG)
	@echo "\n--- System package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/system -S $(SYSTEM_PKG)
	@echo "\n--- Optional package files currently unlinked ---\n"
	@stow -n -v -t $(HOME) -d $(CURDIR)/opt -S $(OPT_PKGS)
	@echo "\n--- These are potentially bogus links ---\n"
	@chkstow -a -b -t $(XDG_CONFIG_HOME)
	@chkstow -a -b -t $(XDG_DATA_HOME)
	@chkstow -a -b -t $(XDG_BIN_HOME)
	@chkstow -a -b -t $(XDG_LIB_HOME)
	@chkstow -a -b -t $(HOME)/.ssh
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
	@rm -f $(XDG_CONFIG_HOME)/asdf/*
	@rm -f $(XDG_CONFIG_HOME)/bash
	@rm -f $(XDG_CONFIG_HOME)/gem
	@rm -f $(XDG_CONFIG_HOME)/git/*
	@rm -f $(XDG_CONFIG_HOME)/hammerspoon
	@rm -f $(XDG_CONFIG_HOME)/homebrew/*
	@rm -f $(XDG_CONFIG_HOME)/karabiner
	@rm -f $(XDG_CONFIG_HOME)/maven/*
	@rm -f $(XDG_CONFIG_HOME)/nvim
	@rm -f $(XDG_CONFIG_HOME)/profile
	@rm -f $(XDG_CONFIG_HOME)/profile.d/*
	@rm -f $(XDG_CONFIG_HOME)/python
	@rm -f $(XDG_CONFIG_HOME)/shell.d/*
	@rm -f $(XDG_CONFIG_HOME)/tmux
	@rm -f $(XDG_CONFIG_HOME)/wgetrc
	@rm -f $(XDG_CONFIG_HOME)/zsh

$(SUBDIRS):
	@$(MAKE) -C $@ $(MAKECMDGOALS)

.DEFAULT: $(SUBDIRS)
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $(MAKECMDGOALS); \
	done

.PHONY: .DEFAULT $(SUBDIRS)
