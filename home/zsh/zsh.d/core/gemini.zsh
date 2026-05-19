# gemini
#
# Gemini CLI を起動するためのラッパー関数。
#
# 機能:
#   - Git リポジトリ配下で実行されているかを判定
#   - 現在のブランチが dev かどうかを確認
#   - 作業ツリーがクリーンかどうかを確認
#   - 条件を満たさない場合はユーザーに確認を求める
#   - Gemini CLI 起動前に仕様書を GEMINI.md に同期する
#
# 挙動:
#   - Git 管理外ディレクトリの場合:
#       警告を表示した上で Gemini CLI をそのまま起動する
#   - dev ブランチ以外、または未コミット変更がある場合:
#       続行するかどうかを対話的に確認する
#   - 問題がなければ Gemini CLI を起動する
#
# 副作用:
#   - 条件に応じて ./GEMINI.md を上書きする
#   - 標準出力に警告・案内・ログを出力する
#   - ユーザー入力を要求する場合がある
#
# 目的:
#   不適切な Git 状態で Gemini CLI を起動することを防ぎつつ、
#   常に最新の仕様書コンテキストを Gemini に渡すため。
#
# 注意:
#   - 対話入力を伴うため、非対話環境では停止する可能性がある
#   - 内部で git, cp, cmp コマンドに依存する
gemini() {
    goslack
    local PREFIX="[gemini-wrapper]"

    # copy_spec_if_exists
    #
    # Synchronize ./docs/specification.md to ./GEMINI.md.
    # Copy only if there are content differences; if not copying, echo the reason.
    copy_spec_if_exists() {
        local SRC="./docs/specification.md"
        local DST="./GEMINI.md"

        if [ ! -f "$SRC" ]; then
            echo "$PREFIX $SRC not found, skip copy"
            return
        fi

        if [ ! -f "$DST" ]; then
            cp "$SRC" "$DST"
            echo "$PREFIX copied $SRC -> $DST (destination did not exist)"
            return
        fi

        if cmp -s "$SRC" "$DST"; then
            echo "$PREFIX $SRC and $DST are identical, skip copy"
        else
            cp "$SRC" "$DST"
            echo "$PREFIX copied $SRC -> $DST (content changed)"
        fi
    }

    # Get current branch name
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    # If not under git control, continue as is
    if [ $? -ne 0 ]; then
        echo "⚠️  Start the Gemini CLI, not the Git repository.
        "
        # copy_spec_if_exists
        command gemini "$@"
        return
    fi

    # Check working tree status
    local git_status
    git_status=$(git status --porcelain)

    # Check Conditions
    local clean=true
    local on_dev=true

    if [ "$branch" != "dev" ]; then
        echo "⚠️  Current branch is '$branch' (not dev)
        "
        on_dev=false
    fi

    if [ -n "$git_status" ]; then
        echo "⚠️  There are uncommitted changes to the king tree"
        clean=false
    fi

    # Issue confirmation if either is unsuitable
    if [ "$on_dev" = false ] || [ "$clean" = false ]; then
        echo
        echo "Choose one of the following:"
        echo " [c] continue to launch gemini"
        echo " [a] Suspend"
        echo -n "> "
        read -r ans
        case "$ans" in
            c|C)
                echo "👉 Start Gemini CLI..."
                ;;
            *)
                echo "⛔ Interrupted..."
                return 1
                ;;
        esac
    fi

    trap '
    if [ -n "$TMUX" ]; then
        pane_id=$(tmux display-message -p "#{pane_id}" 2>/dev/null)
        if [ -n "$pane_id" ]; then
            num=$(python goslack.py list \
                | awk -v pid="$pane_id" "NR>1 && \\$4==pid {print \\$1; exit}")
            if [ -n "$num" ]; then
                python goslack.py rm "$num" --notify "gemini が終了したためマッピン
                グを解除しました。"
            fi
        fi
    fi
    ' EXIT

    # Normal gemini CLI execution
    command gemini "$@"
}
