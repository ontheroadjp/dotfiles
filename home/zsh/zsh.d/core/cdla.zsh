pushd() {
    builtin pushd "$@" > /dev/null
}
popd() {
    builtin popd "$@" > /dev/null
}

#----------------------------------------------------------------
# cdla - Changing directory
#----------------------------------------------------------------
SHOW_FULL_PATH_AT_LA=1
function _print_la() {
    [ $(uname) = 'Darwin' ] && {
        ls -laGh "$@"
    } || {
        ls -lah --color=auto "$@"
    }

# [ ${SHOW_FULL_PATH_AT_LA} -ne 0 ] && echo "\e[34m@ $(pwd | sed -e 's:\/Users\/.*/\?:\$\{HOME\}\/:g')\e[0m"
# [ ${SHOW_FULL_PATH_AT_LA} -ne 0 ] && echo "\e[34m $(pwd | sed -e "s:^\(${HOME}/\)\(.*\):\$HOME 👉 \2/ :")\e[0m"
[ ${SHOW_FULL_PATH_AT_LA} -ne 0 ]
}
alias la='_print_la'
alias nopwd='SHOW_FULL_PATH_AT_LA=0'
alias yespwd='SHOW_FULL_PATH_AT_LA=1'

compdef la=ls

# [ $(uname) = 'Darwin' ] && {
#     alias la='ls -laGh'
# } || {
#     alias la='ls -lah --color=auto'
# }

CLEAR_BEFORE_CD=1
function _cdla() {
    # [ $# -eq 0 ] && place=${HOME} || place="$@"

    # _print_la "${palace}" && pushd "${place}"
    # pushd "$@"
    local to="$@"
    [ ${CLEAR_BEFORE_CD} -ne 0 ] && clear
    pushd ${to:-$HOME}

    # [ $(uname) = 'Darwin' ] && {
    #     rm .DS_Store > /dev/null 2>&1
    #     rm .netrwhist > /dev/null 2>&1
    # }

    _print_la
    auto_venv
}
function cd() { _cdla "$@" }
alias noclear='CLEAR_BEFORE_CD=0'
alias yesclear='CLEAR_BEFORE_CD=1'


# back to the previous location -----------------------------------
# alias b='popd && clear && _print_la'
alias b='popd && clear && la'

# general settings ------------------------------------------------
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../../"
alias ......="cd ../../../../../"

function _copy_current_dir_path() {
    echo -n $(pwd) | pbcopy && echo 'copy: '$(pbpaste)
}
alias ,='_copy_current_dir_path'

function mkdircd() { mkdir $@ && cd $_ }
alias mc='mkdircd'

