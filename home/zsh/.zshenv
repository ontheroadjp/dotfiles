# --------------------------------------------------------------------
# zsh analysis
# --------------------------------------------------------------------
# zmodload zsh/zprof && zprof

# --------------------------------------------------------------------
# HOME Directories
# --------------------------------------------------------------------
export DOTPATH=${HOME}/dotfiles
export ZSH_HOME="${DOTPATH}/home/zsh"
export VIM_HOME="${DOTPATH}/home/vim"

# --------------------------------------------------------------------
# built-in command
# --------------------------------------------------------------------
pushd() {
    builtin pushd "$@" > /dev/null
}
popd() {
    builtin popd "$@" > /dev/null
}

sed() {
    if [[ "$(uname)" == "Darwin" ]]; then
        if command -v gsed >/dev/null 2>&1; then
            gsed "$@"
        fi
    fi
    command sed "$@"
}

# --------------------------------------------------------------------
# zsh compile
# --------------------------------------------------------------------
function source() {
    ensure_zcompiled "$1"
    builtin source "$1"
}

function ensure_zcompiled() {
    local compiled="$1.zwc"
    if [[ "$1" -nt "$compiled" || ! -r "$compiled" ]]; then
        zcompile "$1"
        echo "\033[1;36mCompiling\033[m $1"
    fi
}
ensure_zcompiled ~/.zshenv
ensure_zcompiled ~/.zshrc
ensure_zcompiled ~/.zprofile

# Compile in zsh.d/core/zsh.zsh
# ensure_zcompiled ~/.zcompdump

# --------------------------------------------------------------------
# Load plugin - zsh-defer
# --------------------------------------------------------------------
source ${ZSH_HOME}/plugins/zsh-defer/zsh-defer.plugin.zsh

# --------------------------------------------------------------------
# Load plugin - lazy_load_env
# --------------------------------------------------------------------
source ${ZSH_HOME}/zsh.d/lazy_load_env.sh

echo "Load .zshenv.."

