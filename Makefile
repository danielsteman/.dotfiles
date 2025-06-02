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

