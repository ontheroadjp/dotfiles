#-------------------------------------------------
# Variables
#-------------------------------------------------
# export TERM=xterm-256color
export LANG="en_US.UTF-8"
export DOTFILES_BIN=${DOTPATH}/bin
export WORKSPACE="${HOME}/WORKSPACE"
export PATH=${DOTFILES_BIN}:${PATH}
export PATH=${HOME}/.local/bin:${PATH}
# [[ -x "$(command -v vim)" ]] && export EDITOR=vim
export EDITOR=vim

#-------------------------------------------------
# use color
#-------------------------------------------------
autoload -Uz colors && colors

#-------------------------------------------------
# Generic alias
#-------------------------------------------------
alias c='clear'
alias e='exit'
alias t='tree -C'
alias r='rg'
alias sn='sed -n'
alias h='cd ${HOME}'
alias d='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'
alias r='cd $(ghq root)'
alias init='exec zsh -l'

#-------------------------------------------------
# Load settings
#-------------------------------------------------
# Delayed load NG
zsource ${ZSH_HOME}/zsh.d/core/tmux_logo.zsh
zsource ${ZSH_HOME}/zsh.d/core/prompt.zsh

# Delayed load core
zdefer_source ${ZSH_HOME}/zsh.d/core/zsh.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/tmux.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/cdla.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/ripgrap.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/fd.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/fzf.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/vps.zsh
zdefer_source ${ZSH_HOME}/zsh.d/core/tools.zsh

# Delayed load dev
zdefer_source ${ZSH_HOME}/zsh.d/dev/git.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/docker.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/peco.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/ai.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/dev.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/gemini.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/codex.zsh
zdefer_source ${ZSH_HOME}/zsh.d/dev/claude_code.zsh
# zdefer_source ${ZSH_HOME}/zsh.d/dev/go.zsh
# zdefer_source ${ZSH_HOME}/zsh.d/dev/php.zsh
# zdefer_source ${ZSH_HOME}/zsh.d/dev/ruby.zsh
# zdefer_source ${ZSH_HOME}/zsh.d/dev/vagrant.zsh

# Lazy load processed with external files
zsource ${ZSH_HOME}/zsh.d/dev/node.zsh
zsource ${ZSH_HOME}/zsh.d/dev/python.zsh

echo "Load .zshrc." >&2

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

