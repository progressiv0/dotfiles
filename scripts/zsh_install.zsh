if [ ! -n "~/.zshrc" ]; then
  ln -s ~/.dotfiles/.zshrc ~/.zshrc
fi
chmod 644 ~/.dotfiles/.zshrc
# chmod 644 ~/.dotfiles/.zsh/zsh-completions/src/*
