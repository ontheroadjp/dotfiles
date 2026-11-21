qwen4b() {
    if [ -z "$1" ]; then
        echo "Usage: ollama-chat <model>"
        return 1
    fi
    ollama run "$1" --think=false --verbose
    ollama stop "$1" 2>/dev/null
}

# Tab補完用の関数定義
_ollama-chat() {
    local -a models
    # ollama list の1行目（ヘッダー）を除き、1列目のモデル名だけを取得
    models=(${(f)"$(ollama list 2>/dev/null | awk 'NR>1 {print $1}')"})
    _describe 'ollama models' models
}

# ollama-chat コマンドに補完関数を紐付け
compdef _ollama-chat ollama-chat


# --------------------------------------
# extra swap
# 補助スワップのON/OFF・状態確認 (extra-swap [on|off|status] [サイズ(デフォルト:4G)])
# --------------------------------------
extra-swap() {
  local swapfile="/swapfile_extra"
  local size="${2:-4G}"

  case "${1:-status}" in
    on)
      if [[ ! -f "$swapfile" ]]; then
        echo "Creating ${swapfile} (${size})..."
        sudo fallocate -l "$size" "$swapfile" && \
        sudo chmod 600 "$swapfile" && \
        sudo mkswap "$swapfile" || return 1
      fi

      if swapon --show=NAME --noheadings | grep -qx "$swapfile"; then
        echo "Extra swap (${swapfile}) is already ON."
      else
        sudo swapon "$swapfile" && echo "Extra swap (${swapfile}) enabled."
      fi
      swapon --show
      ;;

    off)
      if swapon --show=NAME --noheadings | grep -qx "$swapfile"; then
        echo "Disabling ${swapfile}..."
        sudo swapoff "$swapfile" || return 1
      fi

      if [[ -f "$swapfile" ]]; then
        echo "Removing ${swapfile}..."
        sudo rm -f "$swapfile" && echo "Extra swap (${swapfile}) disabled and removed."
      else
        echo "Extra swap (${swapfile}) is already OFF and removed."
      fi
      swapon --show
      ;;

    status|*)
      swapon --show
      free -h
      ;;
  esac
}


# --------------------------------------
# gpt-oss-20b
# --------------------------------------
_run_ollama_gpt() {
  extra-swap on || return 1
  trap 'ollama stop gpt-oss-fast >/dev/null 2>&1; extra-swap off; trap - INT TERM EXIT' INT TERM EXIT

  ollama run gpt-oss-fast --think=low --verbose "$@"
}
alias ollama-gpt='_run_ollama_gpt'
