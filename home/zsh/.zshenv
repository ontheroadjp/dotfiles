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
export XDG_STATE_HOME=${HOME}/.local/state
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CACHE_HOME=${HOME}/.cache

# Keep PATH entries unique when login shells are restarted.
typeset -U path PATH

# --------------------------------------------------------------------
# for Non-interactive shell ex. claude code etc.
# --------------------------------------------------------------------
# add NVM default node to PATH via symlink (no subprocess, fast)
# To update: ln -sf ~/.nvm/versions/node/vX.Y.Z ~/.nvm/current
# After switching Node versions, you only need to run one command:
# nvm alias default 22.20.0
# ln -sf ~/.nvm/versions/node/v22.20.0 ~/.nvm/current
[[ -d "$HOME/.nvm/current/bin" ]] && export PATH="$HOME/.nvm/current/bin:$PATH"

#-------------------------------------------------
# Function
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }

# --------------------------------------------------------------------
# zsh compile
# --------------------------------------------------------------------
function zsource() {
    ensure_zcompiled "$1"
    builtin source "$1"
}

ZCOMPILE_FORCE=0
ensure_zcompiled() {
    local src="$1"
    local compiled="${src}.zwc"
    local message

    if [[ ${ZCOMPILE_FORCE} == 1 \
            || ! -r "${compiled}" \
            || "${src}" -nt "${compiled}" \
        ]]; then
        zcompile -R "${src}" || return
        message="%F{cyan}Compiled%f ${src}"

        # zsh-defer redirects stdout and stderr, so write directly to the terminal.
        if [[ -o interactive && -w /dev/tty ]]; then
            print -P -r -- "${message}" > /dev/tty
        else
            print -P -r -- "${message}" >&2
        fi
    fi
}

ensure_zcompiled ${HOME}/.zshenv
ensure_zcompiled ${HOME}/.zshrc
ensure_zcompiled ${HOME}/.zprofile

# --------------------------------------------------------------------
# Load plugin
# --------------------------------------------------------------------
builtin source ${ZSH_HOME}/plugins/zsh-defer/zsh-defer.plugin.zsh
# source ${ZSH_HOME}/zsh.d/lazy_load_env.sh

echo "Load .zshenv.." >&2

