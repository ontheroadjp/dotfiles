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

