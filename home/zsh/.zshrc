#-------------------------------------------------
# Variables
#-------------------------------------------------
export TERM=xterm-256color
export LANG="en_US.UTF-8"
# export LC_COLLATE="en_US.UTF-8"
# export LC_CTYPE="en_US.UTF-8"
# export LC_MESSAGES="en_US.UTF-8"
export DOTFILES_BIN=${DOTPATH}/bin
export WORKSPACE="${HOME}/WORKSPACE"
export PATH=${DOTFILES_BIN}:${PATH}
# [[ -x "$(command -v vim)" ]] && export EDITOR=vim
export EDITOR=vim

#-------------------------------------------------
# use color
#-------------------------------------------------
autoload -Uz colors && colors

#-------------------------------------------------
# Generic alias
#-------------------------------------------------
alias init='exec $SHELL -i'
# alias init='exec $SHELL -i'
alias c='clear'
alias e='exit'
alias h='cd ${HOME}'
alias dot='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'

#-------------------------------------------------
# Load Utilities
#-------------------------------------------------
zsh-defer source ${ZSH_HOME}/zsh.d/utilities/functions.zsh

#-------------------------------------------------
# Load Core
#-------------------------------------------------
# Delayed load NG
source ${ZSH_HOME}/zsh.d/core/tmux_logo.zsh
source ${ZSH_HOME}/zsh.d/core/prompt.zsh

# Delayed load OK
zsh-defer source ${ZSH_HOME}/zsh.d/core/zsh.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/tmux.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/cdla.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/ripgrap.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/fzf.zsh

zsh-defer source ${ZSH_HOME}/zsh.d/core/git.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/docker.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/peco.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/gemini.zsh

#-------------------------------------------------
# Load Dev
#-------------------------------------------------
zsh-defer source ${ZSH_HOME}/zsh.d/dev/go.zsh
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/php.zsh
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/ruby.zsh
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/vagrant.zsh

# Lazy load processed with external files
source ${ZSH_HOME}/zsh.d/dev/node.zsh
source ${ZSH_HOME}/zsh.d/dev/python.zsh

#-------------------------------------------------
# Load others
#-------------------------------------------------
zsh-defer source ${ZSH_HOME}/zsh.d/networking.zsh

#-------------------------------------------------
# Load Tools
#-------------------------------------------------
zsh-defer source ${ZSH_HOME}/zsh.d/tools.zsh

# ------------------------------------------
# Cleaning
# ------------------------------------------
unfunction source   # do not zsh-defer for safety

echo "Load .zshrc."
# --------------------------------------------------------------------
# interactive shell - load .zshenv and .zshrc
# $ for i in $(seq 1 10); do time zsh -i -c exit > /dev/null ; done

# login shell - load .zshenv, .zprofile, .zlogin
# $ for i in $(seq 1 10); do time zsh -l -c exit > /dev/null ; done

# login & interactive shell - load .zshenv, .zshrc, .zprofile, .zlogin
# $ for i in $(seq 1 10); do time zsh -i -l -c exit > /dev/null ; done
# --------------------------------------------------------------------
# This is for zsh launch performance check
# To use removing comment-out 'zmodload zsh/zprof && zprof'  in ~/.zshenv
# And then, 'exec $SHELL -l' to restart zsh
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi

