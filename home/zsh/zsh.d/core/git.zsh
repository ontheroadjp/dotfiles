#-------------------------------------------------
# Git
#-------------------------------------------------
fpath=(
    ${ZSH_HOME}/plugins/git-completion.zsh
    # $(brew --prefix)/share/zsh/site-functions
    ${fpath}
)

function _is_git_repo() {
    git log > /dev/null 2>&1
}

#-------------------------------------------------
# Github CLI
#-------------------------------------------------
eval "$(gh completion -s $(echo ${SHELL} | cut -d '/' -f 3))"

#-------------------------------------------------
# git alias & functions
#-------------------------------------------------
alias gl='git log'
alias gg='git graph --oneline --graph'
# alias gg='git log --oneline --graph'
alias ggg='git log --oneline --graph --stat'
alias gs='git status'
alias gss='git status --short'
alias gr='git remote'
alias grv='git remote -v'
alias gb='git branch'
alias gbvv='git branch -vv'
alias gba='git branch -a'
alias gc='git checkout'
alias gcm='git checkout -B main'
alias gcw='git checkout -B works'
alias gd='git diff'
alias gds='git diff --staged'
alias gp='git push'
alias gfap='git fetch --all --prune'
ga() { git add "$@" && git status }
gwip() { git add -A && git commit -m "[WIP] ${1}" }
alias gbk='git checkout -b backup-$(date +%Y%m%d-%H%M%S)'

#-------------------------------------------------
# github alias & functions
#-------------------------------------------------
alias ghil="gh issue list"
alias ghpl="gh pr list"
alias ghpm="gh pr merge --merge --delete-branch"

#-------------------------------------------------
# .gitignore
#-------------------------------------------------
function _get_gitignore() {
    local url="https://raw.githubusercontent.com/github/gitignore/master/Global/macOS.gitignore"
    curl -L -o .gitignore ${url}
}
alias gitignore='_get_gitignore'

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
alias g="_go_to_repository_root"

#-------------------------------------------------
# Go to the github.com
#-------------------------------------------------
if _is_exist ghq && _is_exist fzf; then
    function _open_github_from_ghq_list() {
        local target=$(ghq list \
                        | sed 's:GitHub - ::' \
                        | sed 's@^@https://@g' \
                        | fzf
                    )
        [ ! -z ${target} ] && open ${target}
    }
    alias rrgit='_open_github_from_ghq_list';
fi

function _open_github_from_current_dir() {
    local url="https://github.com"
    if _is_git_repo; then

        local target=$(git remote get-url origin 2>/dev/null \
            | sed -e 's/:/\//g' \
            | sed -e 's%.*\(github.com.*\)%https://\1%' \
            | sed -e "s%$%\n${url}/ontheroadjp\n${url}/nutsllc%" \
            | fzf
            )

    else
        local target=$(print "${url}/ontheroadjp\n${url}/nutsllc" \
            | fzf
            )
    fi
    #open $(git remote get-url origin)
    [ ! -z ${target} ] && open ${target}
}
alias github="_open_github_from_current_dir"

# gist
function _view_gist() {
    id=$(gh gist list | fzf | awk '{print $1}')
    gh gist view ${id}
}
alias gist=_view_gist

echo "Load Git settings."

