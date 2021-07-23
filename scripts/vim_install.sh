#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

echo "Link .vim directory"
ln -s $DOTFILE_DIR/.vim ~/.vim
#if [ -f ~/.vimrc ] && ! [ -L ~/.vimrc ]
  echo ".vimrc already exists, move existing file to ~/.vimrcBACKUP"
  mv ~/.vimrc ~/.vimrcBACKUP
#fi

echo "Link .vimrc file"
ln -s $DOTFILE_DIR/.vimrc ~/.vimrc

echo "Install vim plugins"
vim -c "PluginInstall" -c "q!" -c "q!"
