# Settings
# -------------------------------------------------
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"

export FZF_DEFAULT_OPTS="
    -0 -1 --reverse --height=100% --pointer='👉' --prompt=': ' \
    --color='bg+:#242C43,bg:#29324D,spinner:#81A1C1,hl:#616E88' \
    --color='fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1' \
    --color='marker:#81A1C1,fg+:#A9D889,prompt:#81A1C1,hl+:#81A1C1' \
    --bind ctrl-l:abort \
"


# -------------------------------------------------
# fzf-powered shell launcher
# -------------------------------------------------
_fzf_powered_shell_fd() {
    local mode="$1"
    local action="$2"
    local target
    local dir
    local ext=()

    # mode
    case "${mode}" in
        dir)    local kind="d" ;;
        file)   local kind="f" ;;
        *)      echo "Error: invalid mode: ${mode}"
                return 1
                ;;
    esac

    # Action Limit
    case "${action}" in
        cd|echo|vim|mkdir) ;;
        *)  echo "Error: invalid action: ${action}"
            return 1
            ;;
    esac

    # Target dir
    case "$3" in
        sub) dir="." ;;
        d|dd) dir="${HOME}/dotfiles" ;;
        w|ww) dir="${HOME}/WORKSPACE" ;;
        r|rr) dir="$(ghq root)" ;;
        *) dir="${3:-.}" ;;
    esac

    # ext
    if [[ $action == "vim" ]]; then
        [[ -n "${4:-}" ]] && ext=(-e "$4")
    fi

    # Generate selection
    _fzf_source() {
        fd  "${ext[@]}" --type "${kind}" \
            --exclude .DS_Store \
            --exclude .git \
            --exclude node_modules \
            --exclude venv \
            --exclude __pycache__ \
            --exclude gems \
            --hidden \
            --no-ignore \
            '' "${dir}"
    }

    # fzf Run
    if [[ "${mode}" == "file" || "${mode}" == 'grep' ]]; then
        target=$(_fzf_source | fzf-tmux \
            --delimiter : \
            -p 90% \
            --preview '[[ -f {} ]] && bat --color=always {}' \
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
        mkdir) mkdir -p "${target}/$4" && echo "mkdir: ${target}/$4";;
    esac
}

# directory navigation
ff() { _fzf_powered_shell_fd dir cd . }
dd() { _fzf_powered_shell_fd dir cd d }
ww() { _fzf_powered_shell_fd dir cd w }
rr() { _fzf_powered_shell_fd dir cd r }

# open with vim
vimf() { _fzf_powered_shell_fd file vim . "$@" }
vimd() { _fzf_powered_shell_fd file vim d "$@" }
vimw() { _fzf_powered_shell_fd file vim w "$@" }
vimr() { _fzf_powered_shell_fd file vim r "$@" }

# open file on clipboard
vimcb () {
    local repo_root
    repo_root=$(git rev-parse --show-toplevel 2>/dev/null)
    vim $(fd -E docs "$(wl-paste)" "${repo_root}" | fzf) +${1:-1}
}


# display dir/file path
.f() { _fzf_powered_shell_fd file echo . }
.d() { _fzf_powered_shell_fd file echo d }
.w() { _fzf_powered_shell_fd file echo w }
.r() { _fzf_powered_shell_fd file echo r }

# mkdir
mkdirf() { _fzf_powered_shell_fd dir mkdir . "$@" }
mkdird() { _fzf_powered_shell_fd dir mkdir d "$@" }
mkdirw() { _fzf_powered_shell_fd dir mkdir w "$@" }
mkdirr() { _fzf_powered_shell_fd dir mkdir r "$@" }

_fzf_powered_shell_rg() {
    local dir
    local ext
    local rg_opts=()
    local match
    local file
    local line
    local col

    case "$1" in
        sub)  dir="." ;;
        d|dd) dir="${HOME}/dotfiles" ;;
        w|ww) dir="${HOME}/WORKSPACE" ;;
        r|rr) dir="$(ghq root)" ;;
        *)    dir="." ;;
    esac

    ext="${2:-}"

    [[ -n "$ext" ]] && rg_opts=(-g "*.${ext}")

    match=$(
        rg \
            -uu \
            --color=always \
            "${rg_opts[@]}" \
            . "${dir}" \
        | fzf-tmux -p 90% --ansi
    )

    [[ -z "$match" ]] && return 0

    file=$(printf '%s\n' "$match" | cut -d: -f1)
    line=$(printf '%s\n' "$match" | cut -d: -f2)
    col=$(printf '%s\n' "$match" | cut -d: -f3)

    vim "+call cursor(${line}, ${col})" "$file"
}
vimff() { _fzf_powered_shell_rg sub "$@"; }
vimdd()  { _fzf_powered_shell_rg d "$@"; }
vimww()  { _fzf_powered_shell_rg w "$@"; }
vimrr()  { _fzf_powered_shell_rg r "$@"; }

#-------------------------------------------------
# Command History
#-------------------------------------------------
_history_selection_fzf() {
    local selected

    selected=$(
        fc -rln 1 |
        grep -v '^git commit -m' |
        awk '!seen[$0]++' |
        fzf --reverse --height=40% --query="$BUFFER"
    )

    [[ -z "$selected" ]] && {
        zle reset-prompt
        return
    }

    BUFFER="$selected"
    CURSOR=${#BUFFER}

    zle reset-prompt
}

zle -N history-selection-fzf _history_selection_fzf
bindkey -M viins '^H' history-selection-fzf

#-------------------------------------------------
# Memo
#-------------------------------------------------
function _my_memo_fzf() {
    local md=$(rg -tmd -i --files ${WORKSPACE}/Dropbox/note \
        | fzf-tmux \
            --delimiter : \
            -p 90% \
            --preview '[[ -f {} ]] && bat --color=always {}' \
            --preview-window=right:55%)
	[ ! -z ${md}  ] && open ${md}
}
alias memo="_my_memo_fzf $@"

#-------------------------------------------------
# ghq + gh repo list
#-------------------------------------------------
function _ghq_from_gh_repo_list() {
    local ghq_root selected repo local_path

    ghq_root=$(ghq root)

    selected=$(
        gh repo list --limit 1000 \
            --json nameWithOwner,description,visibility \
            --jq '.[] | [.nameWithOwner, .visibility, (.description // "")] | @tsv' \
        | column -t -s $'\t' \
        | fzf-tmux -p 80% --ansi
    )

    [[ -z "$selected" ]] && return 0

    repo=$(echo "$selected" | awk '{print $1}')
    local_path="${ghq_root}/github.com/${repo}"

    if [[ -d "${local_path}" ]]; then
        cd "${local_path}"
    else
        echo "Not found locally. Running: ghq get git@github.com:${repo}.git"
        ghq get "git@github.com:${repo}.git" && cd "${local_path}"
    fi
}
alias repo='_ghq_from_gh_repo_list'

