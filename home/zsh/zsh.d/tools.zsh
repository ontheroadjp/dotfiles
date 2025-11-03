#-------------------------------------------------
# Tools
#-------------------------------------------------
alias exif="exiftool $@"

# GithubGG

# GG for gh
alias GGr='$(ghq root)/github.com/ontheroadjp/GithubGG/manage_github_repositories.sh'
alias GGi='$(ghq root)/github.com/ontheroadjp/GithubGG/manage_github_issues.sh'

# Shell Tools
export SHELL_TOOLS_ROOT=$(ghq root)/github.com/ontheroadjp/Shell-Tools
zsh-defer source ${SHELL_TOOLS_ROOT}/load_shell_tools.sh
zsh-defer source ${SHELL_TOOLS_ROOT}/load_shell_tools_tmux.sh

# deepl clipboard translator
alias en="python $(ghq root)/github.com/ontheroadjp/deepl-clipboard-translater/deepl-clipboard-translater.py -o en | pbcopy"
alias ja="python $(ghq root)/github.com/ontheroadjp/deepl-clipboard-translater/deepl-clipboard-translater.py -o ja | pbcopy"
alias zh="python $(ghq root)/github.com/ontheroadjp/deepl-clipboard-translater/deepl-clipboard-translater.py -o zh | pbcopy"
alias ko="python $(ghq root)/github.com/ontheroadjp/deepl-clipboard-translater/deepl-clipboard-translater.py -o ko | pbcopy"

#-------------------------------------------------
# Utilities
#-------------------------------------------------
# Dammy Image
function _create_dammy_image() {
     convert -size "${1:=320}x${2:=200}" \
            -background "#95a5a6" \
            -fill "#2c3e50" \
            -gravity center label:"$1x$2" $1x$2.${3:=jpg}
}
alias dammyimg='_create_dammy_image'

# show image size
function _display_image_size() { identify $@ }
alias imgsize="_display_image_size"

# memo
alias me="glow ${MEMO_PATH}"


