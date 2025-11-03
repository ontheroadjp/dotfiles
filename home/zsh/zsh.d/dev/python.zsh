# ------------------------------------------
# pyenv
# ------------------------------------------
# _pyenv_init() {
#     export PYENV_ROOT=/usr/local/var/pyenv
#     # export PATH=”$PYENV_ROOT/shims:$PATH”
#     export PATH=”$PYENV_ROOT/bin:$PATH”
#     eval "$(pyenv init -)"
#     eval "$(pyenv init --path)"
#     # eval "$(pyenv virtualenv-init -)"
# }
# eval "$(lazyenv.load _pyenv_init pyenv python pip)"

export PYENV_ROOT="$HOME/.pyenv"

_lazy_load_pyenv() {
  unalias pyenv 2>/dev/null
  unalias python 2>/dev/null
  unalias pip 2>/dev/null

  # Add pyenv to PATH (bin only, shims later via init)
  export PATH="$PYENV_ROOT/bin:$PATH"

  # Load pyenv
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
  # eval "$(pyenv virtualenv-init -)"  # optional

  # Run the command again with the original args
  "$@"
}

if [ -n "${PYENV_ROOT}" ]; then
    alias pyenv='_lazy_load_pyenv pyenv'
    alias python='_lazy_load_pyenv python'
    alias pip='_lazy_load_pyenv pip'
fi

# ------------------------------------------
# auto venv
# ------------------------------------------
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

