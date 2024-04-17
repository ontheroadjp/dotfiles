# --------------------------------------------------------------------
# zsh analysis
# --------------------------------------------------------------------
#zmodload zsh/zprof && zprof

# --------------------------------------------------------------------
# zsh compile
# --------------------------------------------------------------------
function source {
    ensure_zcompiled $1
    builtin source $1
}
function ensure_zcompiled {
    local compiled="$1.zwc"
    if [[ "$1" -nt "$compiled" || ! -r "$compiled" ]]; then
        zcompile $1
        echo "\033[1;36mCompiling\033[m $1"
    fi
}
ensure_zcompiled ~/.zshenv
ensure_zcompiled ~/.zshrc
ensure_zcompiled ~/.zprofile

# --------------------------------------------------------------------
# zsh-defer
# --------------------------------------------------------------------
source ~/dotfiles/plugins/zsh-defer/zsh-defer.plugin.zsh

# --------------------------------------------------------------------
# lazy_load_env
# --------------------------------------------------------------------
source ${HOME}/dotfiles/.zsh.d/lazy_load_env.sh

# echo "Load .zshenv.."

