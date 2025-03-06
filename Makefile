SHELL := /usr/bin/env bash

# Where your Zsh config is located inside .dotfiles
ZSH_DIR      := $(HOME)/.dotfiles/zsh
ZSHRC_SOURCE := $(ZSH_DIR)/.zshrc
ZSHRCD_SOURCE := $(ZSH_DIR)/.zshrc.d

# Where they should point in your home directory
ZSHRC_LINK  := $(HOME)/.zshrc
ZSHRCD_LINK := $(HOME)/.zshrc.d

.PHONY: install
install:
	@echo "Installing Zsh config from '$(ZSH_DIR)'..."

	# 1) Remove existing ~/.zshrc or link
	rm -f $(ZSHRC_LINK)

	# 2) Remove existing ~/.zshrc.d folder or link
	rm -rf $(ZSHRCD_LINK)

	# 3) Create new symlinks
	ln -s $(ZSHRC_SOURCE) $(ZSHRC_LINK)
	ln -s $(ZSHRCD_SOURCE) $(ZSHRCD_LINK)
	@echo "Symlinks created:"
	@echo "  $(ZSHRC_LINK)  ->  $(ZSHRC_SOURCE)"
	@echo "  $(ZSHRCD_LINK) ->  $(ZSHRCD_SOURCE)"

