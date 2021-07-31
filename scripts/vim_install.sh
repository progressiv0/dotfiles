#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

echo "Check for neovim..."
if command -v nvim &> /dev/null; then
  echo "neovim is installed. Setup nvim configuration"
  NVIM_DIR=~/.config/nvim

  if [ -d $NVIM_DIR ] && ! [ -L $NVIM_DIR ]; then
    echo "folder $NVIM_DIR already exists, move folder to ${$NVIM_DIR}BACKUP"
    mv $NVIM_DIR ~/.config/nvimbackup
  fi

  if ! [ -d $NVIM_DIR ]; then
    echo "Link $NVIM_DIR"
    ln -s $DOTFILE_DIR/.config/nvim $NVIM_DIR
  fi
else
  echo "neovim not found. Skip nvim configuration"
fi


if [ -f ~/.vimrc ] && ! [ -L ~/.vimrc ]; then
  echo "folder .vimrc already exists, move file to .vimrcBACKUP"
  mv ~/.vimrc ~/.vimrcBACKUP
fi

if ! [ -f ~/.vimrc ]; then
  echo "Link .vimrc"
  ln -s $DOTFILE_DIR/.vimrc ~/.vimrc
fi

VIM_DIR=~/.vim
if [ -d $VIM_DIR ] && ! [ -L $VIM_DIR ]; then
  echo "folder $VIM_DIR already exists, move folder to ${$VIM_DIR}BACKUP"
  mv $VIM_DIR ~/.vimBACKUP
fi

if ! [ -d $VIM_DIR ]; then
  echo "Link $VIM_DIR"
  ln -s $DOTFILE_DIR/.vim $VIM_DIR
fi

echo "Install vim plugins"
vim -c "PluginInstall" -c "q!" -c "q!"

