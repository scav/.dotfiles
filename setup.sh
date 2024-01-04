#!/bin/zsh

zparseopts  -D -K -- \
    -init=init \
    -link=ln \
    -brew=brew

echo "****************************"
echo "*         DOTSYSTEM        *"
echo "****************************"

# Runs  on initial setup, but never again
function setup_first {
    echo "Installing xcode"
    xcode-select --install

    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
 
    echo "Setting up tmux"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Runs when ever --ln is used and will relink all dotfiles
function setup_env {
    # Set up all symlinks before doing anything else 
    echo "Creating ~/ symlinks"
    ln -sf ~/.dotfiles/.zshrc ~/.zshrc
    ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/.dotfiles/.fzf.zsh ~/.fzf.zsh
    ln -sf ~/.dotfiles/.gitconfig ~/.gitconfig
    
    # All files and folders under ./config will be symlinked into 
    # the current $HOME/.config/ directory
    echo "Creating ~/.config symlinks"
    for i in ~/.dotfiles/.config/* 
    do
        RESOURCE="$(basename "$i")"
        ln -sf ~/.dotfiles/.config/${RESOURCE} ~/.config
    done
}

# Runs when ever --brew is supplied and will do brew stuff
function brew_sync {
    echo "Brew syncing packages"
    brew bundle --file ~/.dotfiles/Brewfile
}

if (( $#ln )); then
    echo "Dotlinker running"
    setup_env
    echo "Dotlinker finished"
fi

if (( $#brew )); then
    echo "Running brew"
    brew_sync
fi

if (( $#init )); then
    echo "Running firstime setup"
    setup_first
    setup_env
    brew
    echo "Complete first time setup"
fi

