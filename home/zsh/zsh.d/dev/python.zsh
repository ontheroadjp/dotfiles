# ------------------------------------------
# pyenv
# ------------------------------------------
# <usage>
# $ pyenv install -l        # install List of available versions
# $ pyenv install 3.10.0    # python install specific version
# $ pyenv global 3.10.0     # Set python version to use
# $ pyenv global            # Check current settings
# ------------------------------------------

## for pyenv
# export PYENV_ROOT="$HOME/.pyenv"
#
# _lazy_load_pyenv() {
#   unalias pyenv 2>/dev/null
#   unalias python 2>/dev/null
#   unalias pip 2>/dev/null
#
#   # Add pyenv to PATH (bin only, shims later via init)
#   export PATH="$PYENV_ROOT/bin:$PATH"
#
#   # Load pyenv
#   eval "$(pyenv init -)"
#   eval "$(pyenv init --path)"
#   # eval "$(pyenv virtualenv-init -)"  # optional
#
#   # Run the command again with the original args
#   "$@"
# }
#
# if [ -n "${PYENV_ROOT}" ]; then
#     alias pyenv='_lazy_load_pyenv pyenv'
#     alias python='_lazy_load_pyenv python'
#     alias pip='_lazy_load_pyenv pip'
# fi

# ------------------------------------------
# auto venv
# ------------------------------------------
function auto_venv() {
    local current_venv="$PWD/venv"
    if [[ -n "${VIRTUAL_ENV-}" ]]; then
        if [[ ! -d "$current_venv" ]]; then
            deactivate 2>/dev/null
            echo "${fg[cyan]}🐍 Virtualenv deactivated${reset_color}"
        elif [[ "$VIRTUAL_ENV" != "$current_venv" ]]; then
            deactivate 2>/dev/null
            source "$current_venv/bin/activate"
            echo "${fg[cyan]}🐍 Virtualenv activated: $current_venv${reset_color}"
        fi
    else
        # venv disabled, if there is a venv where you are, activate
        if [[ -d "$current_venv" ]]; then
            source "$current_venv/bin/activate"
            echo "🐍 Virtualenv activated: $current_venv"
        fi
    fi
}

# check on the starting shell
auto_venv

# ------------------------------------------
# Web Server
# ------------------------------------------

alias httpd='python -m http.server 8080'
