# -------------------------------------------------
# cd to directory within WORKSPACE
# -------------------------------------------------
function _cd_to_workspace_peco() {
    [[ $(find ${WORKSPACE} -type d -maxdepth 1 | wc -l) -eq 1 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(\
        find ${WORKSPACE} -type d -maxdepth 1 | \
        grep -v ^.$ | \
        grep -v .git | \
        sort | \
        uniq | \
        peco --prompt "${WORKSPACE}/" --query "${*}" \
    )
    [ ! -z ${to} ] && cd ${to}
}
alias work='_cd_to_workspace_peco'

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
alias sub='_cd_to_sub_directory'

# -------------------------------------------------
# cd history
# -------------------------------------------------
function _cd_by_dirspeco() {
    [ is_exists peco -ne 0 ] && {
        echo "peco is not installed."
        return 1
    }

    to="$(dirs -v | awk '{print $2}' | sort | uniq | peco --prompt "cd to>" | sed -e s:^~:${HOME}:)"
    [[ ! -z ${to} ]] && cd ${to}
    echo ${to}
}
alias cdh='_cd_by_dirspeco'

#-------------------------------------------------
# SSH
#-------------------------------------------------
function _connect_ssh() {
    local result=$(cat ${HOME}/.ssh/config | \
            grep ^Host \
                | cut -d " " -f 2 \
                | peco --prompt "SSH >"
        )
    [ ! -z ${result} ] && ssh ${result}
}
alias remote='_connect_ssh'

#-------------------------------------------------
# My Memo
#-------------------------------------------------
function _my_memo_peco() {
    local md=$(find ~/memo/ -type f -name '*.md' | peco --prompt "Memo > ")
	[ ! -z ${md}  ] && open ${md}
}
alias memop='_my_memo_peco'

echo "Load peco settings."

