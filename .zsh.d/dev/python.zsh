function auto_venv() {
    local current_venv="$PWD/venv"

    if [[ -n "$VIRTUAL_ENV" ]]; then
        if [[ ! -d "$current_venv" ]]; then
            deactivate 2>/dev/null
            echo "🐍 Virtualenv deactivated" | _cyan
        elif [[ "$VIRTUAL_ENV" != "$current_venv" ]]; then
            deactivate 2>/dev/null
            source "$current_venv/bin/activate"
            echo "🐍 Virtualenv activated: $current_venv" | _cyan
        fi
    else
        # venv 無効の状態で、今いる場所に venv があれば activate
        if [[ -d "$current_venv" ]]; then
            source "$current_venv/bin/activate"
            echo "🐍 Virtualenv activated: $current_venv"
        fi
    fi
}

# autoload -Uz add-zsh-hook
# add-zsh-hook chpwd auto_venv

# check on the starting shell
auto_venv

