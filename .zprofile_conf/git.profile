#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then

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
    if _is_exist gh; then
#        [ $(echo $SHELL) = '/bin/zsh' ] && {
#            eval "$(gh completion -s zsh)"
#        }
#        [ $(echo $SHELL) = '/bin/bash' ] && {
#            eval "$(gh completion -s bash)"
#        }
        eval "$(gh completion -s $(echo ${SHELL} | cut -d '/' -f 3))"

        # $1: git account
        # $2: repo name
        # $3: repo description
        function _create_new_repository_on_github() {
            [ ${#@} -ne 3 ] && { echo "bad argument." && return }

            local repo_name="$1"
            local desc="$2"
            local account="$3"
            local local_dir=$(ghq root)/github.com/${account}/${repo_name}

#            echo "repo name: ${repo_name}"
#            echo "description: ${desc}"
#            echo "github.com account: ${account}"

            local temp_dir=${WORKSPACE}/GIT_CLI_TEMP
            mkdir ${temp_dir} && $_

            gh repo create ${repo_name} --public -d "${desc}" --confirm && \
            ghq get ${account}/${repo_name}.git && {
                while true
                do
                    if [ -e ${local_dir} ]; then
                        break
                    fi
                    sleep 0.5
                done
                cd ${local_dir} && \
                printf "# ${repo_name}\n${desc}\n" > README.md && \
                git add README.md && \
                git commit -m "initial commit" && \
                git remote set-url origin git@github.com:${account}/${repo_name}.git
                git push origin master && \
                git checkout -b dev && \
                git push origin dev && \
                rm -rf ${temp_dir}
            }
        }
        alias gnew='_create_new_repository_on_github'

        function _delete_repository_on_github() {
            local target=$(ghq list \
                            | grep -e ontheroadjp -e nutsllc \
                            | sed 's:github.com/::' \
                            | sed 's:GitHub - ::' \
                            | peco --prompt "Git Repository>"
                        )
            [ -z ${target} ] && return

            # delete at the web
            echo -n "delete \"${target}\" ? (Y/n): "
            read input
            if [ "${input}" = 'Y' ]; then
                gh repo delete ${target} --confirm && {
                    echo -n 'delete local repository ? (Y/n): '
                    read input
                    if [ "${input}" = 'Y' ]; then
                        to=$(ghq list | grep "${target}")
                        [ ! -z ${to} ] && rm -rf $(ghq root)/${to}
                    fi
                }
            fi
        }
        alias gdel='_delete_repository_on_github'
    fi

    #-------------------------------------------------
    # alias
    #-------------------------------------------------
    alias gg='git graph'
    alias ggs='git graph --stat'
    alias gs='git status'
#    alias gd='git diff'
#    alias gdni='git diff --no-index'
#    alias gcom='git commit -v'
#    alias gb='git branch'
#    alias gc='git checkout'
#    alias gm='git merge --no-ff'
    alias gbk='git commit -m "[WIP] temporary backup"'
    alias gwip='git commit -m "[wip] still working"'

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
        if _is_git_repo; then
            cd $(git rev-parse --show-toplevel)
        else
            echo "not git repo."
        fi
    }
    alias G="_go_to_repository_root"

    if _is_exist ghq && _is_exist peco; then
        function _cd_to_repository_from_ghq_list() {
            to=$(ghq list | peco --prompt "Local Repository To >" --query "${*}")
            [ ! -z ${to} ] && cd $(ghq root)/${to}
        }
        alias rr='_cd_to_repository_from_ghq_list'
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
    fi

    echo "Load Git settings."
fi
