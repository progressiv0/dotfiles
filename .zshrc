autoload -U add-zsh-hook
autoload -Uz vcs_info
autoload -Uz compinit
DOTFILE_DIR=~/.dotfiles
#PATH=$DOTFILE_DIR/dotfunctions:$FPATH



# PROMPT Styling
setopt PROMPT_SUBST
newline=$'\n'
SH_ERR='%(?..%F{1}?%?)%f'
SH_TIME='%F{190}[%*]%f${time_symbol}'
SH_ID='%(!.%F{160}.%F{123})%n%f%F{212}@%F{156}%m%f'
SH_DIR='%F{10}%~%f'
PROMPT1='%K{17}'"${SH_TIME}"'|${SH_ID}|${git_dir_status}${SH_DIR}%k'
PROMPT2='${SH_ERR}> '
PS1="${PROMPT1}${newline}${PROMPT2}"
#RPROMPT='${SH_ERR}'
time_symbol_func() {
  current_time=$(date +%H:%M)
  if [[ "$current_time" > "07:00" ]] && [[ "$current_time" < "11:59" ]]; then
    time_symbol="☕"
  elif [[ "$current_time" > "12:00" ]] && [[ "$current_time" < "15:29" ]]; then
    time_symbol="⏳"
  elif [[ "$current_time" > "15:30" ]] && [[ "$current_time" < "21:59" ]]; then
    time_symbol="☯"
  else
    time_symbol="☠"
  fi
}
add-zsh-hook precmd time_symbol_func

# ZSH settings
## Turn of Beeps
unsetopt BEEP
## Preserve History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# git plugin support
#prompt_chpwd+=( vcs_info; FORCE_RUN_VCS_INFO=1; )
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*' formats "$r (%b)"

git_status_func() {
#  echo "status func"
  if [ -z "${vcs_info_msg_0_}" ]; then
    git_dir_status="" # not a git dir
    git_dir_symbol=""
  elif [[ -n "$(git diff --cached --name-status 2>/dev/null )" ]]; then
    git_dir_status='%F{1}'"${vcs_info_msg_0_}"' ▶ %f' # git changes are staged
    git_dir_symbol=":✚"
  elif [[ -n "$(git diff --name-status 2>/dev/null )" ]]; then
    git_dir_status='%F{3}'"${vcs_info_msg_0_}"' ▶ %f' # git unstaged changes exists
    git_dir_symbol=":✕"
  else
    git_dir_status='%F{2}'"${vcs_info_msg_0_}"' ▶ %f' # git no changes
    git_dir_symbol=":✓"
  fi
}
add-zsh-hook chpwd vcs_info
add-zsh-hook chpwd git_status_func

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


# Aliases
alias gitpullsub="git_pull_subdir"
alias dcc="docker-compose"
alias dcex="docker-compose exec"
alias dclo="docker-compose logs --tail=200 -f"
alias dcup="docker-compose up -d"
alias dcre="docker-compose restart"
alias dcst="docker-compose stop"
alias zshreload="source ~/.zshrc"
alias zshedit="vim ~/.zshrc; zshreload;"
alias cdtui="cd ~/Development/source.tui"
alias cdmailcow="cd /opt/dockerimages/mailcow-dockerized"
alias suroot='sudo su -c zsh'
alias gitcc='git add .; git commit -m "changes"'
alias gitccp='git add .; git commit -m "changes"; git push;'
if command -v nvim >> /dev/null 2>&1; then
  alias vim='nvim'
fi

# alias aws="docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli"

git_pull_subdir()
{
  SUB_DIR_DEPTH=1
  find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull \;
}

# Run custom configFile
if [ -f $DOTFILE_DIR/.custom_profile ]; then sh $DOTFILE_DIR/.custom_profile; fi
compinit

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     source $DOTFILE_DIR/.custom_profile_linux;;
    Darwin*)    source $DOTFILE_DIR/.custom_profile_osx;;
    CYGWIN*)    source $DOTFILE_DIR/.custom_profile_win_linux;;
    MINGW*)     source $DOTFILE_DIR/.custom_profile_win_linux;;
    MSYS*)      source $DOTFILE_DIR/.custom_profile_win_linux;;
    *)          echo "Unknown machine"
esac
