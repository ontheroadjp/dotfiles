#!/bin/bash

# -C: 上書き禁止, -e: エラーで即終了, -u: 未定義変数でエラー
set -Ceu

SCRIPT_FILE_NAME=$(basename "$0")
SCRIPT_NAME=${SCRIPT_FILE_NAME%.*}
SELF=$(cd "$(dirname "$0")"; pwd)
LOGGING=false
VERSION="0.1.0"
SEPARATER='---------------------------'

function _usage() {
    echo "Usage: ${SCRIPT_NAME} [OPTIONS] FILE"
    echo "  This is the boilerplate for shell script."
    echo
    echo "Options:"
    echo "  -h, --help                 Show help"
    echo "  -v, --version              Show script version"
    echo "  -a, --long-a ARG           Option which must have argument"
    echo "  -b, --long-b [ARG]         Either with or without argument is possible"
    echo "  -c, --long-c               Option without argument"
    echo "      --verbose              Print various logging information"
    echo
    exit 0
}

function _log() {
    # false コマンドの実行を避けるため if を使用
    if [ "${LOGGING}" = true ]; then
        echo "$@"
    fi
}

function _err() {
    echo "$1" >&2
    exit 1
}

function _is_cmd_exist() {
    type "$@" > /dev/null 2>&1
}

# -------------------------------------------------------------

ARG_VALUES=()
OPT_A=""
OPT_B=""
IS_FLAG_P=false
IS_FLAG_Z=false

function _main() {
    _log "Welcome to ${SCRIPT_NAME}"

    URLS=(
        "https://tmux.starton.jp"
        "https://cert.starton.jp"
        "https://slack.starton.jp"
        "https://nextstep.starton.jp"
        "https://api.starton.jp/schools/health"
        "https://edu.starton.jp/past_exam_reports/"
        "https://edu.starton.jp/kouku/"
        "https://edu.starton.jp/maptile/"
        "https://dev1.starton.jp"
        "https://dev2.starton.jp"
        "https://dev3.starton.jp"
        "https://nutsllc.jp"
        "https://ontheroadjp.github.io/dammy/"
    )

    for url in "${URLS[@]}"; do
        # -I でヘッダーのみ取得の方がヘルスチェックには高速
        if curl -fsSIL --max-time 5 -o /dev/null -w '%{http_code}\n' "$url" > /dev/null 2>&1; then
            echo "👍 $url"
        else
            echo "⚠️ $url"
        fi
    done
}

# -------------------------------------------------------------

function _init() {
    while (( $# > 0 )); do
        case $1 in
            -h | --help)
                _usage
                ;;
            -v | --version)
                echo "${SCRIPT_NAME} v${VERSION}"
                exit 0
                ;;
            --verbose)
                LOGGING=true
                shift
                ;;
            -a | --long-a)
                # ${2:-} を使うことで set -u 環境でもエラーにならない
                if [[ -z "${2:-}" ]] || [[ "$2" =~ ^-+ ]]; then
                    _err "-a option requires a value."
                fi
                OPT_A=$2
                shift 2
                ;;
            -b | --long-b)
                if [[ -z "${2:-}" ]] || [[ "$2" =~ ^-+ ]]; then
                    OPT_B="default_or_true" # 引数なしの場合の値
                    shift
                else
                    OPT_B=$2
                    shift 2
                fi
                ;;
            -c | --long-c)
                shift
                ;;
            --)
                shift
                ARG_VALUES+=( "$@" )
                break
                ;;
            -*)
                # フラグ判定のロジックを整理
                [[ "$1" =~ "z" ]] && IS_FLAG_Z=true
                [[ "$1" =~ "b" ]] && IS_FLAG_P=true
                shift
                ;;
            *)
                ARG_VALUES+=("$1")
                shift
                ;;
        esac
    done
}

function _verbose() {
    _log "ARG_VALUES: ${ARG_VALUES[*]:-none}"
    _log "OPT_A: ${OPT_A}"
    _log "OPT_B: ${OPT_B}"
    _log "IS_FLAG_P: ${IS_FLAG_P}"
    _log "IS_FLAG_Z: ${IS_FLAG_Z}"
    _log "${SEPARATER}"
}

# -------------------------------------------------------------
# Main Routine
# -------------------------------------------------------------

# 引数を渡して初期化
_init "$@"
# _set_static_var は不要（または修正が必要）なため直接 _verbose へ
_verbose

_log 'start main process..'
_log "${SEPARATER}"
_main

exit 0

