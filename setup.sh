#!/bin/zsh

echo "Starting setup..."

# Set up all symlinks before doing anything else 
echo "Creating base symlinks..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/.fzf.zsh ~/.fzf.zsh

# All files and folders under ./config will be symlinked into 
# the current $HOME/.config/ directory
for i in .config/* 
do
    RESOURCE="$(basename "$i")"
    echo "Symlinking ${RESOURCE}..."
    ln -sf ~/.dotfiles/.config/${RESOURCE} ~/.config
done


# Install Homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installig packages"
brew bundle --file ~/.dotfiles/Brewfile

echo "Completed setup"
