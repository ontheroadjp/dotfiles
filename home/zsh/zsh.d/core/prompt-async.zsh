# ------------------------------------------------------------
# Async Git Prompt (safe version)
# ------------------------------------------------------------

# 1. Load zsh-async
source ${ZSH_HOME}/plugins/zsh-async/async.zsh

# 2. Start a worker
async_start_worker gitprompt_worker

# 3. Worker function (runs in worker process)
_git_prompt_worker() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "$(__git_ps1 '(%s)')"
    else
        echo ""
    fi
}

# 4. Parent function: receives worker output and updates PS1
_update_git_prompt_async() {
    # Must be called in parent shell
    async_run gitprompt_worker _git_prompt_worker | while read git_prompt; do
        GIT_PROMPT="$git_prompt"
        [[ -o zle ]] && zle reset-prompt
    done
}

# 5. Hooks to trigger Git prompt update
autoload -Uz add-zsh-hook
add-zsh-hook precmd '_update_git_prompt_async'
add-zsh-hook chpwd   '_update_git_prompt_async'

# ------------------------------------------------------------
# Existing prompt definitions (unchanged)
# ------------------------------------------------------------
function zle-line-init {
    case $PROMPT_STYLE in
        0)
            ps1_normal="%{%F{red}%}$ %{%f%}"
            ps1_insert="$ "
        ;;
        *)
            if [[ -n $VIRTUAL_ENV ]]; then
                VIRTUAL_ENV_PROMPT=" (${${VIRTUAL_ENV:h:t}})"
            else
                VIRTUAL_ENV_PROMPT=""
            fi

            TIME="%T"
            DIR_NAME="%c"

            ps1_normal="[\
${TIME} \
${DIR_NAME} \
${GIT_PROMPT} \
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

    PS1="${ps1_insert}"
    zle reset-prompt
}
zle -N zle-line-init

function zle-keymap-select {
    case ${KEYMAP} in
        vicmd) PS1="${ps1_normal}" ;;
        main|viins) PS1="${ps1_insert}" ;;
    esac
    zle reset-prompt
}
zle -N zle-keymap-select
