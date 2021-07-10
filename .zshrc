DOTFILE_DIR=~/.dotfiles
#PATH=$DOTFILE_DIR/dotfunctions:$FPATH

# PROMPT Styling
PROMPT='%B%(?.%F{022}√.%F{red}?%?)%f%b|%F{026}%B%~%b%f${vcs_info_msg_0_}${dir_status} '

# ZSH settings
## Turn of Beeps
unsetopt BEEP

# git plugin support
autoload -Uz vcs_info
autoload -U add-zsh-hook
autoload -Uz compinit
add-zsh-hook precmd git_arrow_customization
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*' formats "$r %F{9}(%b)%f"

git_arrow_customization () {
  vcs_info
  if [ -z "${vcs_info_msg_0_}" ]; then
    dir_status="%F{2}>%f"
  elif [[ -n "$(git diff --cached --name-status 2>/dev/null )" ]]; then
    dir_status="%F{1}▶%f"
  elif [[ -n "$(git diff --name-status 2>/dev/null )" ]]; then
    dir_status="%F{3}▶%f"
  else
    dir_status="%F{2}▶%f"
  fi
}

compinit

# Autocomplete
FPATH=$DOTFILE_DIR/.zsh/zsh-completions/src:$FPATH
zstyle ':completion:*' menu select

# LS Colors
#source $DOTFILE_DIR/.zsh/ls-colors/ls-colors.zsh my-lscolors fmt
#zstyle $pattern list-colors ${(s[:])LS_COLORS} '*.ext=1'
export CLICOLOR=1
# https://www.cyberciti.biz/faq/apple-mac-osx-terminal-color-ls-output-option/
export LSCOLORS=GxFxCxDxBxegedabagaced


# Bindings
## History reverse/forward search with arrow keys
bindkey "^[[A" history-beginning-search-backward # Up
bindkey "^[[B" history-beginning-search-forward # Down

# Aliases
alias la="ls -Gla"
alias ll="ls -Gl"
alias ls="ls -G"
alias gitpullsub="git_pull_subdir"
alias zshreload="source ~/.zshrc"
alias zshedit="vim ~/.zshrc"
alias cdtui="cd ~/Development/source.tui"

# alias aws="docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli"

git_pull_subdir()
{
  SUB_DIR_DEPTH=1
  find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull \;
}

# Run custom configFile
sh $DOTFILE_DIR/.customconfig
