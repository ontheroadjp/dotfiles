# ~/.zshrc または ~/.bashrc に追加
gemini() {
  # カレントブランチ名を取得
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  # git 管理下でない場合はそのまま続行
  if [ $? -ne 0 ]; then
    echo "⚠️ Git リポジトリではありません。Gemini CLI を起動します。"
    command gemini "$@"
    return
  fi

  # ワーキングツリーの状態を確認
  local git_status
  git_status=$(git status --porcelain)

  # チェック条件
  local clean=true
  local on_dev=true

  if [ "$branch" != "dev" ]; then
    echo "⚠️ 現在のブランチは '$branch' です（dev ではありません）"
    on_dev=false
  fi

  if [ -n "$git_status" ]; then
    echo "⚠️ ワーキングツリーに未コミットの変更があります"
    clean=false
  fi

  # どちらかが不適なら確認を出す
  if [ "$on_dev" = false ] || [ "$clean" = false ]; then
    echo
    echo "次のいずれかを選んでください:"
    echo "  [c] 継続して gemini を起動"
    echo "  [a] 中断"
    echo -n "> "
    read -r ans
    case "$ans" in
      c|C)
        echo "👉 Gemini CLI を起動します..."
        ;;
      *)
        echo "⛔ 中断しました。"
        return 1
        ;;
    esac
  fi

  # 通常の gemini CLI 実行
  command gemini "$@"
}
