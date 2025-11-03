# --------------------------------------------
# Shell tools
# --------------------------------------------
[ -e ${DOTPATH/tools/shell-tools} ] && {
    SHELL_TOOLS_DIR="${DOTPATH}/tools/shell-tools"

    # export PATH=${PATH}:${DOTPATH}/tools/dammy
    #export PATH=${PATH}:${DOTPATH}/tools/fix-filename
    #export PYTHONPATH=${DOTPATH}/tools/fix-filename
    alias fix='${HOME}/dev/src/github.com/ontheroadjp/fix-filename/fix-filename.py'

    source ${SHELL_TOOLS_DIR}/file-info/file-info.fnc
    source ${SHELL_TOOLS_DIR}/wifi-helth-check/wifi-helth-check.fnc

    # source ${SHELL_TOOLS_DIR}/dirmarks/dirmarks.fnc
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

    [ -e "${DOTPATH}/tools/stock-jp/data/stock.csv" ] && {
        alias stock='sh ${DOTPATH}/tools/stock-jp/stock-jp.sh'
    }

    # for Python scripts
    function _git_commit_msg() {
        gpt_git_commit_msg.py diff | pbcopy
    }

    alias gitcommitmsg='_git_commit_msg'
    alias li=battery
    alias wifi=get_ssid
}


