autoload -Uz compinit

# PROMPT Styling
PROMPT='%B%(?.%F{022}√.%F{red}?%?)%f%b|%F{026}%B%~%b%f${vcs_info_msg_0_}${dir_status} '

# ZSH settings
## Turn of Beeps
unsetopt BEEP

# git plugin support
autoload -Uz vcs_info
autoload -U add-zsh-hook
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

# Autocomplete
FPATH=~/.dotfiles/.zsh/zsh-completions/src:$FPATH
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select

# Bindings
## History reverse/forward search with arrow keys
bindkey "^[[A" history-beginning-search-backward # Up
bindkey "^[[B" history-beginning-search-forward # Down

# Aliases
alias ls="ls -la"


# SSH Agent add files
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add ~/.ssh/git_id_rsa20210616
fi
