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
HISTSIZE=1000000            # メモリ上に保存する履歴の件数
SAVEHIST=1000000            # 履歴ファイル（HDD/SSD）に保存する履歴の件数
HISTFILE=${HOME}/.zsh_history  # 履歴の保存先ファイル（デフォルトは ~/.zsh_history）

setopt EXTENDED_HISTORY     # 履歴ファイルに実行時刻を記録する（fzfで見たときには出ませんが、データとして重要）
setopt HIST_IGNORE_DUPS     # 同じコマンドを連続して実行した場合は履歴に残さない
setopt SHARE_HISTORY        # 複数の端末間で履歴を共有する（別のウィンドウで打ったコマンドもすぐ履歴に出る）
setopt APPEND_HISTORY       # 履歴ファイルに追記する（上書きを防ぐ）

#-------------------------------------------------
# vi mode
# kj to return normal mode
#-------------------------------------------------
# bindkey -M viins 'kj' vi-cmd-mode
# bindkey -M viins 'jk' vi-cmd-mode

