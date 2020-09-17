# -------------------------------------------------
# show sub directories
# -------------------------------------------------
alias lla='la $(find . -type d | grep -v .git | peco)'
alias laa='la $(find . -type d | grep -v .git | peco)'

# -------------------------------------------------
# cd to sub directory
# -------------------------------------------------
function _cd_to_sub_directory() {
    [[ $(ls -F | wc -l) -eq 0 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(find . -type d | grep -v ^.$ | grep -v .git | sort | uniq | peco --prompt "to SUB DIR.>" --query "${*}" 2>/dev/null)
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

echo "Load peco settings."
