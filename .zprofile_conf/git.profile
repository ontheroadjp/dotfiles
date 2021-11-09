#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then

    #-------------------------------------------------
    # Github CLI
    #-------------------------------------------------
    if _is_exist gh; then
        eval "$(gh completion -s zsh)"
    fi

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

    function _git_add_to_status() {
        git add "$@" && git status
    }
    alias ga='_git_add_to_status'

#    function _git_reset_status() {
#        git reset "$@" && git status
#    }
#    alias gr='_git_reset_status'

    #-------------------------------------------------
    # .gitignore
    #-------------------------------------------------
    function _get_gitignore() {
        local url="https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore"
        curl -L -o .gitignore ${url}
    }
    alias gitignore='_get_gitignore'

    #-------------------------------------------------
    # HTML5 (new site)
    #-------------------------------------------------
    function _get_html5_boiler_plate() {
        local url='https://github.com/ontheroadjp/webpack-boilerplate-for-static-website'
        git clone ${url} html5
    }
    alias html5="_get_html5_boiler_plate"

    #-------------------------------------------------
    # cd
    #-------------------------------------------------
    function _go_to_repository_root() {
        cd $(git rev-parse --show-toplevel)
    }
    alias ggg="_go_to_repository_root"
    alias G="_go_to_repository_root"

    if _is_exist ghq; then
        function _cd_to_repository_from_ghq_list() {
            to=$(ghq list | peco --prompt "Git Repository>" --query "${*}")
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
    alias goweb="_open_github_from_current_dir"

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
        local repo_list_path=${HOME}/dotfiles/.my_repository_list.txt""
        place="$(cat ${repo_list_path} | \
                    peco --prompt "My Repositories on GitHub>" | \
                    cut -f 2 -d ' '
                )"
        [ ! -z "${place}" ] && open "https://github.com/${place}?tab=repositories"
    }
    alias mygithub='_open_github_from_my_repository_list';
    alias mygit='_open_github_from_my_repository_list';
    alias repo='_open_github_from_my_repository_list';

    echo "Load Git settings."
fi
