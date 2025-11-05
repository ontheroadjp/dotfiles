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
# complition - zcompdump
#-------------------------------------------------
autoload -Uz compinit

# for dump in ${ZSH_HOME}/.zcompdump(N.mh+24); do
#     compinit
# done
# compinit -C

ZCD=${ZSH_HOME:-$HOME}/.zcompdump
_zcompinit_func() {
    if [[ ! -f ${ZCD}.zwc || ${ZCD} -nt ${ZCD}.zwc ]]; then
        compinit -d ${ZCD}
        zcompile ${ZCD}
    else
        compinit -C -d ${ZCD}
    fi
}

# Initialize only when Tab is pressed first
zmodload zsh/complist
bindkey '^I' complete-word
(( ${+_compautoload} )) || _compautoload=1

# Delayed execution
zsh-defer _zcompinit_func

#-------------------------------------------------
# zcompcache
#-------------------------------------------------
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' cache-path ${ZSH_HOME}/zsh/.zcompcache

#-------------------------------------------------
# .zsh_history
#-------------------------------------------------
HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

#-------------------------------------------------
# vi mode
# kj to return normal mode
#-------------------------------------------------
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

