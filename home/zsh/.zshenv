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
# XDG Base Directory
# --------------------------------------------------------------------
# export XDG_CONFIG_HOME=`$HOME/.config`
export XDG_STATE_HOME=${DOTPATH}/.local/state
export XDG_DATA_HOME=${DOTPATH}/.local/share
export XDG_CACHE_HOME=${DOTPATH}/.cache

#-------------------------------------------------
# Function
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }

# --------------------------------------------------------------------
# zsh compile
# --------------------------------------------------------------------
function source() {
    zsource $@
}

function zsource() {
    ensure_zcompiled "$1"
    builtin source "$1"
}

# function zsource() {
#     local src="$1"
#     local start=$(perl -MTime::HiRes=time -e 'printf "%.0f\n", time*1000')
#     ensure_zcompiled "$1"
#     builtin source "$1"
#     local end=$(perl -MTime::HiRes=time -e 'printf "%.0f\n", time*1000')
#     local elapsed=$((end - start))
#     printf "\033[1;33m[load]\033[0m %4d ms %s\n" "$elapsed" "$src" >&2
# }


ZCOMPILE_FORCE=0
# function ensure_zcompiled() {
#     local compiled="$1.zwc"
#     # if [[ "$1" -nt "$compiled" || ! -r "$compiled" ]]; then
#     if [[ ${ZCOMPILE_FORCE} == 1 || ! -r "${compiled}" || "$1" -nt "$compiled" ]]; then
#         zcompile -R "$1"
#         echo "\033[1;36mCompiling\033[m $1"
#     fi
# }

typeset -gA _ZCOMPILE_CACHE
ensure_zcompiled() {
   local src="$1"
   local compiled="${src}.zwc"

   # Skip if already checked
   [[ -n "${_ZCOMPILE_CACHE[${src}]}" ]] && return

   if [[ ${ZCOMPILE_FORCE} == 1 \
           || ! -r "${compiled}" \
           || "${src}" -nt "${compiled}" \
       ]]; then
       zcompile -R "${src}"
       echo "\033[1;36mCompiling\033[m ${src}"
   fi

   _ZCOMPILE_CACHE[${src}]=1
}

ensure_zcompiled ${HOME}/.zshenv
ensure_zcompiled ${HOME}/.zshrc
ensure_zcompiled ${HOME}/.zprofile

# --------------------------------------------------------------------
# Load plugin
# --------------------------------------------------------------------
source ${ZSH_HOME}/plugins/zsh-defer/zsh-defer.plugin.zsh
# source ${ZSH_HOME}/zsh.d/lazy_load_env.sh

echo "Load .zshenv.."

