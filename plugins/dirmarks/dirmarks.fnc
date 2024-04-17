
function _dirmarks() {
    [ -z $DIRMARKS_ROOT ] && {
        dirmarks="${HOME}/.dirmarks"
    } || dirmarks=${DIRMARKS_ROOT}
    mkdir -p ${dirmarks}

    case $1 in
        mark )
            pwd > ${dirmarks}/${2}${2}
            echo 'markd!'
            return 0
            ;;
        jump )
            [ -f ${dirmarks}/${2}${2} ] && {
                cat ${dirmarks}/${2}${2}
                cd $(cat ${dirmarks}/${2}${2})
            } || echo "not set."
            return 0
            ;;
    esac
}

function _cd_to_dirmarks() {
    result=$(cat $(find ~/dotfiles/.dirmarks -type f) | fzf)
    [ ! -z ${result} ] && { cd ${result} }
}

alias mm='_dirmarks mark m'
alias nn='_dirmarks mark n'
alias ii='_dirmarks mark i'
alias oo='_dirmarks mark o'
alias uu='_dirmarks mark u'

alias m='_dirmarks jump m'
alias n='_dirmarks jump n'
alias i='_dirmarks jump i'
alias o='_dirmarks jump o'
alias u='_dirmarks jump u'

alias marks='_cd_to_dirmarks'

