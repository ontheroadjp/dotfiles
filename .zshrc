# -----------------------------------
# zsh - GIT & vi mode
# -----------------------------------
function _load_git_ps1() {
    source ~/dotfiles/bin/git-prompt.sh
    setopt prompt_subst
    GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged but no commit (+)
    # GIT_PS1_SHOWUNTRACKEDFILES=true	  # new and untracked file (%)
    # GIT_PS1_SHOWSTASHSTATE=true	      # stashed ($)
    # GIT_PS1_SHOWUPSTREAM=auto	          # upstream (<, >, <>, =)
}

PROMPT_STYLE=1
if [ ${PROMPT_STYLE} -ne 0 ]; then; _load_git_ps1; fi
function __p() { PROMPT_STYLE=$1 }
# function zle-line-init zle-keymap-select {
function zle-line-init {
   # # Right side Prompt
   # RIGHT_VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{yellow}% NORMAL%k%f%K{black}%F{208})%k%f"
   # RIGHT_VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}%F{blue}% INSERT%k%f%K{051}%F{051})%k%f"
   # RPS1="${${KEYMAP/vicmd/$RIGHT_VIM_NORMAL}/(main|viins)/$RIGHT_VIM_INSERT}"
   # RPS2=$RPS1

    # Left side Prompt

    # if [[ "$(uname)" == "Darwin" ]]; then
    #     SED_CMD="gsed"
    # else
    #     SED_CMD="sed"
    # fi

    case $PROMPT_STYLE in
        0) # (MINIMAL)
            LEFT_VIM_NORMAL=' nomal mode:'
            LEFT_GIT_NORMAL=''
            LEFT_VIM_INSERT=' $'
            LEFT_GIT_INSERT=''
        ;;
        *) # (NORMAL)

            # if [ ! -z ${VIRTUAL_ENV} ]; then
            #     VIRTUAL_ENV_PROMPT=$(echo ${VIRTUAL_ENV} \
            #         | ${SED_CMD} -e 's/^.*\/\(.*\)\/venv$/\(\1\)/')
            # fi

            if [ ! -z ${VIRTUAL_ENV} ]; then
                VIRTUAL_ENV_PROMPT=$(echo ${VIRTUAL_ENV} \
                    | sed -e 's/^.*\/\(.*\)\/venv$/\(\1\)/')
            fi

            LEFT_VIM_NORMAL=' nomal mode:'
            LEFT_GIT_NORMAL=''
            LEFT_VIM_INSERT='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
            LEFT_GIT_INSERT='%{$fg[red]%}$(__git_ps1 "(%s)")%{${reset_color}%}%{$fg[cyan]%}${VIRTUAL_ENV_PROMPT}%{${reset_color}]\$ '
        ;;
    esac

    case ${KEYMAP} in
        vicmd) PS1="${LEFT_VIM_NORMAL} ${LEFT_GIT_NORMAL}" ;;
        main|viins) PS1="${LEFT_VIM_INSERT} ${LEFT_GIT_INSERT}" ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
# zle -N zle-keymap-select

# kj to return normal mode
bindkey -M viins 'kj' vi-cmd-mode
bindkey -M viins 'jk' vi-cmd-mode

# ------------------------------------------
# pyenv
# ------------------------------------------
_pyenv_init() {
    export PYENV_ROOT=/usr/local/var/pyenv
    export PATH=”$PYENV_ROOT/shims:$PATH”
    eval "$(pyenv init -)"
    eval "$(pyenv init --path)"
    # eval "$(pyenv virtualenv-init -)"
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

export PATH="/usr/local/sbin:$PATH"
