ollama-chat() {
    if [ -z "$1" ]; then
        echo "Usage: ollama-chat <model>"
        return 1
    fi
    ollama run "$1" --think=false
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
