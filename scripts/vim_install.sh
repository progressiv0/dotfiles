#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

<<<<<<< HEAD
echo "Link .vim directory"
ln -s $DOTFILE_DIR/.vim ~/.vim
#if [ -f ~/.vimrc ] && ! [ -L ~/.vimrc ]
  echo ".vimrc already exists, move existing file to ~/.vimrcBACKUP"
  mv ~/.vimrc ~/.vimrcBACKUP
#fi

echo "Link .vimrc file"
ln -s $DOTFILE_DIR/.vimrc ~/.vimrc

=======
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

>>>>>>> b6460d8da8f0d6e9aa3c8d45ba4eefad004091b1
echo "Install vim plugins"
vim -c "PluginInstall" -c "q!" -c "q!"

