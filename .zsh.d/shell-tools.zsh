# --------------------------------------------
# Shell tools
# --------------------------------------------
echo 'foo'
[ -e ${DOTPATH/tools/shell-tools} ] && {
    echo 'hoge'
#    SHELL_TOOLS_DIR="$(ghq root)/github.com/ontheroadjp/shell-tools"
    SHELL_TOOLS_DIR="${DOTPATH}/tools/shell-tools"
    export PATH=${DOTPATH}/bin:${PATH}

    export PATH=${PATH}:${DOTPATH}/tools/dammy
    #export PATH=${PATH}:${DOTPATH}/tools/fix-filename
    #export PYTHONPATH=${DOTPATH}/tools/fix-filename
    alias fix='/Users/hideaki/dev/src/github.com/ontheroadjp/fix-filename/fix-filename.py'

    source ${SHELL_TOOLS_DIR}/file-info/file-info.fnc
    source ${SHELL_TOOLS_DIR}/wifi-helth-check/wifi-helth-check.fnc

    source ${SHELL_TOOLS_DIR}/dirmarks/dirmarks.fnc
    source ${SHELL_TOOLS_DIR}/shell-stash/shell-stash.fnc
    source ${SHELL_TOOLS_DIR}/backup/backup.fnc
    source ${SHELL_TOOLS_DIR}/quick-memo/quick-memo.fnc
    source ${SHELL_TOOLS_DIR}/colors/colors.fnc
    source ${SHELL_TOOLS_DIR}/timer/timer.fnc

    source ${SHELL_TOOLS_DIR}/wareki/wareki.fnc
    source ${SHELL_TOOLS_DIR}/weather/weather.fnc
    source ${SHELL_TOOLS_DIR}/worldtime/worldtime.fnc
    source ${SHELL_TOOLS_DIR}/holiday-jp/holiday-jp.fnc
    # today.fnc must be loading after wareki, weather and worldtime loaded.
    source ${SHELL_TOOLS_DIR}/today/today.fnc

    # for Python scripts
    function _git_commit_msg() {
        gpt_git_commit_msg.py diff | pbcopy
    }

    alias gitcommitmsg='_git_commit_msg'
    alias li=battery
    alias wifi=get_ssid
}


