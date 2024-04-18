#-------------------------------------------------
# Git
#-------------------------------------------------
#if _is_exist git; then

    # git complition
    #source ~/dotfiles/bin/git-completion.zsh

    function _is_git_repo() {
        git log > /dev/null 2>&1
    }

    function gontheroadjp() {
        git config --global user.name "ontheroadjp"
        git config --global user.email "dev@ontheroad.jp"
        git config --list | grep user
    }

    function gnutsllc() {
        git config --global user.name "nutsllc"
        git config --global user.email "dev@nutsllc.jp"
        git config --list | grep user
    }

    #-------------------------------------------------
    # Github CLI
    #-------------------------------------------------
#    if _is_exist gh; then

        eval "$(gh completion -s $(echo ${SHELL} | cut -d '/' -f 3))"

        # $1: repo name
        # $2: repo description
        # function _create_new_repository_on_github() {
        #     [ ${#@} -ne 2 ] && { echo "bad argument." && return }
        #
        #     cd ~
        #     local repo_name="$1"
        #     local desc="$2"
        #     local account=$(git config --list | grep user.name | cut -d '=' -f 2)
        #     local local_dir=$(ghq root)/github.com/${account}/${repo_name}
        #
        #     echo "repo name: ${repo_name}"
        #     echo "description: ${desc}"
        #     echo "github.com account: ${account}"
        #
        #     local temp_dir=${WORKSPACE}/GIT_CLI_TEMP
        #     mkdir -p ${temp_dir} && $_
        #     local temp_dir=$(mktemp -d) && cd temp_dir
        #
        #     gh repo create ${repo_name} --public -d "${desc}" --confirm && {
        #         if [ -e ${local_dir} ]; then
        #             rm -rf ${temp_dir} && return
        #         fi
        #         sleep 3
        #     } && ghq get ${account}/${repo_name}.git && {
        #         sleep 3
        #         cd ${local_dir} && \
        #         printf "# ${repo_name}\n${desc}\n" > README.md && \
        #         git add README.md && \
        #         git commit -m "initial commit" && \
        #         git remote set-url origin git@github.com:${account}/${repo_name}.git
        #         git push -u origin master && \
        #         git checkout -b dev && \
        #         git push origin dev && \
        #         GGignore && \
        #         GGhooks && \
        #         rm -rf ${temp_dir}
        #     } || {
        #         echo "${account}/${repo_name} is already exist"
        #     }
        # }
        # alias GGnew='_create_new_repository_on_github'
        #
        # function _delete_repository_on_github() {
        #     local target=$(ghq list \
        #                     | grep -e ontheroadjp -e nutsllc \
        #                     | sed 's:github.com/::' \
        #                     | sed 's:GitHub - ::' \
        #                     | peco --prompt "Git Repository>"
        #                 )
        #     [ -z ${target} ] && return
        #
        #     delete at the web
        #     echo -n "delete \"${target}\" ? (Y/n): "
        #     read input
        #     if [ "${input}" = 'Y' ]; then
        #         gh repo delete ${target} --confirm && {
        #             echo -n 'delete local repository ? (Y/n): '
        #             read input
        #             if [ "${input}" = 'Y' ]; then
        #                 to=$(ghq list | grep "${target}")
        #                 [ ! -z ${to} ] && rm -rf $(ghq root)/${to}
        #             fi
        #         }
        #     fi
        # }
        # alias GGdel='_delete_repository_on_github'
        # alias GGi='gh issue list'
#    fi

    #-------------------------------------------------
    # alias & functions
    #-------------------------------------------------
    alias gg='git graph'
    alias ggstat='git graph --stat'
    alias gl='git log'
    alias gl1='git log --oneline --graph'
    alias gs='git status'
    alias gd='git diff'
    alias gc='git checkout'
    alias gmaster='git checkout master'
    alias gdev='git checkout dev'
    alias gb='git branch'
    function _git_commit_as_wip() { git add -A && git commit -m "[WIP] ${1}" }
    alias gwip='_git_commit_as_wip $@'
    function _git_add_and_git_status() { git add "$@" && git status }
    alias ga='_git_add_and_git_status'

    #-------------------------------------------------
    # .gitignore
    #-------------------------------------------------
    function _get_gitignore() {
        local url="https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore"
        curl -L -o .gitignore ${url}
    }
    alias gignore='_get_gitignore'

    #-------------------------------------------------
    # .githook
    #-------------------------------------------------
    function _set_githooks() {
        mkdir -p .githooks
        cp ${HOME}/dotfiles/.git_template/hooks/* .githooks
        git config --local core.hooksPath .githooks
        chmod -R 755 .githooks
    }
    alias ghooks='_set_githooks'

    #-------------------------------------------------
    # HTML5 (new site)
    #-------------------------------------------------
    function _get_html5_boiler_plate() {
        local url='https://github.com/ontheroadjp/webpack-boilerplate-for-static-website'
        git clone ${url} html5
    }
    alias html5="_get_html5_boiler_plate"

    #-------------------------------------------------
    # Go to ..
    #-------------------------------------------------
    function _go_to_repository_root() {
        if _is_git_repo; then
            cd $(git rev-parse --show-toplevel)
        else
            echo "not git repo."
        fi
    }
    alias G="_go_to_repository_root"

    # if _is_exist ghq && _is_exist peco; then
    #     function _cd_to_repository_from_ghq_list_by_peco() {
    #         local to=$(ghq list | peco --prompt "Local Repository To >" --query "${*}")
    #         [ ! -z ${to} ] && cd $(ghq root)/${to}
    #     }
    #     alias rrpeco='_cd_to_repository_from_ghq_list_by_peco'
    # fi

    if _is_exist ghq && _is_exist fzf; then
        function _cd_to_repository_from_ghq_list_by_fzf() {
            local to=$(ghq list | fzf-tmux -p 65%)
            [ ! -z ${to} ] && cd $(ghq root)/${to}
        }
        alias rr='_cd_to_repository_from_ghq_list_by_fzf'
    fi

    #-------------------------------------------------
    # Go to the github.com
    #-------------------------------------------------
    if _is_exist ghq && _is_exist peco; then
        function _open_github_from_ghq_list() {
            local target=$(ghq list \
                            | sed 's:GitHub - ::' \
                            | sed 's@^@https://@g' \
                            | peco --prompt "Open GitHub.com >" --query "${*}"
                        )
            [ ! -z ${target} ] && open ${target}
        }
        alias rrg='_open_github_from_ghq_list';
    fi

    if _is_exist peco; then
        function _open_github_from_current_dir() {
            local url="https://github.com"
            if _is_git_repo; then
                local target=$(git remote get-url origin 2>/dev/null \
                    | sed -e 's/:/\//g' \
                    | sed -e 's%.*\(github.com.*\)%https://\1%' \
                    | sed -e "s%$%\n${url}/ontheroadjp\n${url}/nutsllc%" \
                    | peco --prompt "Open GitHub.com >" --query "${*}"
                    )
            else
                local target=$(print "${url}/ontheroadjp\n${url}/nutsllc" \
                    | peco --prompt "Open GitHub.com >" --query "${*}"
                    )
            fi
            #open $(git remote get-url origin)
            [ ! -z ${target} ] && open ${target}
        }
        alias github="_open_github_from_current_dir"

        # gist
        function _view_gist() {
            id=$(gh gist list | peco | awk '{print $1}')
            gh gist view ${id}
        }
        alias gistv=_view_gist
    fi

    echo "Load Git settings."
#fi
