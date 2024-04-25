#!/bin/zsh

zparseopts  -D -K -- \
    -init=init \
    -link=ln \
    -brew=brew \
    -sync=sync

echo "▓█████▄  ▒█████  ▄▄▄█████▓  ██████▓██   ██▓  ██████ ▄▄▄█████▓▓█████  ███▄ ▄███▓
▒██▀ ██▌▒██▒  ██▒▓  ██▒ ▓▒▒██    ▒ ▒██  ██▒▒██    ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██▒▀█▀ ██▒
░██   █▌▒██░  ██▒▒ ▓██░ ▒░░ ▓██▄    ▒██ ██░░ ▓██▄   ▒ ▓██░ ▒░▒███   ▓██    ▓██░
░▓█▄   ▌▒██   ██░░ ▓██▓ ░   ▒   ██▒ ░ ▐██▓░  ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██    ▒██ 
░▒████▓ ░ ████▓▒░  ▒██▒ ░ ▒██████▒▒ ░ ██▒▓░▒██████▒▒  ▒██▒ ░ ░▒████▒▒██▒   ░██▒
 ▒▒▓  ▒ ░ ▒░▒░▒░   ▒ ░░   ▒ ▒▓▒ ▒ ░  ██▒▒▒ ▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░░ ▒░   ░  ░
 ░ ▒  ▒   ░ ▒ ▒░     ░    ░ ░▒  ░ ░▓██ ░▒░ ░ ░▒  ░ ░    ░     ░ ░  ░░  ░      ░
 ░ ░  ░ ░ ░ ░ ▒    ░      ░  ░  ░  ▒ ▒ ░░  ░  ░  ░    ░         ░   ░      ░   
   ░        ░ ░                 ░  ░ ░           ░              ░  ░       ░   
 ░                                 ░ ░                                         "

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
    echo "Checking for removed packages"
    brew bundle cleanup --force --file ~/.dotfiles/Brewfile
    echo "Installing new packages"
    brew bundle --file ~/.dotfiles/Brewfile
}

# Installs other packages and tools that are required
function packages_sync {
    cargo install dmux

    echo "Installing neovim nightly"
    mkdir ~/.nvim
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
    xattr -c nvim-macos-arm64.tar.gz
    tar xzvf nvim-macos-arm64.tar.gz -C ~/.nvim
    # Cleanup
    rm nvim-macos-arm64.tar.gz
}

if (( $#sync )); then
    echo "Packages running"
    packages_sync
    echo "Packages finished"
fi

if (( $#ln )); then
    echo "Dotlinker running"
    setup_env
    echo "Dotlinker finished"
fi

if (( $#brew )); then
    echo "Brew running"
    brew_sync
    echo "Brew finished"
fi

if (( $#init )); then
    echo "Running firstime setup"
    setup_first
    setup_env
    brew
    echo "Complete first time setup"
fi

