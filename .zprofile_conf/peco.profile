# -------------------------------------------------
# show sub directories: la (ls -laG)
# -------------------------------------------------
alias lla='la $(find . -type d | grep -v .git | peco)'
alias laa='la $(find . -type d | grep -v .git | peco)'

# -------------------------------------------------
# cd to directory with in WORKSPACE
# -------------------------------------------------
function _cd_to_workspace() {
    [[ $(find ${WORKSPACE_DIR} -type d -maxdepth 1 | wc -l) -eq 1 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(\
        find ${WORKSPACE_DIR} -type d | \
        grep -v ^.$ | \
        grep -v .git | \
        sort | \
        uniq | \
        peco --prompt "${WORKSPACE_DIR}/" --query "${*}" 2>/dev/null \
    )
    [ ! -z ${to} ] && cd ${to}
}
alias cdd='_cd_to_workspace'
zle -N _cd_to_workspace
bindkey '^R' _cd_to_workspace

# -------------------------------------------------
# cd to sub directory: cd
# -------------------------------------------------
function _cd_to_sub_directory() {
    [[ $(find . -type d -maxdepth 1 | wc -l) -eq 1 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(\
        find . -type d | \
        grep -v ^.$ | \
        grep -v .git | \
        sort | \
        uniq | \
        peco --prompt "$(pwd)/" --query "${*}" 2>/dev/null \
    )
    [ ! -z ${to} ] && clear && cd ${to}
}
alias cds='_cd_to_sub_directory'

# -------------------------------------------------
# cd by history: cd
# -------------------------------------------------
function _cd_by_dirspeco() {
    [ is_exists peco -ne 0 ] && {
        echo "peco is not installed."
        return 1
    }

    to="$(dirs -v | awk '{print $2}' | sort | uniq | peco --prompt "cd to >" | sed -e s:^~:${HOME}:)"
    [[ ! -z ${to} ]] && cd ${to}
    echo ${to}
}
alias cdh='_cd_by_dirspeco'

#-------------------------------------------------
# re execute by command history
#-------------------------------------------------
# http://qiita.com/uchiko/items/f6b1528d7362c9310da0

# for bash
#function peco_history() {
#     local command=$( \
#        history 1 | \
#        uniq | \
#        sort -k1,1nr | \
#        sed -e 's/^[0-9\| ]\+//' -e 's/ \+$//' | \
#        perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | \
#        peco
#    )
#    READLINE_POINT=${#command}
#    # for OSX
#    if [ `uname` = "Darwin" ]; then
#        ${READLINE_LINE}
#    fi
#    ${command}
#}
#alias his="his"

# for zsh
function peco-history-selection() {
    BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^H' peco-history-selection
#alias his='peco-history-selection' # doesn't work

# -------------------------------------------------
# cd to directory mark
# -------------------------------------------------
function _markspeco() {
    [ $(ls -U ${dirmarks} | wc -l) -ne 0 ] && {
        local to=$(
            for x in ${dirmarks}/*; do
               [ -e $(cat ${x}) ] && {
                   cat ${x};
               }
            done | sort | uniq | peco --prompt "cd to >"
        )
    }
    [ ! -z ${to} ] && cd ${to}
}
alias cdm='_markspeco'

#-------------------------------------------------
# SSH
#-------------------------------------------------
function _connect_vpn() {
    ssh $(cat .ssh/config | grep ^Host | cut -d " " -f 2 | peco)
}
alias vpn='_connect_vpn'

#-------------------------------------------------
# test
#-------------------------------------------------
function opeco() {
    if [ $# -eq 0 ]; then
        search_dir=$(pwd)
    elif [ ! -d $1 ]; then
        echo "bad argument." && return
    else
        search_dir=$1
    fi

    item=$(ls "${search_dir}" | peco) && [ -z "${item}" ] && return
    while [ -d "${search_dir}/${item}" ]; do
        search_dir="${search_dir}/${item}"
        item=$(ls "${search_dir}" | peco) && [ -z "${item}" ] && return
    done

    if [ -f ${item} ]; then
        cat ${item}
    fi

    #open "${search_dir}/${item}"
    cd "${search_dir}/${item}"
}

function laracast() {
    opeco $HOME/dev/src/github.com/iamfreee/laracasts-downloader/Downloads
}

echo "Load peco settings."
