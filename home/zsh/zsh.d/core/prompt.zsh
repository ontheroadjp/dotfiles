# -----------------------------------
# zsh - Git & vi mode
# -----------------------------------
setopt prompt_subst

source ${ZSH_HOME}/plugins/git-prompt.zsh
# GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged but no commit (+)
# GIT_PS1_SHOWUNTRACKEDFILES=true	  # new and untracked file (%)
# GIT_PS1_SHOWSTASHSTATE=false	      # stashed ($)
# GIT_PS1_SHOWUPSTREAM=auto	          # upstream (<, >, <>, =

PROMPT_STYLE=1
alias minimal="PROMPT_STYLE=0"
alias general="PROMPT_STYLE=1"

function zle-line-init {
    # # Right side Prompt
    # RIGHT_VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{yellow}% NORMAL%k%f%K{black}%F{208})%k%f"
    # RIGHT_VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}%F{blue}% INSERT%k%f%K{051}%F{051})%k%f"
    # RPS1="${${KEYMAP/vicmd/$RIGHT_VIM_NORMAL}/(main|viins)/$RIGHT_VIM_INSERT}"
    # RPS2=$RPS1

    if [ ${PROMPT_STYLE} -ne 0 ]; then; __git_ps1_update_fast; fi

    # Left side Prompt
    case $PROMPT_STYLE in
        0) # (MINIMAL)
            ps1_normal="%{%F{red}%}$ %{%f%}"
            ps1_insert="$ "
        ;;
        *) # (GENERAL)
            if [[ -n $VIRTUAL_ENV ]]; then
                VIRTUAL_ENV_PROMPT=" (${${VIRTUAL_ENV:h:t}})"
            else
                VIRTUAL_ENV_PROMPT=""
            fi

            ps1_normal="[\
${TIME} \
${DIR_NAME} \
${GIT_PROMPT}\
${VIRTUAL_ENV_PROMPT}\
]$ "
            TIME="%T" && DIR_NAME="%c" && ps1_insert="[\
%{%F{green}%}${TIME}%{%f%} \
%{%F{blue}%}${DIR_NAME}%{%f%} \
%{%F{red}%}${GIT_PROMPT}%{%f%}\
%{%F{cyan}%}${VIRTUAL_ENV_PROMPT}%{%f%}\
]$ "
        ;;
    esac

    # PS1="${ps1_insert}"
    # zle reset-prompt
    zle-keymap-select
}
# prompt Called immediately after drawing
zle -N zle-line-init

function zle-keymap-select {
    case ${KEYMAP} in
        vicmd) PS1="${ps1_normal}" ;;
        main|viins) PS1="${ps1_insert}" ;;
    esac
    zle reset-prompt
}
# Fires when switching INSERT mode ↔ NORMAL (vi command) mode
zle -N zle-keymap-select

