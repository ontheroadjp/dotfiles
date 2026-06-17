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

#-------------------------------------------------
# Guard for the interactive shell
# The remaining setup is only needed by interactive shells.
#-------------------------------------------------
[[ -o interactive ]] || return

# --------------------------------------------------------------------
# zsh compile
# --------------------------------------------------------------------
function _zcompile_notice() {
    local message="$1"
    local notice_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompile.notices"

    if [[ -n "${zsh_defer_options:-}" ]]; then
        [[ -d "${notice_file:h}" ]] || mkdir -p "${notice_file:h}" || return
        print -r -- "${message}" >> "${notice_file}"
    else
        print -P -u2 -r -- "${message}"
    fi
}

function _show_zcompile_notices() {
    local notice_file="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompile.notices"
    local message

    [[ -o interactive && -r "${notice_file}" ]] || return
    while IFS= read -r message; do
        print -P -u2 -r -- "${message}"
    done < "${notice_file}"
    : >| "${notice_file}"
}

function zsource() {
    local src="$1"
    local target

    if [[ -L "${src}" && ! -e "${src}" ]]; then
        target=$(readlink -- "${src}" 2>/dev/null)
        _zcompile_notice "%F{yellow}Broken symlink%f ${src} -> ${target}"
        return 0
    fi

    if [[ ! -e "${src}" ]]; then
        _zcompile_notice "%F{yellow}Source not found%f ${src}"
        return 0
    fi

    if ! ensure_zcompiled "${src}"; then
        _zcompile_notice "%F{yellow}Compile failed%f ${src}; loading source instead"
    fi
    builtin source "${src}"
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
        _zcompile_notice "${message}"
    fi
}

zdefer_source() {
    zsh-defer zsource "$1"
}

ensure_zcompiled ${HOME}/.zshenv
ensure_zcompiled ${HOME}/.zshrc
ensure_zcompiled ${HOME}/.zprofile
_show_zcompile_notices

# --------------------------------------------------------------------
# Load plugin
# --------------------------------------------------------------------
builtin source ${ZSH_HOME}/plugins/zsh-defer/zsh-defer.plugin.zsh
# source ${ZSH_HOME}/zsh.d/lazy_load_env.sh

echo "Load .zshenv.." >&2

