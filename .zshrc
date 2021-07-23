DOTFILE_DIR=~/.dotfiles
#PATH=$DOTFILE_DIR/dotfunctions:$FPATH

# PROMPT Styling
setopt PROMPT_SUBST
SH_ERR='%(?.%F{022}√.%F{red}?%?)%f'
SH_TIME='%F{190}[%*]%f'
SH_ID='%F{123}%n%f@%F{156}%m%f'
PROMPT1='${SH_TIME} | ${SH_ID} | ${SH_ERR} %~'
PROMPT2='> '
PROMPT="${PROMPT1}%2{"$'\n'"%}${PROMPT2}"
# RPROMPT='${SH_ERR}'

# ZSH settings
## Turn of Beeps
unsetopt BEEP
## Preserve History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# git plugin support
autoload -Uz vcs_info
autoload -U add-zsh-hook
autoload -Uz compinit
add-zsh-hook precmd git_arrow
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*' formats "$r %F{9}(%b)%f"

git_arrow() {
  vcs_info
  if [ -z "${vcs_info_msg_0_}" ]; then
    dir_status="%F{2}>%f"
  elif [[ -n "$(git diff --cached --name-status 2>/dev/null )" ]]; then
    dir_status="%F{1}(${vcs_info_msg_0_}) ▶%f"
  elif [[ -n "$(git diff --name-status 2>/dev/null )" ]]; then
    dir_status="%F{3}(${vcs_info_msg_0_}) ▶%f"
  else
    dir_status="%F{2}(${vcs_info_msg_0_}) ▶%f"
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
key=(
   BackSpace  "${terminfo[kbs]}"
    Home       "${terminfo[khome]}"
    End        "${terminfo[kend]}"
    Insert     "${terminfo[kich1]}"
    Delete     "${terminfo[kdch1]}"
    Up         "${terminfo[kcuu1]}"
    Down       "${terminfo[kcud1]}"
    Left       "${terminfo[kcub1]}"
    Right      "${terminfo[kcuf1]}"
    PageUp     "${terminfo[kpp]}"
    PageDown   "${terminfo[knp]}"
)

bindkey "$key[Up]" history-beginning-search-backward # Up
bindkey "$key[Down]" history-beginning-search-forward # Down

# Aliases
alias la="ls -Gla"
alias ll="ls -Gl"
alias ls="ls -G"
alias gitpullsub="git_pull_subdir"
alias dcc="docker-compose"
alias dcex="docker-compose exec"
alias dclo="docker-compose logs --tail=200 -f"
alias dcup="docker-compose up -d"
alias dcre="docker-compose restart"
alias dcst="docker-compose stop"
alias zshreload="source ~/.zshrc"
alias zshedit="vim ~/.zshrc"
alias cdtui="cd ~/Development/source.tui"
alias cdmailcow="cd /opt/dockerimages/mailcow-dockerized"

# alias aws="docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli"

git_pull_subdir()
{
  SUB_DIR_DEPTH=1
  find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull \;
}

# Run custom configFile
if [ -f $DOTFILE_DIR/.customconfig ]; then sh $DOTFILE_DIR/.customconfig; fi
