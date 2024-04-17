# -----------------------------------
# MiniApp: Memo
# -----------------------------------
function _zsh_prompt_memo(){
    if [ $# -eq 0 ]; then
        unset memotxt
        return
    fi
    for str in $@; do
        memotxt="${memotxt} ${str}"
    done
}
alias pmemo="_zsh_prompt_memo"
alias p="_zsh_prompt_memo"

# -----------------------------------
# zsh - GIT & vi mode hogehoge
# -----------------------------------
function zle-line-init zle-keymap-select {
    # Left side Prompt
    LEFT_VIM_NORMAL='[%{$fg[yellow]%}%T%{${reset_color}%} %{$fg[yellow]%}%c%{${reset_color}%}'
    LEFT_VIM_INSERT='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
    LEFT_GIT_STATUS_NORMAL='%{$fg[yellow]%}$(__git_ps1 "(%s)")%{${reset_color}%}]\$ '
    LEFT_GIT_STATUS_INSERT='%{$fg[red]%}$(__git_ps1 "(%s)")%{${reset_color}%}]\$ '

    # The behavior is the same for switch statements. However, one line is faster.
    PS1="${${KEYMAP/vicmd/$LEFT_VIM_NORMAL $LEFT_GIT_STATUS_NORMAL}/(main|viins)/$LEFT_VIM_INSERT $LEFT_GIT_STATUS_INSERT}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

## jj to return normal mode
bindkey -M viins 'jj' vi-cmd-mode

# -----------------------------------
# Display Git branch name
# -----------------------------------
setopt PROMPT_SUBST;
source ~/dotfiles/bin/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged (+)

function _set_full_prompt() {
    PS1='[%{$fg[green]%}%n@%m(%T)%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
    PS1=${PS1}'%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
}
alias fullprompt='_set_full_prompt'

function _set_prompt() {
    PS1='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
    PS1=${PS1}'%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
    RPROMPT='${memotxt} '"(%?)"
}
alias normal='_set_prompt'

function _noprompt() {
    PS1="$ "
}
alias noprompt='_noprompt'

# ------------------------------------------
# pyenv
# ------------------------------------------
source ${HOME}/dotfiles/.zsh.d/lazy_load_env.sh
_pyenv_init() {
    export PYENV_ROOT=/usr/local/var/pyenv
    export PATH=”$PYENV_ROOT/shims:$PATH”
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
}
eval "$(lazyenv.load _pyenv_init pyenv python pip)"

# ------------------------------------------
# Cleaning
# ------------------------------------------
zsh-defer unfunction source

echo "Load .zshrc."
# --------------------------------------------------------------------
# $ for i in $(seq 1 10); do time zsh -i -c exit > /dev/null ; don
# --------------------------------------------------------------------
# This is for zsh launch performance check
# To use removing comment-out 'zmodload zsh/zprof && zprof'  in ~/.zshenv
# And then, 'exec $SHELL -l' to restart zsh
if (which zprof > /dev/null 2>&1) ;then
  zprof | less
fi

