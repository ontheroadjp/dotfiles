# -------------------------------------------------
# show sub directories
# -------------------------------------------------
alias lla='la $(find . -type d | grep -v .git | peco)'
alias laa='la $(find . -type d | grep -v .git | peco)'

# -------------------------------------------------
# cd to sub directory
# -------------------------------------------------
function _cd_to_sub_directory() {
    [[ $(ls -d | wc -l) -eq 1 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(\
        find . -type d | \
        grep -v ^.$ | \
        grep -v .git | \
        sort | \
        uniq | \
        peco --prompt "$(pwd)" --query "${*}" 2>/dev/null \
            )
    [ ! -z ${to} ] && cd ${to}
}
alias cdd='_cd_to_sub_directory'

# -------------------------------------------------
# cd by history
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
alias cddh='_cd_by_dirspeco'
alias cdh='_cd_by_dirspeco'

#-------------------------------------------------
# cd by history 2
#-------------------------------------------------
# http://qiita.com/uchiko/items/f6b1528d7362c9310da0

function peco_history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
    # for OSX
    if [ `uname` = "Darwin" ]; then
        ${READLINE_LINE}
    fi
    ${l}
}
alias his="peco_history"

# -------------------------------------------------
# cd to directory mark
# -------------------------------------------------
function _markspeco() {
    [ $(ls -U ${dirmarks} | wc -l) -ne 0 ] && {
        to=$(for x in ${dirmarks}/*; do cat ${x}; done | sort | uniq | peco --prompt "cd to >" )
    }
    [ ! -z ${to} ] && cd ${to}
}
alias cddm='_markspeco'
alias cdm='_markspeco'

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
