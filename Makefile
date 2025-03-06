# Makefile

# Adjust these paths as needed
ZSHRC_TARGET = $(HOME)/dotfiles/zshrc
ZSHRC_LINK   = $(HOME)/.zshrc

.PHONY: link-zshrc
link-zshrc:
	# Remove any existing ~/.zshrc
	rm -f $(ZSHRC_LINK)
	# Create a symlink
	ln -s $(ZSHRC_TARGET) $(ZSHRC_LINK)
	@echo "Symlink created: $(ZSHRC_LINK) -> $(ZSHRC_TARGET)"

