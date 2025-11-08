# -----------------------------------
# zsh - Git & vi mode
# -----------------------------------
setopt prompt_subst

source ${ZSH_HOME}/plugins/git-prompt.zsh
# GIT_PS1_SHOWDIRTYSTATE=true         #true|false # unstaged (*) and staged but no commit (+)
# GIT_PS1_SHOWUNTRACKEDFILES=true	  #true|false # new and untracked file (%)
GIT_PS1_SHOWSTASHSTATE=false	      #true|false # stashed ($)
GIT_PS1_SHOWUPSTREAM=false	          #auto|false # upstream (<, >, <>, =)

PROMPT_STYLE=1
alias minimal="PROMPT_STYLE=0"
alias normal="PROMPT_STYLE=1"
SHOW_RIGHT_PROMPT=0
alias righton="SHOW_RIGHT_PROMPT=1"
alias rightoff="SHOW_RIGHT_PROMPT=0"

function zle-line-init {
    # # Right side Prompt
    [ ${SHOW_RIGHT_PROMPT} -ne 0 ] && {
        rps1_normal_value="NORMAL"
        rps1_insert_value="INSERT"
        rps1_normal="(%{%F{yellow}%}${rps1_normal_value}%{%f%})"
        rps1_insert="(%{%F{blue}%}${rps1_insert_value}%{%f%})"
    } || {
        rps1_normal=""
        rps1_insert=""
    }

    if [ ${PROMPT_STYLE} -ne 0 ]; then; __git_ps1_update_fast; fi

    # Left side Prompt
    case ${PROMPT_STYLE} in
        0) # (MINIMAL)
            ps1_normal="%{%F{red}%}$ %{%f%}"
            ps1_insert="$ "
        ;;
        *) # (NORMAL)
            if [[ -n ${VIRTUAL_ENV} ]]; then
                VIRTUAL_ENV_PROMPT=" (${${VIRTUAL_ENV:h:t}})"
            else
                VIRTUAL_ENV_PROMPT=""
            fi

            TIME="%T"
            DIR_NAME="%c"

            ps1_normal="[\
${TIME} \
${DIR_NAME} \
${GIT_PROMPT}\
${VIRTUAL_ENV_PROMPT}\
]$ "
            ps1_insert="[\
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
        vicmd)
            PS1="${ps1_normal}"
            RPS1=${rps1_normal}
            ;;
        main|viins)
            PS1="${ps1_insert}"
            RPS1=${rps1_insert}
            ;;
    esac
    zle reset-prompt
}
# Fires when switching INSERT mode ↔ NORMAL (vi command) mode
zle -N zle-keymap-select

# precmd() {
    # if [ ${PROMPT_STYLE} -ne 0 ]; then; __git_ps1_update_fast; fi
# }
# preexec() {
#   :
# }

