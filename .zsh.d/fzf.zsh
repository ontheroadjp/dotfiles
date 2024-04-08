# -------------------------------------------------
# Settings
# -------------------------------------------------
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 80%"
export FZF_DEFAULT_OPTS="
    -0 -1 --reverse --height=100% --pointer='@@' --prompt=': ' \
    --color='bg+:#242C43,bg:#29324D,spinner:#81A1C1,hl:#616E88' \
    --color='fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1' \
    --color='marker:#81A1C1,fg+:#A9D889,prompt:#81A1C1,hl+:#81A1C1' \
"
#export FZF_DEFAULT_OPTS="
#    -0 -1 --reverse --height=100% --pointer='@@' --prompt=': ' \
#    --preview 'bat --color=always {1}' \
#    --preview-window border-down \
#    --color='bg+:#242C43,bg:#29324D,spinner:#81A1C1,hl:#616E88' \
#    --color='fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1' \
#    --color='marker:#81A1C1,fg+:#A9D889,prompt:#81A1C1,hl+:#81A1C1' \
#"

# -------------------------------------------------
# cd to mru
# -------------------------------------------------
## cdr settings
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

function _fzf-cdr () {
    local selected_dir="$(cdr -l | awk '{print $2}' | fzf-tmux -p 65%)"
    if [ -n "$selected_dir" ]; then
        echo $(${selected_dir} | cut -d ' ' -f5 -f6)
        BUFFER="cd $(echo ${selected_dir} | cut -d ' ' -f5 -f6)"
        zle accept-line
    fi
}
zle -N _fzf-cdr
bindkey '^E' _fzf-cdr

# -------------------------------------------------
# Open with vim
# -------------------------------------------------
function _open_with_vim() {
    result=$(rg ~/memo --files -Timg --engine auto --glob=!{TEMP} \
        | fzf --preview 'bat --color=always {1}' --preview-window=down:90%
    )
    [ ! -z "${result}" ] && vim "${result}"
}
alias ,fr='_open_with_vim'

# -------------------------------------------------
# cd to WORKSPACE
# -------------------------------------------------
function _cd_to_workspace_fzf() {
    to=$(\
        find ${WORKSPACE} -type d -maxdepth 1 | \
        grep -v ^.$ | \
        grep -v .git | \
        sort | \
        uniq | \
        fzf \
    )
    [ ! -z ${to} ] && cd ${to}
}
alias ww='_cd_to_workspace_fzf'
#zle -N _cd_to_workspace
#bindkey '^W' _cd_to_workspace

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
