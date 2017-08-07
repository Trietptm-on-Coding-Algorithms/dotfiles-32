#!/bin/bash

function dependency {
    pacaur -Qi $1 &> /dev/null && return
    read -p "Depenencies required: Do you want to install '$1'? [y/N] " choice
    if [[ "${choice^^}" == Y ]]; then
        pacaur -S $1
    fi
}

function symlink {
    CURRENT_REALPATH=$(realpath -m "$2")
    TARGET_REALPATH=$(realpath -m "$1")
    if [[ "$CURRENT_REALPATH" != "$TARGET_REALPATH" ]]; then
        if [[ ! -f "$2" ]] || [[ ! -d "$2" ]]; then
            rm -rf "$2"
        fi
        ln -sr $1 $2
    fi
}

# Compton
echo "Installing compton…"
dependency "compton"
symlink ./files/compton.conf ~/.config/compton.conf

# Neovim
echo "Installing neovim…"
dependency "python python-neovim neovim"
mkdir -p ~/.config/nvim/.backup
symlink ./files/init.vim ~/.config/nvim/init.vim

# Scripts
echo "Installing scripts…"
symlink ./files/Scripts ~/Scripts

# Termite
echo "Installing termite…"
dependency "termite otf-fira-mono ttf-font-awesome"
mkdir -p ~/.config/termite
symlink ./files/termiteconfig ~/.config/termite/config

# Xresources
echo "Installing xresources…"
dependency "otf-fira-mono"
symlink ./files/Xresources ~/.Xresources

# i3-gaps
echo "Installing i3…"
dependency "i3-gaps-git otf-fira-mono ttf-font-awesome maim slop compton feh lemonbar-xft-git"
mkdir -p ~/.config/i3
symlink ./files/i3config ~/.config/i3/config

# UndeadLemon
echo "Installing UndeadLemon…"
dependency "lemonbar-xft-git"
mkdir -p ~/.config/undeadlemon
symlink ./files/lemonconfig.toml ~/.config/undeadlemon/config.toml

# SSH
echo "Installing ssh…"
dependency "openssh"
mkdir -p ~/.ssh
symlink ./files/sshconfig ~/.ssh/config

# Xinitrc
echo "Installing xinit…"
dependency "xorg-xinit xorg-server"
symlink ./files/xinitrc ~/.xinitrc

# Zsh
echo "Installing zsh…"
dependency "zsh zsh-autosuggestions zsh-theme-powerlevel9k"
symlink ./files/zshrc ~/.zshrc
symlink ./files/zprofile ~/.zprofile
