#-------------------------------------------------
# Tools
#-------------------------------------------------
REPO_BASE="$(ghq root)/github.com/ontheroadjp"

# exif tool
alias exif="exiftool $@"

# github-gg
alias GG='${REPO_BASE}/GithubGG/gh_repo.sh list'
alias GGv='${REPO_BASE}/GithubGG/gh_repo.sh view'
alias GGr='${REPO_BASE}/GithubGG/gh_repo.sh'
alias GGi='${REPO_BASE}/GithubGG/gh_issue.sh list'
alias GGih='${REPO_BASE}/GithubGG/gh_issue.sh'
alias GGie='${REPO_BASE}/GithubGG/gh_issue.sh edit'
alias GGiv='${REPO_BASE}/GithubGG/gh_issue.sh web'

# Shell Tools
export SHELLTOOLS_ROOT=$(ghq root)/github.com/ontheroadjp/Shell-Tools
zsh-defer source ${SHELLTOOLS_ROOT}/load_shell_tools.sh

# deepl clipboard translator
alias en="python ${REPO_BASE}/deepl-clipboard-translater/deepl-clipboard-translater.py -o en | pbcopy"
alias ja="python ${REPO_BASE}/deepl-clipboard-translater/deepl-clipboard-translater.py -o ja | pbcopy"
alias zh="python ${REPO_BASE}/deepl-clipboard-translater/deepl-clipboard-translater.py -o zh | pbcopy"
alias ko="python ${REPO_BASE}/deepl-clipboard-translater/deepl-clipboard-translater.py -o ko | pbcopy"

#-------------------------------------------------
# Utilities
#-------------------------------------------------
# Dammy Image
# function _create_dammy_image() {
#      convert -size "${1:=320}x${2:=200}" \
#             -background "#95a5a6" \
#             -fill "#2c3e50" \
#             -gravity center label:"$1x$2" $1x$2.${3:=jpg}
# }
# alias dammyimg='_create_dammy_image'

# show image size
function _display_image_size() { identify $@ }
alias imgsize="_display_image_size"

# memo
alias me="glow ${MEMO_PATH}"


#-------------------------------------------------
# Networking
#-------------------------------------------------
# auto URL encode in TERMINAL
# This causes pasted URLs to be automatically quoted,
# without needing to disable globbing.
#autoload -Uz bracketed-paste-magic
#zle -N bracketed-paste bracketed-paste-magic
#autoload -Uz url-quote-magic
#zle -N self-insert url-quote-magic

# URL Encoding
function _urlencode {
  echo "$1" | nkf -WwMQ | sed 's/=$//g' | tr = % | tr -d '\n'
}
alias urlenc="_urlencode"

# show IP Address
alias ip0='ipconfig getifaddr en0'
alias ip1='ipconfig getifaddr en1'

# dstat - Server resourse monitoring
if _is_exist dstat; then
    alias dfull='dstat -Tclmdrn'
    alias dmem='dstat -Tclm'
    alias dcpu='dstat -Tclr'
    alias dnet='dstat -Tclnd'
    alias ddisk='dstat -Tcldr'
    alias dplugins='la /usr/share/dstat/*.py'
fi

# show smtp(d) log
alias smtplog='sudo log stream --predicater'\''(process == "smtpd") \
                        || (process == "smtp")'\'' --info'

