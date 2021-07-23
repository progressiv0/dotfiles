#!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

if [ ! -f ~/.zshrc ]; then
  echo "Link .zshrc"
  ln -s $DOTFILE_DIR/.zshrc ~/.zshrc
fi

if [ ! -f $DOTFILE_DIR/.customconfig ]; then
  echo "Create .customconfig for specific non-global customization"
  echo "#!bin/bash" >> $DOTFILE_DIR/.customconfig
fi

