#--------------------------------------------------
# vi mode
# -------------------------------------------------
function zle-line-init zle-keymap-select {
    VIM_NORMAL="%K{208}%F{black}(%k%f%K{208}%F{white}% NORMAL%k%f%K{black}%F{208})%k%f"
    VIM_INSERT="%K{051}%F{051}(%k%f%K{051}%F{051}% INSERT%k%f%K{051}%F{051})%k%f"
    RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# jj to return normal mode
bindkey -M viins 'jj' vi-cmd-mode

#--------------------------------------------------
# show sub directories: la (ls -laG)
# -------------------------------------------------
alias lla='la $(find . -type d | grep -v .git | peco)'
alias laa='la $(find . -type d | grep -v .git | peco)'

# -------------------------------------------------
# open application
# -------------------------------------------------
function _open_application() {
    app=$(find /Applications -name '*.app' -maxdepth 2 \
            | sed -e 's:/Applications/::' \
            | peco --prompt 'Application > ' \
        );
    [ ! -z ${app} ] && { open "/Applications/${app}" }
}
alias app=_open_application $@
zle -N _open_application
bindkey '^A' _open_application

# -------------------------------------------------
# cd to directory within WORKSPACE
# -------------------------------------------------
function _cd_to_workspace() {
#    [[ $(find ${WORKSPACE} -type d -maxdepth 1 | wc -l) -eq 1 ]] && {
#        echo 'no sub directory.'
#        return 0
#    }
#    to=$(\
#        find ${WORKSPACE} -type d | \
#        grep -v ^.$ | \
#        grep -v .git | \
#        sort | \
#        uniq | \
#        peco --prompt "${WORKSPACE}/" --query "${*}" 2>/dev/null \
#    )
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
alias ww='_cd_to_workspace'
#zle -N _cd_to_workspace
#bindkey '^W' _cd_to_workspace

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
alias cdd='_cd_to_sub_directory'

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
function peco-history-selection() {
    BUFFER=$(history -n 1 | \
        tac  | \
        awk '!a[$0]++' | \
        peco --prompt 'zsh Command History>'
    )

    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^H' peco-history-selection

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
function _connect_vps() {
    local ssh_server=$(cat ${HOME}/.ssh/config | \
            grep ^Host | \
            cut -d " " -f 2 | \
            peco --prompt "SSH>"
        )
    [ ! -z ${ssh_server} ] && ssh ${ssh_server}
}
alias vps='_connect_vps'

#-------------------------------------------------
# My Memo
#-------------------------------------------------
function _my_memo() {
    local my_memo_dir="${WORKSPACE}/Dropbox/Documents/memo"
    local dir=$(find ${my_memo_dir} -type d | peco --prompt "My Memo>")
    local md=$(find ${dir} -type f | peco --prompt "My Memo>")
	[ ! -z ${md}  ] && open -a ${MARKDOWN_EDITOR} ${md}
}
alias memo="_my_memo"

#-------------------------------------------------
# WEB Bookmark
#-------------------------------------------------
function _open_web_bookmark() {
    local bookmark_dir="${DOTPATH}/.web_bookmark"
    [ ! $(find ${bookmark_dir} -type f -name '*.csv' > /dev/null 2>&1 | wc -l) -gt 1 ] && {
        echo "Error: no Bookmark(csv) file locate at ${bookmark_dir}."
        return
    }
    [ -z $1 ] && {
        url=$(
            cat $(find ${bookmark_dir} -type f -name "*.csv") | \
            column -s ',' -t | \
            peco --prompt "WEB Bookmarks>" | \
            sed -e 's#^.*\(https*://\)#\1#g'
        )
    } || {
        url=$1
        [ $(echo ${url} | grep -E "^https?://" | wc -l) -eq 0 ] && url='http://'${url}
    }
    #[ ! -z ${url} ] && open "${url}"
    [ ! -z ${url} ] && open ${WEB_BROWSER} "${url}"
}
alias web="_open_web_bookmark $@"

# --------------------------------------------
# show world time
# --------------------------------------------
function _show_worldtime() {
#    sh ${DOTPATH}/bin/worldtime.sh
    local tz;
    [ $# -eq 0 ] && {
        local tz_version="2020a.1.0"
        tz=$(find /var/db/timezone/tz/${tz_version}/zoneinfo -type f | \
            sed -e 's#/var/db/timezone/tz/2020a.1.0/zoneinfo/##g' | \
            peco --prompt "Time Zone>")
    } || {
        tz=${1}
    }
    [ ! -z ${tz} ] && printf "${tz}: "; TZ=${tz} date
}
alias clock="_show_worldtime"
alias wt="_show_worldtime"

#-------------------------------------------------
# Search Stock
#-------------------------------------------------
function _stock_search() {
    local stock_search_dir="${DOTPATH}/.stock_jp"
    local security_code
    # curl https://www.jpx.co.jp/markets/statistics-equities/misc/tvdivq0000001vg2-att/data_j.xls -o ${stock_search_dir}/stock.xls

    security_code=$(
            cat ${stock_search_dir}/stock.csv | \
            cut -d ',' -f 2-4 | \
            nkf -Z1 | \
            column -s ',' -t | \
            peco --prompt "JP Stock>" --query ${@:-''} | \
            sed -e 's/^.*\([0-9]\{4\}\).*/\1/g'
        )
    [ ! -z ${security_code} ] && {
        site=$({
            echo "Yahoo! Finance"
            echo "SBI"
        } | peco )

        local url=''
        case ${site} in
            "Google" )
                url="https://www.google.com/search?q=${security_code}"
                ;;
            "Yahoo! Finance" )
                url="https://stocks.finance.yahoo.co.jp/stocks/detail/?code=${security_code}"
                ;;
            "SBI" )
                url="https://site1.sbisec.co.jp/ETGate/?_ControlID=WPLETsiR001Control&_PageID=WPLETsiR001Idtl10&_DataStoreID=DSWPLETsiR001Control&_ActionID=stockDetail&s_rkbn=2&s_btype=&i_stock_sec=${security_code}&i_dom_flg=1&i_exchange_code=JPN&i_output_type=0&exchange_code=TKY&stock_sec_code_mul=${security_code}&ref_from=1&ref_to=20&infoview_kbn=2&PER=&wstm4130_sort_id=&wstm4130_sort_kbn=&qr_keyword=1&qr_suggest=1&qr_sort=1"
                ;;
        esac
        open ${url}
    }
}
alias stock="_stock_search"

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

##-------------------------------------------------
## Utilities
##-------------------------------------------------
#function 256() {
#    for c in {000..255}; do
#        echo -n "\e[38;5;${c}m $c"
#        [ $(($c%16)) -eq 15 ] && echo
#    done
#    echo
#}

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
