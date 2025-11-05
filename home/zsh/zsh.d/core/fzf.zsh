# -------------------------------------------------
# Settings
# -------------------------------------------------
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"
export FZF_DEFAULT_OPTS="
    -0 -1 --reverse --height=100% --pointer='👉' --prompt=': ' \
    --color='bg+:#242C43,bg:#29324D,spinner:#81A1C1,hl:#616E88' \
    --color='fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1' \
    --color='marker:#81A1C1,fg+:#A9D889,prompt:#81A1C1,hl+:#81A1C1' \
"

# -------------------------------------------------
# live rg
# -------------------------------------------------
# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
# 3. Open the file in Vim
RG_PREFIX="rg \
    --column \
    --line-number \
    --no-heading \
    --color=always \
    --smart-case \
    --hidden \
    "
INITIAL_QUERY="${*:-}"
function _liverg() {
    fzf-tmux \
        -p 90% \
        --ansi \
        --disabled \
        --query "${INITIAL_QUERY}" \
        --bind "start:reload:${RG_PREFIX} {q}" \
        --bind "change:reload:sleep 0.1; ${RG_PREFIX} {q} || true" \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'right,50%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(vim {1} +{2})'
}
alias liverg='_liverg'
alias lrg='_liverg'

# -------------------------------------------------
# cd to mru
# -------------------------------------------------
## cdr settings
CHPWD_RECENT_FILE="${HOME}/.cache/chpwd-recent-dirs"
_setup_chpwd_recent_dirs() {
    if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
        autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
        add-zsh-hook chpwd chpwd_recent_dirs
        zstyle ':completion:*' recent-dirs-insert both
        zstyle ':chpwd:*' recent-dirs-default true
        zstyle ':chpwd:*' recent-dirs-max 1000
        # zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
        zstyle ':chpwd:*' recent-dirs-file ${CHPWD_RECENT_FILE}
    fi
}
_setup_chpwd_recent_dirs

# Delete nonexistent directories
function _cdr-prune() {
    [[ -z "$CHPWD_RECENT_FILE" || ! -f "$CHPWD_RECENT_FILE" ]] && return 0

    # Remove zsh `$'path'` quoting → leave plain path
    # e.g. $'/hoge/foo/bar' → /hoge/foo/bar
    local cleaned
    cleaned=$(sed "s/^.*$'\\(.*\\)'/\\1/" "$CHPWD_RECENT_FILE" | sed "s/^.*'\\(.*\\)'/\\1/")

    # Keep only existing dirs
    printf "%s\n" "$cleaned" | while IFS= read -r dir; do
        [[ -d "$dir" ]] && echo "$dir"
    done | sort -u > "${CHPWD_RECENT_FILE}.tmp"

    mv "${CHPWD_RECENT_FILE}.tmp" "$CHPWD_RECENT_FILE"
}

function _co_to_mru_directory () {
    _cdr-prune
    local dir="$(cdr -l | awk '{print $2}' | sort -u | fzf-tmux -p 50% --ansi)"
    [[ -z "$dir" ]] && return
    dir=${~dir} # ← This will expand ~ to the real path
    cd "$dir" || return
}
alias mru="_co_to_mru_directory"

# -------------------------------------------------
# fzf-powered shell launcher
# -------------------------------------------------
function _fzf_powered_shell() {
    local mode="$1"
    local action="$2"
    local target

    # Action Limit
    case "${action}" in
        cd|echo|vim) ;;
        *)
            echo "Error: invalid action: ${action}"
            return 1
            ;;
    esac

    # Generate selection
    _fzf_source() {
        case "${mode}" in
            sub)
                find . \
                    \( \
                    -path '*/.git*' -o \
                    -path '*/Apps*' -o \
                    -path '*/.dropbox*' -o \
                    -path '*/node_modules*' -o \
                    -path '*/gems*' -o \
                    -path '*/venv*' -o \
                    -path '*/.venv*' -o \
                    -path '*/__pycache__*' -o \
                    -path '*/.cache*' -o \
                    -path '*/dist*' -o \
                    -path '*/build*' -o \
                    -path '*/tmp*' -o \
                    -path '*/temp*' \
                    \) -prune \
                    -o \( -type d -print \) | sort -u

                # fd . . --type d \
                #     --exclude .git \
                #     --exclude node_modules \
                #     --exclude venv \
                #     --exclude __pycache__ \
                #     --exclude gems \
                #     --hidden
                ;;
            ww)
                find "${WORKSPACE}" -type d -maxdepth 1 \
                    | grep -v '^.$' \
                    | grep -v '\.git' \
                    | sort -u
                ;;
            rr)
                ghq list | awk "{print \"$(ghq root)/\" \$0}"
                ;;
            file)
                rg . --hidden --files -Timg --engine auto --glob '!{TEMP}'
                ;;
            *)
                echo "Error: invalid mode: ${mode}"
                return 1
                ;;
        esac
    }

    # fzf Run
    if [[ "${mode}" == "file" ]]; then
        target=$(_fzf_source | fzf-tmux \
            --delimiter : \
            -p 90% \
            --preview 'bat --color=always {}' \
            --preview-window=right:55%)
    else
        target=$(_fzf_source | fzf-tmux -p 50% --ansi)
    fi

    [[ -z "${target}" ]] && return 0

    # Action Execution
    case "${action}" in
        cd)   cd "${target}" ;;
        echo) echo "${target}" ;;
        vim)  vim "${target}" ;;
    esac
}

# directory navigation
alias sub='_fzf_powered_shell sub cd'
alias ww='_fzf_powered_shell ww cd'
alias rr='_fzf_powered_shell rr cd'

alias subp='_fzf_powered_shell sub echo'
alias wwp='_fzf_powered_shell ww echo'
alias rrp='_fzf_powered_shell rr echo'

# file open
alias ,fr='_fzf_powered_shell file vim'
alias ,fp='_fzf_powered_shell file echo'

# -------------------------------------------------
# cd to sub directory
# -------------------------------------------------
# function _print_sub_directory_path() {
#     dir=$(rg --files \
#         | xargs -n1 dirname \
#         | sort -u \
#         | fzf-tmux -p 50% --ansi\
#     )
#     [ ! -z ${dir} ] && echo ${dir}
# }
# function _co_to_sub_directory() {
#     cd $(_print_sub_directory_path)
# }
# alias subprint='_print_sub_directory_path'
# alias sub='_co_to_sub_directory'

# -------------------------------------------------
# cd to WORKSPACE
# -------------------------------------------------
# function _print_workspace_dir() {
#     local dir=$(\
#         find ${WORKSPACE} -type d -maxdepth 1 | \
#         grep -v ^.$ | \
#         grep -v .git | \
#         sort | \
#         uniq | \
#         fzf-tmux -p 50% \
#     )
#     [ ! -z ${dir} ] && echo ${dir}
# }
# function _cd_to_workspace() {
#     cd "$(_print_workspace_dir)"
# }
# alias ww='_cd_to_workspace'
# alias wwprint='_print_workspace_dir'

# -------------------------------------------------
# cd to git local repository (GHQ)
# -------------------------------------------------
# function _print_ghq_repository_dir() {
#     # if ! _is_exist ghq && echo 'no ghq installed.' && return
#     local dir=$(ghq list | fzf-tmux -p 65%)
#     [ ! -z ${dir} ] && echo "$(ghq root)/${dir}"
# }
#
# function _cd_to_ghq_repository() {
#     # if ! _is_exist ghq && echo 'no ghq installed.' && return
#     cd "$(_print_ghq_repository_dir)"
# }
# alias rr='_cd_to_ghq_repository'
# alias rrprint='_print_ghq_repository_dir'

# -------------------------------------------------
# Open with vim
# -------------------------------------------------
# function _open_with_vim() {
#     result=$(rg . --hidden --files -Timg --engine auto --glob=!{TEMP} \
#         | fzf-tmux \
#             --delimiter : \
#             -p 90% \
#             --preview 'bat --color=always {1}' \
#             --preview-window=right:55%\
#         )
#     [ ! -z "${result}" ] && vim "${result}"
# }
# alias ,fr='_open_with_vim'

#-------------------------------------------------
# Command History
#-------------------------------------------------
function _history_selection_fzf() {
    BUFFER=$(history -n 1 | \
        tac  | \
        awk '!a[$0]++' | \
        fzf --reverse --height=30%
    )
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N _history_selection_fzf
bindkey '^H' _history_selection_fzf

#-------------------------------------------------
# Memo
#-------------------------------------------------
function _my_memo_fzf() {
    local md=$(rg -tmd -i --files ~/memo \
        | fzf --preview 'bat --color=always {1}' --preview-window=top:80% )
	[ ! -z ${md}  ] && open ${md}
}
alias memo="_my_memo_fzf $@"

