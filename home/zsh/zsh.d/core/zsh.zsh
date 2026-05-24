#-------------------------------------------------
# zsh
#-------------------------------------------------
# dilay default 0.4sec
KEYTIMEOUT=0

#-------------------------------------------------
# shell-core-tools
#-------------------------------------------------
# dirmarks
source $(ghq root)/github.com/ontheroadjp/shell-core-tools/dirmarks/dirmarks.fnc

# shell-stash
alias ss="$(ghq root)/github.com/ontheroadjp/shell-core-tools/shell-stash/shell-stash.sh"
alias pop="$(ghq root)/github.com/ontheroadjp/shell-core-tools/shell-stash/shell-stash.sh p"

# backup
alias bk="$(ghq root)/github.com/ontheroadjp/shell-core-tools/backup/backup.sh bk"
alias brrm="$(ghq root)/github.com/ontheroadjp/shell-core-tools/backup/backup.sh bkrm"
alias kb="$(ghq root)/github.com/ontheroadjp/shell-core-tools/backup/backup.sh kb"
alias kbrm="$(ghq root)/github.com/ontheroadjp/shell-core-tools/backup/backup.sh kbrm"

#-------------------------------------------------
# OS specific settings
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # For MacOSX
    zsh-defer zsource ${ZSH_HOME}/zsh.d/core/macosx.zsh
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
ZCD=${ZSH_HOME:-$HOME}/.zcompdump

_zcompinit_func() {
    if [[ ! -f ${ZCD}.zwc || ${ZCD} -nt ${ZCD}.zwc ]]; then
        compinit -d ${ZCD}
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

