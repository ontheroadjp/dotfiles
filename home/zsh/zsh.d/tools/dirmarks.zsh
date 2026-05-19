#----------------------------------------------------------------
# dirmarks.zsh
#----------------------------------------------------------------
# A lightweight directory bookmarking utility for Zsh.
#
# Overview:
#   This script allows you to "mark" frequently used directories
#   and quickly jump to them using short aliases.
#
#   Marks are stored as plain text files under:
#       ${XDG_STATE_HOME}/dirmarks
#   Each file represents one bookmark and contains the absolute
#   path of the corresponding directory.
#
# Features:
#   - Save the current directory as a named mark.
#   - Instantly jump to a marked directory.
#   - Use predefined aliases for single-letter quick marks.
#   - Use fzf to interactively jump between saved locations.
#
# Aliases:
#   mm, nn, jj, kk, ll, oo, ii, uu  → mark current dir as 'm','n',...
#   m,  n,  j,  k,  l,  o,  i,  u   → jump to marked dir
#   dm                              → fuzzy-select (fzf) and jump
#
# Example:
#   $ cd ~/projects/myapp
#   $ mm         # mark current dir as "m"
#   $ cd /tmp
#   $ m          # jump back to ~/projects/myapp
#
# Notes:
#   - Designed for use in interactive shells only.
#   - Requires 'fzf' for interactive directory selection (dm alias).
#   - Uses ${XDG_STATE_HOME}/dirmarks as the default storage.
#     If $XDG_STATE_HOME is not defined, define it manually or adapt the path.
#
# Author:
#   Hideaki Ishihara
#----------------------------------------------------------------

DIRMARKS_STATE_DIR="${XDG_STATE_HOME}/dirmarks"
mkdir -p "$DIRMARKS_STATE_DIR"

function _dirmarks() {

    case $1 in
        mark )
            pwd > ${DIRMARKS_STATE_DIR}/${2}${2}
            echo 'markd!'
            return 0
            ;;
        jump )
            local to=${DIRMARKS_STATE_DIR}/${2}${2}
            [ -f ${to} ] && {
                cd $(cat ${to})
                # echo "jump: ${to}"
            } || echo "not set."
            return 0
            ;;
    esac
}

function _cd_to_dirmarks() {
    result=$(cat $(find ${DIRMARKS_STATE_DIR} -type f) | fzf)
    [ ! -z ${result} ] && { cd ${result} }
}

alias mm='_dirmarks mark m'
alias nn='_dirmarks mark n'
alias jj='_dirmarks mark j'
alias kk='_dirmarks mark k'
alias ll='_dirmarks mark l'
alias oo='_dirmarks mark o'
alias ii='_dirmarks mark i'
alias uu='_dirmarks mark u'

alias m='_dirmarks jump m'
alias n='_dirmarks jump n'
alias j='_dirmarks jump j'
alias k='_dirmarks jump k'
alias l='_dirmarks jump l'
alias i='_dirmarks jump i'
alias o='_dirmarks jump o'
alias u='_dirmarks jump u'

alias dm='_cd_to_dirmarks'
alias marks='_cd_to_dirmarks'

