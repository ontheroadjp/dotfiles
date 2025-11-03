# -----------------------------------
# zsh - GIT & vi mode
# -----------------------------------
function _load_git_prompt() {

    # It is more stable & faster without zsh-defer
    source ~/dotfiles/bin/git-prompt.zsh

    setopt prompt_subst
    GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged but no commit (+)
    # GIT_PS1_SHOWUNTRACKEDFILES=true	  # new and untracked file (%)
    # GIT_PS1_SHOWSTASHSTATE=true	      # stashed ($)
    # GIT_PS1_SHOWUPSTREAM=auto	          # upstream (<, >, <>, =
}

PROMPT_STYLE=1
if [ ${PROMPT_STYLE} -ne 0 ]; then; _load_git_prompt; fi

# ---- Colors ----
black="%{$fg[black]%}"
yellow="%{$fg[yellow]%}"
red="%{$fg[red]%}"
cyan="%{$fg[cyan]%}"
green="%{$fg[green]%}"
blue="%{$fg[blue]%}"
reset="%{$reset_color%}"

function zle-line-init {
    # # Right side Prompt
    # RIGHT_VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{yellow}% NORMAL%k%f%K{black}%F{208})%k%f"
    # RIGHT_VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}%F{blue}% INSERT%k%f%K{051}%F{051})%k%f"
    # RPS1="${${KEYMAP/vicmd/$RIGHT_VIM_NORMAL}/(main|viins)/$RIGHT_VIM_INSERT}"
    # RPS2=$RPS1

    # Left side Prompt
    case $PROMPT_STYLE in
        # (MINIMAL)
        0)
            LEFT_VIM_NORMAL=' normal mode:'
            LEFT_GIT_NORMAL=''
            LEFT_VIM_INSERT=' $'
            LEFT_GIT_INSERT=''
        ;;
        # (NORMAL)
        *)
            local tmp=""
            if [[ -n ${VIRTUAL_ENV} ]]; then
                tmp="($(basename "$(dirname "$VIRTUAL_ENV")"))"
            else
                tmp=""
            fi
            VIRTUAL_ENV_PROMPT=${tmp}

            LEFT_VIM_NORMAL=' normal mode:'
            LEFT_GIT_NORMAL=''

            # LEFT_VIM_INSERT='[%{$fg[green]%}%T%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
            # LEFT_GIT_INSERT='%{$fg[red]%}$(__git_ps1 "(%s)")%{${reset_color}%}%{$fg[cyan]%}${VIRTUAL_ENV_PROMPT}%{${reset_color}%}]\$ '
            LEFT_VIM_INSERT='${green}%T${reset} ${blue}%c${reset}'
            # LEFT_GIT_INSERT='${red}$(__git_ps1 "(%s)")${reset}'
            LEFT_GIT_INSERT='${red}${GIT_PROMPT}${reset}'
            LEFT_VIRTUAL_ENV='${cyan}${VIRTUAL_ENV_PROMPT}${reset}'
        ;;
    esac

    case ${KEYMAP} in
        vicmd) PS1="[${LEFT_VIM_NORMAL} ${LEFT_GIT_NORMAL}]\$ " ;;
        main|viins) PS1="[${LEFT_VIM_INSERT} ${LEFT_GIT_INSERT}${LEFT_VIRTUAL_ENV}]\$ " ;;
    esac
    zle reset-prompt
}
zle -N zle-line-init
# zle -N zle-keymap-select

