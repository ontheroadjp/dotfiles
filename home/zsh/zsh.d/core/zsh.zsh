#-------------------------------------------------
# zsh
#-------------------------------------------------
# dilay default 0.4sec
KEYTIMEOUT=0

#-------------------------------------------------
# OS specific settings
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # For MacOSX
    zdefer_source ${ZSH_HOME}/zsh.d/core/macosx.zsh
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
    zdefer_source ${ZSH_HOME}/zsh.d/core/ubuntu.zsh
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
    # For Windows (Cygwin) only
    echo 'Welcome to Cygwin!'
else
    # For other OS only
    echo "Wellcome to $(uname -a) !"
fi

#-------------------------------------------------
# complition - zcompdump
#-------------------------------------------------
# delete cache
# rm -f ~/.zcompdump ~/.zcompdump.zwc

autoload -Uz compinit
ZCD=${ZSH_HOME:-$HOME}/.zcompdump

_zcompinit_func() {
    if [[ ! -f ${ZCD}.zwc || ${ZCD} -nt ${ZCD}.zwc ]]; then
        compinit -C -d ${ZCD}
        zcompile ${ZCD}
    else
        compinit -C -d ${ZCD}
    fi
    unfunction _zcompinit_func
}

# Initialize only when Tab is pressed first
#zmodload zsh/complist
# bindkey '^I' complete-word
# (( ${+_compautoload} )) || _compautoload=1

# Delayed execution
zsh-defer _zcompinit_func

#-------------------------------------------------
# zcompcache
#-------------------------------------------------
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path ${ZSH_HOME}/zsh/.zcompcache

#-------------------------------------------------
# History
#-------------------------------------------------
setopt share_history
setopt hist_ignore_dups
setopt hist_space_ignore
setopt extended_history
setopt append_history

HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=${HOME}/.zsh_history

#-------------------------------------------------
# vi mode
# kj to return normal mode
#-------------------------------------------------
# bindkey -M viins 'kj' vi-cmd-mode
# bindkey -M viins 'jk' vi-cmd-mode

