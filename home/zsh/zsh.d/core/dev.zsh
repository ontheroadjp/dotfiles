
tunnel1() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 3000:127.0.0.1:3000 nobita
}

tunnel2() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 4000:127.0.0.1:4000 nobita
}

tunnel3() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -R 5000:127.0.0.1:5000 nobita
}

tunneltmux() {
  autossh -M 0 -N \
    -o ServerAliveInterval=30 \
    -o ServerAliveCountMax=3 \
    -o ExitOnForwardFailure=yes \
    -R 10322:127.0.0.1:10322 nobita
}

lo() {
    local use_curl=false
    local OPTIND opt

    # -c オプションの解析
    while getopts "c" opt; do
        case "${opt}" in
            c) use_curl=true ;;
            *) echo "Usage: lo [-c] [port]" >&2; return 1 ;;
        esac
    done

    # 解析したオプション分だけ引数をシフト（ズラす）
    shift $((OPTIND - 1))

    # ポート番号の設定（引数がない場合はデフォルトで 8080）
    local port=${1:-8080}
    local url="http://localhost:${port}"

    # 実行コマンドの分岐
    if [[ "${use_curl}" == true ]]; then
        curl -I "${url}"
    else
        open "${url}"
    fi
}

