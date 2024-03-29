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

## -----------------------------------
## zsh - vi mode
## -----------------------------------
#function zle-line-init zle-keymap-select {
#    VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{white}% NORMAL%k%f%K{black}%F{208})%k%f"
#    VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}%F{blue}% INSERT%k%f%K{051}%F{051})%k%f"
#    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
#zle -N zle-line-init
#zle -N zle-keymap-select
#
## jj to return normal mode
#bindkey -M viins 'jj' vi-cmd-mode

# -----------------------------------
# zsh - GIT & vi mode
# -----------------------------------
function zle-line-init zle-keymap-select {
    RIGHT_VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{yellow}% NORMAL%k%f%K{black}%F{208})%k%f"
    RIGHT_VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}%F{blue}% INSERT%k%f%K{051}%F{051})%k%f"
    RPS1="${${KEYMAP/vicmd/$RIGHT_VIM_NORMAL}/(main|viins)/$RIGHT_VIM_INSERT}"
    RPS2=$RPS1
    zle reset-prompt

    LEFT_VIM_NORMAL='[%{$fg[yellow]%}%T%{${reset_color}%} %{$fg[yellow]%}%c%{${reset_color}%}'
    LEFT_VIM_INSERT='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'

    LEFT_GIT_STATUS_NORMAL='%{$fg[yellow]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
    LEFT_GIT_STATUS_INSERT='%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '

    case $KEYMAP in
        vicmd)
            PS1="${LEFT_VIM_NORMAL} ${LEFT_GIT_STATUS_NORMAL}"
            ;;
        main|viins)
            PS1="${LEFT_VIM_INSERT}${LEFT_GIT_STATUS_INSERT}"
            ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# jj to return normal mode
bindkey -M viins 'jj' vi-cmd-mode

# -----------------------------------
# zsh complition
# -----------------------------------
## zsh 補完
#source ~/dotfiles/bin/git-completion.zsh

autoload -U compinit
compinit -u

# -----------------------------------
# Display Git branch name
# -----------------------------------
source ~/dotfiles/bin/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged (+)
GIT_PS1_SHOWUNTRACKEDFILES=true     # untracked file (%)
GIT_PS1_SHOWSTASHSTATE=true         # stashed ($)
#GIT_PS1_SHOWUPSTREAM=auto          # upstream (<, >, <>, =)

setopt PROMPT_SUBST;

#function _set_full_prompt() {
#    PS1='[%{$fg[green]%}%n@%m(%T)%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
#    PS1=${PS1}'%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
#    RPROMPT='${memotxt} '"(%?)"
#}
#alias fullprompt='_set_full_prompt'

#function _set_prompt() {
#    PS1='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
#    PS1=${PS1}'%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
#    RPROMPT='${memotxt} '"(%?)"
#    zle reset-prompt
#}
#alias prompt='_set_prompt'

# -----------------------------------
# Base16 Shell
# -----------------------------------
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# ------------------------------------------
# pyenv
# ------------------------------------------
export PYENV_ROOT=/usr/local/var/pyenv
export PATH=”$PYENV_ROOT/shims:$PATH”
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

alias init='source ${HOME}/.zprofile && source ${HOME}/.zshrc'

# ------------------------------------------
# util
# ------------------------------------------
function _noprompt() {
    PS1="$ "
}
alias noprompt='_noprompt'

#_set_prompt
echo "Load .zshrc."
