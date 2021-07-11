#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

if [ -d ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvimBACKUP
fi

ln -s $DOTFILE_DIR/.config/nvim ~/.config/nvim

$DOTFILE_DIR/scripts/vim_install.sh
