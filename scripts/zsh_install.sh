#!/bin/bash
sudo apt update && sudo apt install zsh -y

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

if [ ! -f ~/.zshrc ]; then
  echo "Link .zshrc"
  ln -s $DOTFILE_DIR/.zshrc ~/.zshrc
fi

if [ ! -f $DOTFILE_DIR/.custom_profile ]; then
  echo "Create .custom_profile for specific non-global customization"
  echo "#!bin/bash" >> $DOTFILE_DIR/.custom_profile
fi

chsh $USER -s $(which zsh)
zsh
