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
# git alias & functions
#-------------------------------------------------
alias gl='git log'
alias gg='git log --oneline --graph'
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
gsp() {
    # 1. Setting the Stage: Synchronize the latest remote state with the local repository and clean up deleted branches
    git fetch -p origin

    # 2. Cleaning up local branches
    # Exclude only those that exactly match 'main', while allowing leading whitespace or '*'
    local_branches=$(git branch --merged main | grep -Ev '^\*?\s*main$')
    if [ -n "$local_branches" ]; then
        # Execute only if the target exists. Error suppression (2>/dev/null) has been deprecated.
        echo "$local_branches" | xargs git branch -d
    fi

    # 3. Clean up remote branches
    # Tighten regular expressions to prevent false positives caused by prefix matches (e.g., `origin/main-feature`)
    # Exclude `origin/HEAD` and `origin/main` explicitly
    remote_branches=$(git branch -r --merged origin/main | \
        grep -Ev '^\s*origin/(main|HEAD)' | \
        sed 's#^[[:space:]]*origin/##')

    if [ -n "$remote_branches" ]; then
        # Delete multiple branches in a single push, optimizing O(N) network I/O to O(1)
        echo "$remote_branches" | xargs git push origin --delete
    fi
}

#-------------------------------------------------
# Github CLI
#-------------------------------------------------
eval "$(gh completion -s $(echo ${SHELL} | cut -d '/' -f 3))"

# gh issue
alias issl="gh issue list"
issv() { gh issue view $1 }
issweb() { gh issue view $1 --web }

# gh pr
alias prl="gh pr list"
prv() { gh pr view $1 }

# gh merge
prm() { gh pr merge "$1" --merge }
is-pr-merged() {
    gh pr view "$1" --json state,mergedAt,mergeCommit
}

# alias grl='gh run list --limit 10'
runl() { gh run list --limit "${1:-10}" }
alias runv='gh run view'
alias runvf='gh run view --log-failed'
alias rerun='gh run rerun'
alias rerunf='gh run rerun --failed'

#-------------------------------------------------
# .gitignore
#--------r----------------------------------------
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

