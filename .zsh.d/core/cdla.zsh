pushd() {
    builtin pushd "$@" > /dev/null
}
popd() {
    builtin popd "$@" > /dev/null
}

#----------------------------------------------------------------
# cdla - Changing directory
#----------------------------------------------------------------
function _print_la() {
    [ $(uname) = 'Darwin' ] && {
        ls -laGh "$@"
    } || {
        ls -lah --color=auto "$@"
    }
}
alias la='_print_la'

# [ $(uname) = 'Darwin' ] && {
#     alias la='ls -laGh'
# } || {
#     alias la='ls -lah --color=auto'
# }

function _cdla() {
    [ $# -eq 0 ] && place=${HOME} || place="$@"
	    # _print_la "${palace}" && pushd "${place}"
	    pushd "$@" && _print_la

    [ $(uname) = 'Darwin' ] && {
        rm .DS_Store > /dev/null 2>&1
        rm .netrwhist > /dev/null 2>&1
    }
    auto_venv
}
# alias cd='_cdla'
function cd() { _cdla "$@" }


# back to the previous location -----------------------------------
# alias b='popd && clear && _print_la'
alias b='popd && clear && la'

# general settings ------------------------------------------------
alias HOME="cd ${HOME}"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

function _copy_current_dir_path() {
    echo -n $(pwd) | pbcopy && echo 'copy: '$(pbpaste)
}
alias ,='_copy_current_dir_path'

function mkdircd() { mkdir $@ && cd $_ }
alias mc='mkdircd'

#----------------------------------------------------------------
# dirmarks
#----------------------------------------------------------------
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
