function wareki() {
    [ $# -ne 1 ] || [ ${1:0:1} -eq '-' ] && {
        echo "Bad parameter."
        return
    }

    WAREKI_PATH="${HOME}/dotfiles/bin/wareki"
    cat ${WAREKI_PATH}/wareki.csv | grep $@ | column -t -s ',' 2>/dev/null
}
