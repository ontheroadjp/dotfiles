#--------------------------------------------------
# show sub directories: la (ls -laG)
# -------------------------------------------------
#alias lla='la $(find . -type d | grep -v .git | peco --prompt "sub dir >")'
#alias laa='la $(find . -type d | grep -v .git | peco --prompt "sub dir >")'

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

## cdr settings
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

## peco settings
function _peco-cdr () {
#local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="recent dir (cdr) >" --query "$LBUFFER")"
    #local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | awk '{print $2}' | peco --prompt="cdr >" --query "$LBUFFER")"
    local selected_dir="$(cdr -l | awk '{print $2}' | peco --prompt="recent dir (cdr) >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        echo $(${selected_dir} | cut -d ' ' -f5 -f6)
        BUFFER="cd $(echo ${selected_dir} | cut -d ' ' -f5 -f6)"
        zle accept-line
    fi
}

zle -N _peco-cdr
bindkey '^E' _peco-cdr

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
    local ssh_server=$(cat ${HOME}/.ssh/config | \
            grep ^Host | \
            cut -d " " -f 2 | \
            peco --prompt "SSH>"
        )
    [ ! -z ${ssh_server} ] && ssh ${ssh_server}
}
alias remote='_connect_ssh'

#-------------------------------------------------
# My Memo
#-------------------------------------------------
function _my_memo() {
    local my_memo_dir="${WORKSPACE}/Dropbox/Documents"
    #local dir=$(find ${my_memo_dir} -type d | peco --prompt "My Memo>")
    #local md=$(find ${dir} -type f | peco --prompt "My Memo>")
    local md=$(find ${my_memo_dir} -type f | peco --prompt "open Memo>")
	[ ! -z ${md}  ] && open ${md}
}
alias memo="_my_memo"

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

#function _stock_search() {
#    local stock_search_dir="${DOTPATH}/.stock_jp"
#    local security_code
#    # curl https://www.jpx.co.jp/markets/statistics-equities/misc/tvdivq0000001vg2-att/data_j.xls -o ${stock_search_dir}/stock.xls
#
#    security_code=$(
#            cat ${stock_search_dir}/stock.csv | \
#            cut -d ',' -f 2-4 | \
#            nkf -Z1 | \
#            column -s ',' -t | \
#            peco --prompt "JP Stock>" --query ${@:-''} | \
#            sed -e 's/^.*\([0-9]\{4\}\).*/\1/g'
#        )
#    [ ! -z ${security_code} ] && {
#        site=$({
#            echo "Yahoo! Finance"
#            echo "SBI"
#        } | peco )
#
#        local url=''
#        case ${site} in
#            "Google" )
#                url="https://www.google.com/search?q=${security_code}"
#                ;;
#            "Yahoo! Finance" )
#                url="https://stocks.finance.yahoo.co.jp/stocks/detail/?code=${security_code}"
#                ;;
#            "SBI" )
#                url="https://site1.sbisec.co.jp/ETGate/?_ControlID=WPLETsiR001Control&_PageID=WPLETsiR001Idtl10&_DataStoreID=DSWPLETsiR001Control&_ActionID=stockDetail&s_rkbn=2&s_btype=&i_stock_sec=${security_code}&i_dom_flg=1&i_exchange_code=JPN&i_output_type=0&exchange_code=TKY&stock_sec_code_mul=${security_code}&ref_from=1&ref_to=20&infoview_kbn=2&PER=&wstm4130_sort_id=&wstm4130_sort_kbn=&qr_keyword=1&qr_suggest=1&qr_sort=1"
#                ;;
#        esac
#        open ${url}
#    }
#}
#alias stock="_stock_search"
#
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
