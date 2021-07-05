!/bin/bash

DOTFILE_DIR="$( cd -- "$(dirname "$0")"/.. >/dev/null 2>&1 ; pwd -P )"

if [ ! -n "~/.zshrc" ]; then
  ln -s $DOTFILE_DIR/.zshrc ~/.zshrc
fi
