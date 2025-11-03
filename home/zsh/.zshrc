# Core
export TERM=xterm-256color

# aliases
alias init='exec $SHELL -l'

# prompt
source ${ZSH_HOME}/zsh.d/core/prompt.zsh

# kj to return normal mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

# ------------------------------------------
# Cleaning
# ------------------------------------------
zsh-defer unfunction source

echo "Load .zshrc."
# --------------------------------------------------------------------
# $ for i in $(seq 1 10); do time zsh -i -c exit > /dev/null ; done
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

