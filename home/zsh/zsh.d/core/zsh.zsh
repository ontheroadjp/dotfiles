#-------------------------------------------------
# zsh
#-------------------------------------------------
[ ${SHELL} = '/bin/zsh' ] && {
    # dilay default 0.4sec
    KEYTIMEOUT=0

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
    # .sshhistory
    #-------------------------------------------------
    HISTFILE=${HOME}/.zsh_history
    HISTSIZE=100000
    SAVEHIST=1000000

    # share .zshhistory
    setopt inc_append_history
    setopt share_history
}

