if test -f "~/.zshrc"; then
    read -p "Are you sure you want to overwrite .zshrc and .vimrc? " -n 1 -r
    echo 
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm ~/.zshrc
        ln -s zsh/.zshrc ~
    fi

