SHELL := /usr/bin/env bash

# Zsh config
ZSH_DIR      := $(HOME)/.dotfiles/zsh
ZSHRC_SOURCE := $(ZSH_DIR)/.zshrc
ZSHRCD_SOURCE := $(ZSH_DIR)/.zshrc.d

ZSHRC_LINK  := $(HOME)/.zshrc
ZSHRCD_LINK := $(HOME)/.zshrc.d

# Neovim config
NVIM_SOURCE := $(HOME)/.dotfiles/nvim
NVIM_LINK   := $(HOME)/.config/nvim

# AeroSpace config
AEROSPACE_SOURCE := $(HOME)/.dotfiles/aerospace/.aerospace.toml
AEROSPACE_LINK   := $(HOME)/.aerospace.toml

# Kitty config
KITTY_SOURCE := $(HOME)/.dotfiles/kitty
KITTY_CONF_LINK := $(HOME)/.config/kitty/kitty.conf
KITTY_SSH_CONF_LINK := $(HOME)/.config/kitty/ssh.conf

# Check if XDG_CONFIG_HOME is set
XDG_CONFIG_HOME := $(shell echo $$XDG_CONFIG_HOME)

# Determine where to link aerospace.toml
ifeq ($(XDG_CONFIG_HOME),)
  AEROSPACE_LINK := $(HOME)/.config/aerospace/aerospace.toml
else
  AEROSPACE_LINK := $(XDG_CONFIG_HOME)/aerospace/aerospace.toml
endif

.PHONY: install
install:
	@echo "Installing Zsh config from '$(ZSH_DIR)'..."

	# Remove existing ~/.zshrc or link
	rm -f $(ZSHRC_LINK)

	# Remove existing ~/.zshrc.d folder or link
	rm -rf $(ZSHRCD_LINK)

	# Create new symlinks for Zsh
	ln -s $(ZSHRC_SOURCE) $(ZSHRC_LINK)
	ln -s $(ZSHRCD_SOURCE) $(ZSHRCD_LINK)
	@echo "Zsh symlinks created:"
	@echo "  $(ZSHRC_LINK)  ->  $(ZSHRC_SOURCE)"
	@echo "  $(ZSHRCD_LINK) ->  $(ZSHRCD_SOURCE)"

	@echo "Installing Neovim config from '$(NVIM_SOURCE)'..."

	# Remove existing ~/.config/nvim
	rm -rf $(NVIM_LINK)

	# Create new symlink for Neovim
	mkdir -p $(HOME)/.config
	ln -s $(NVIM_SOURCE) $(NVIM_LINK)
	@echo "Neovim symlink created:"
	@echo "  $(NVIM_LINK) -> $(NVIM_SOURCE)"

	@echo "Installing AeroSpace config from '$(AEROSPACE_SOURCE)'..."

	# Remove existing aerospace.toml or link
	rm -f $(AEROSPACE_LINK)

	# Create new symlink for AeroSpace config
	mkdir -p $(dir $(AEROSPACE_LINK))
	ln -s $(AEROSPACE_SOURCE) $(AEROSPACE_LINK)
	@echo "AeroSpace symlink created:"
	@echo "  $(AEROSPACE_LINK) -> $(AEROSPACE_SOURCE)"

	@echo "Installing Kitty config from '$(KITTY_SOURCE)'..."

	# Remove existing kitty.conf or link
	rm -f $(KITTY_CONF_LINK)

	# Remove existing ssh.conf or link
	rm -f $(KITTY_SSH_CONF_LINK)

	# Create new symlinks for Kitty config
	mkdir -p $(HOME)/.config/kitty
	ln -s $(KITTY_SOURCE)/kitty.conf $(KITTY_CONF_LINK)
	ln -s $(KITTY_SOURCE)/ssh.conf $(KITTY_SSH_CONF_LINK)
	@echo "Kitty symlinks created:"
	@echo "  $(KITTY_CONF_LINK) -> $(KITTY_SOURCE)/kitty.conf"
	@echo "  $(KITTY_SSH_CONF_LINK) -> $(KITTY_SOURCE)/ssh.conf"

