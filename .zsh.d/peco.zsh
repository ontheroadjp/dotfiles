#--------------------------------------------------
# show sub directories: la (ls -laG)
# -------------------------------------------------
#alias lla='la $(find . -type d | grep -v .git | peco --prompt "sub dir >")'
#alias laa='la $(find . -type d | grep -v .git | peco --prompt "sub dir >")'

## -------------------------------------------------
## open application
## -------------------------------------------------
#function _open_application() {
#    app=$(find /Applications -name '*.app' -maxdepth 2 \
#            | sed -e 's:/Applications/::' \
#            | peco --prompt 'Application > ' \
#        );
#    [ ! -z ${app} ] && { open "/Applications/${app}" }
#}
#alias app=_open_application $@
#zle -N _open_application
#bindkey '^A' _open_application

#-------------------------------------------------
# open with vim ( !! doesn't work !!)
#-------------------------------------------------
#function _open_file_specify_file_extension() {
#    [ ! -z "${1}" ] && {
#        place="$(find . -type d \
#            -name node_modules \
#            -prune \
#            -o \
#            -type d \
#            -name vendor \
#            -prune \
#            -o \
#            -type f \
#            -regex "^.*\.${EXT}$" \
#            | peco --prompt 'open with vim >')"
#        [ ! -z "${place}" ] && {
#            vim ${place}
#        }
#    } || {
#        echo 'need one argument must be file exension'
#    }
#}
#alias ee='_open_file_specify_file_extension'
# usage: $ee md, $ee README etc.

# -------------------------------------------------
# cdr peco
# -------------------------------------------------
#function _peco-cdr () {
##local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="recent dir (cdr) >" --query "$LBUFFER")"
#    #local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | awk '{print $2}' | peco --prompt="cdr >" --query "$LBUFFER")"
#    local selected_dir="$(cdr -l | awk '{print $2}' | peco --prompt="recent dir (cdr) >" --query "$LBUFFER")"
#    if [ -n "$selected_dir" ]; then
#        echo $(${selected_dir} | cut -d ' ' -f5 -f6)
#        BUFFER="cd $(echo ${selected_dir} | cut -d ' ' -f5 -f6)"
#        zle accept-line
#    fi
#}
#
#zle -N _peco-cdr
#bindkey '^E' _peco-cdr

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
alias wwp='_cd_to_workspace_peco'

# -------------------------------------------------
# cd to sub directory: cd
# -------------------------------------------------
#function _cd_to_sub_directory() {
#    [[ $(find . -type d -maxdepth 1 | wc -l) -eq 1 ]] && {
#        echo 'no sub directory.'
#        return 0
#    }
#    to=$(\
#        find . -type d | \
#        grep -v ^.$ | \
#        grep -v .git | \
#        sort | \
#        uniq | \
#        peco --prompt "$(pwd)/" --query "${*}" 2>/dev/null \
#    )
#
#    [ ! -z ${to} ] && clear && cd ${to}
#}
#alias cdd='_cd_to_sub_directory'

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
# command history
#-------------------------------------------------

# for zsh
#function peco_history_selection_peco() {
#    BUFFER=$(history -n 1 | \
#        tac  | \
#        awk '!a[$0]++' | \
#        peco --prompt 'zsh Command History>'
#    )
#
#    CURSOR=$#BUFFER
#    zle reset-prompt
#}
#zle -N peco_history_selection_peco
#bindkey '^H' peco_history_selection_peco


# -------------------------------------------------
# cd to directory mark (doesn't work')
# -------------------------------------------------
function _markspeco() {
    dirmarks='~/dotfiles/.dirmarks'
    [ $(ls -U ${dirmarks} | wc -l) -ne 0 ] && {
        local to=$(
            for x in ${dirmarks}/*; do
               [ -e $(cat ${x}) ] && {
                   cat ${x};
               }
            done | sort | uniq | peco --prompt "dirmarks >"
        )
    }
    [ ! -z ${to} ] && cd ${to}
}
alias cdm='_markspeco'

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

##-------------------------------------------------
## WEB Bookmark
##-------------------------------------------------
#function _open_web_bookmark() {
#    local bookmark_dir="${DOTPATH}/.web_bookmark"
#    [ ! $(find ${bookmark_dir} -type f -name '*.csv' > /dev/null 2>&1 | wc -l) -gt 1 ] && {
#        echo "Error: no Bookmark(csv) file locate at ${bookmark_dir}."
#        return
#    }
#    [ -z $1 ] && {
#        url=$(
#            cat $(find ${bookmark_dir} -type f -name "*.csv") | \
#            column -s ',' -t | \
#            peco --prompt "WEB Bookmarks>" | \
#            sed -e 's#^.*\(https*://\)#\1#g'
#        )
#    } || {
#        url=$1
#        [ $(echo ${url} | grep -E "^https?://" | wc -l) -eq 0 ] && url='http://'${url}
#    }
#    #[ ! -z ${url} ] && open "${url}"
#    [ ! -z ${url} ] && open ${WEB_BROWSER} "${url}"
#}
#alias web="_open_web_bookmark $@"

# --------------------------------------------
# show timezone
# --------------------------------------------
function _show_timezone() {
    local tz
    local tz_version
    [ $# -eq 0 ] && {
        tz_version="$(find /var/db/timezone/tz -type d -maxdepth 1 \
                                | sort \
                                | tail -1 \
                                | rev \
                                | cut -d '/' -f 1 \
                                | rev)"

        tz=$(find /var/db/timezone/tz/${tz_version}/zoneinfo -type f \
            | sed -e "s:/var/db/timezone/tz/${tz_version}/zoneinfo/::g" \
            | peco --prompt "which city ? >")
    } || {
        tz=$1
    }

    [ ! -z ${tz} ] && printf "${tz}: "; TZ=${tz} date
}
alias tz="_show_timezone"
alias timezone="_show_timezone"
alias clock="_show_timezone"

#-------------------------------------------------
# Search Stock
#-------------------------------------------------
source $(ghq root)/github.com/ontheroadjp/stock-jp/stock-jp.fnc

#-------------------------------------------------
# Search Yubin bangou
#-------------------------------------------------
function _search_yubin_bangou() {
    data_path="${DOTPATH}/.yubin_bangou"
    data="${data_path}/KEN_ALL.CSV"
#    data_url='https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip'
#    mkdir -p ${data_path}
#    curl ${data_url} -o ${data_path}/ken_all.zip
#    unar -f ${data_path}/ken_all.zip
    cat ${data} | \
        nkf -w -Z1 | \
        sed 's/"//g' | \
        awk -F',' '{ printf("%10d %-60s\n", $3, $7$8$9) }' | \
        sed 's/〜/-/g' | \
        peco --prompt 'Search Yubin bangou>' --query ${@:-''}
}
alias yubin='_search_yubin_bangou $@'
alias yubinbangou='_search_yubin_bangou $@'

echo "Load peco settings."
