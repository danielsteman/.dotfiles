mkdir ~/.config
ln -s ~/.dotfiles/nvim/ ~/.config/nvim
cp ~/.dotfiles/zsh/.p10k.zsh ~/.p10k.zsh

echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
