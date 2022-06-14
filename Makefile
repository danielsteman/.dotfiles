all: install_brew

install_brew:
	@echo "Installing Brew"
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
