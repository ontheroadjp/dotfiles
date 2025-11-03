#-------------------------------------------------
# Variables
#-------------------------------------------------
export TERM=xterm-256color
export LANG="en_US.UTF-8"
# export LC_COLLATE="en_US.UTF-8"
# export LC_CTYPE="en_US.UTF-8"
# export LC_MESSAGES="en_US.UTF-8"
if command -v vim >/dev/null 2>&1; then
    export EDITOR=vim
fi
export DOTFILES_BIN=${DOTPATH}/bin
export WORKSPACE="${HOME}/WORKSPACE"
export PATH=${DOTFILES_BIN}:${PATH}
# export PATH=/usr/local/Cellar/node/21.7.1/bin:${PATH}
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}

#-------------------------------------------------
# use color
#-------------------------------------------------
autoload -Uz colors && colors

#-------------------------------------------------
# Functions
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }

#-------------------------------------------------
# Functions for colors
# usage: echo 'piyo' | _red
#-------------------------------------------------
function _black() { xargs -I{} echo $'\e[30m{}\e[m' }
function _red() { xargs -I{} echo $'\e[31m{}\e[m' }
function _green() { xargs -I{} echo $'\e[32m{}\e[m' }
function _yellow() { xargs -I{} echo $'\e[33m{}\e[m' }
function _blue() { xargs -I{} echo $'\e[34m{}\e[m' }
function _pink() { xargs -I{} echo $'\e[35m{}\e[m' }
function _cyan() { xargs -I{} echo $'\e[36m{}\e[m' }
function _white() { xargs -I{} echo $'\e[37m{}\e[m' }

function _black_fill() { xargs -I{} echo $'\e[40m{}\e[m' }
function _red_fill() { xargs -I{} echo $'\e[41m{}\e[m' }
function _green_fill() { xargs -I{} echo $'\e[42m{}\e[m' }
function _yellow_fill() { xargs -I{} echo $'\e[43m{}\e[m' }
function _blue_fill() { xargs -I{} echo $'\e[44m{}\e[m' }
function _pink_fill() { xargs -I{} echo $'\e[45m{}\e[m' }
function _cyan_fill() { xargs -I{} echo $'\e[46m{}\e[m' }
function _white_fill() { xargs -I{} echo $'\e[47m{}\e[m' }

#-------------------------------------------------
# Generic alias
#-------------------------------------------------
alias init='exec $SHELL -l'
# alias init='exec $SHELL -i'
alias c='clear'
alias e='exit'
alias h='cd ${HOME}'
alias dot='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'

#-------------------------------------------------
# OS specific settings
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # For MacOSX
    zsh-defer source ${ZSH_HOME}/zsh.d/core/macosx.zsh
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
    # For Linux only
	echo 'Wellcome to Linux!'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
    # For Windows (Cygwin) only
	echo 'Wellcome to Cygwin!'
else
    # For other OS only
	echo "Wellcome to $(uname -a) !"
fi

#-------------------------------------------------
# Load Core
#-------------------------------------------------
# Delayed load NG
source ${ZSH_HOME}/zsh.d/core/zsh.zsh
source ${ZSH_HOME}/zsh.d/core/tmux.zsh

# Delayed load OK
zsh-defer source ${ZSH_HOME}/zsh.d/core/cdla.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/docker.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/git.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/peco.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/fzf.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/ripgrap.zsh
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

#-------------------------------------------------
# prompt
#-------------------------------------------------
source ${ZSH_HOME}/zsh.d/core/prompt.zsh
# source ${ZSH_HOME}/zsh.d/core/prompt-async.zsh

#-------------------------------------------------
# vi mode
# kj to return normal mode
#-------------------------------------------------
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

# ------------------------------------------
# Cleaning
# ------------------------------------------
zsh-defer unfunction source

echo "Load .zshrc."
# --------------------------------------------------------------------
# interactive shell - load .zshenv and .zshrc
# $ for i in $(seq 1 10); do time zsh -i -c exit > /dev/null ; done

# login shell - load .zshenv, .zshrc, .zprofile
# $ for i in $(seq 1 10); do time zsh -l -c exit > /dev/null ; done
# --------------------------------------------------------------------
# This is for zsh launch performance check
# To use removing comment-out 'zmodload zsh/zprof && zprof'  in ~/.zshenv
# And then, 'exec $SHELL -l' to restart zsh
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi

# ???
# export PATH="/usr/local/sbin:$PATH"
# . "$HOME/.local/bin/env"

