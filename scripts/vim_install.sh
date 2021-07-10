#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

ln -s $DOTFILE_DIR/.vim ~/.vim
ln -s $DOTFILE_DIR/.vimrc ~/.vimrc

# Install vim plugins
vim -c "PluginInstall" -c "q!" -c "q!"
