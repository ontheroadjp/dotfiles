export DISABLE_AUTOUPDATER=1

#-------------------------------------------------
# History
#-------------------------------------------------
HISTSIZE=1000000            # メモリ上に保存する履歴の件数
SAVEHIST=1000000            # 履歴ファイル（HDD/SSD）に保存する履歴の件数
HISTFILE=~/.zsh_history     # 履歴の保存先ファイル（デフォルトは ~/.zsh_history）

# --- オプション設定（より便利にするために） ---
setopt EXTENDED_HISTORY     # 履歴ファイルに実行時刻を記録する（fzfで見たときには出ませんが、データとして重要）
setopt HIST_IGNORE_DUPS     # 同じコマンドを連続して実行した場合は履歴に残さない
setopt SHARE_HISTORY        # 複数の端末間で履歴を共有する（別のウィンドウで打ったコマンドもすぐ履歴に出る）
setopt APPEND_HISTORY       # 履歴ファイルに追記する（上書きを防ぐ）

#-------------------------------------------------
# Variables
#-------------------------------------------------
export TERM=xterm-256color
export LANG="en_US.UTF-8"
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
# alias init='exec $SHELL -l'
alias c='clear'
alias e='exit'
alias t='tree -C'
alias r='rg'
alias sn='sed -n'
alias h='cd ${HOME}'
alias d='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'


function _restart_shell() {
    exec $SHELL -l -i
    local dir="${XDG_DATA_HOME:-$HOME}/printenv"
    local filename="$(date '+%Y%m%d')_printenv.txt"
    mkdir -p "${dir}" && printenv > "${dir}/${filename}"
}
alias init='_restart_shell'

#-------------------------------------------------
# Load Utilities
#-------------------------------------------------
# zsh-defer zsource ${ZSH_HOME}/zsh.d/utilities/functions.zsh

#-------------------------------------------------
# Load Core
#-------------------------------------------------
# Delayed load NG
zsource ${ZSH_HOME}/zsh.d/core/tmux_logo.zsh
zsource ${ZSH_HOME}/zsh.d/core/prompt.zsh

# Delayed load OK
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/zsh.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/tmux.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/cdla.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/ripgrap.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/fd.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/fzf.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/vps.zsh

zsh-defer zsource ${ZSH_HOME}/zsh.d/core/git.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/docker.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/peco.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/ai.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/dev.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/gemini.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/codex.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/core/claude_code.zsh

#-------------------------------------------------
# Load Dev
#-------------------------------------------------
zsh-defer zsource ${ZSH_HOME}/zsh.d/dev/go.zsh
# zsh-defer zsource ${ZSH_HOME}/zsh.d/dev/php.zsh
# zsh-defer zsource ${ZSH_HOME}/zsh.d/dev/ruby.zsh
# zsh-defer zsource ${ZSH_HOME}/zsh.d/dev/vagrant.zsh

# Lazy load processed with external files
zsource ${ZSH_HOME}/zsh.d/dev/node.zsh
zsource ${ZSH_HOME}/zsh.d/dev/python.zsh

#-------------------------------------------------
# Load Tools
#-------------------------------------------------

zsh-defer zsource ${ZSH_HOME}/zsh.d/tools/dirmarks.zsh
zsh-defer zsource ${ZSH_HOME}/zsh.d/tools/shelltools.zsh

# ------------------------------------------
# Cleaning
# ------------------------------------------
unfunction source   # do not zsh-defer defer_for safety

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



