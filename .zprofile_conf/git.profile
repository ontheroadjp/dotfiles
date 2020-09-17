#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then

    #-------------------------------------------------
    # alias
    #-------------------------------------------------
    alias gg='git graph'
    alias ggs='git graph --stat'
    alias gs='git status'
    alias gd='git diff'
    alias gdni='git diff --no-index'
    alias gcom='git commit -v'
    alias gb='git branch'
    alias gc='git checkout'
    alias gm='git merge --no-ff'
    alias gbk='git commit -m "[WIP] still working"'
    alias wip='git commit -m "[wip] still working"'

    function git_add_status() {
        git add "$@" && git status
    }
    alias ga='git_add_status'

#    function _git_reset_status() {
#        git reset "$@" && git status
#    }
#    alias gr='_git_reset_status'

    #-------------------------------------------------
    # cd
    #-------------------------------------------------
    function _go_to_repository_root() {
        cd $(git rev-parse --show-toplevel)
    }
    alias ggg="_go_to_repository_root"
    alias gr="_go_to_repository_root"

    if _is_exist ghq; then
        function _cd_to_repository_from_ghq_list() {
            to=$(ghq list | peco --prompt "Git Repository>" --query "${*}" 2>/dev/null)
            [ ! -z ${to} ] && cd $(ghq root)/${to}
        }
        alias rr='_cd_to_repository_from_ghq_list'
    fi


    #-------------------------------------------------
    # Go to the github.com
    #-------------------------------------------------
    function _open_github_from_current_dir() {
        open $(git remote get-url origin)
    }
    alias github="_open_github_from_current_dir"

    function _open_github_from_ghq_list() {
        place="$(ghq list | peco)"
        [ ! -z ${place} ] && {
            open "https://${place}"
        }
    }
    if _is_exist ghq; then
        alias rrgit='_open_github_from_ghq_list';
    fi

    function _open_github_from_my_repository_list() {
        place="$(cat ${HOME}/dotfiles/.bash_profile_git_repository_list.txt | peco | cut -f 2 -d ' ')"
        [ ! -z "${place}" ] && {
            open "https://github.com/${place}?tab=repositories"
        }
    }
    alias mygit='_open_github_from_my_repository_list';
    alias editmygit='vim ${HOME}/dotfiles/.bash_profile_git_repository_list.txt'

    echo "Load Git settings."
fi
