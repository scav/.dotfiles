#!/bin/sh

# Set up all symlinks before doing anything else 
echo "Creating basic symlinks..."
ln -sf ~/.dotfiles/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/.tmux.conf ~/.tmux.conf

# All files and folders under ./config will be symlinked into 
# the current $HOME/.config/ directory
for i in .config/* 
do
    RESOURCE="$(basename "$i")"
    echo "Symlinking ${RESOURCE}..."
    ln -sf ${HOME}/.dotfiles/.config/${RESOURCE} ${HOME}/.config
done


