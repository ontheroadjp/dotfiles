#-------------------------------------------------
# Variables
#-------------------------------------------------
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export EDITOR=vim
export DOTPATH=${HOME}/dotfiles
export DOTFILES_BIN=${DOTPATH}/bin
export WORKSPACE="${HOME}/WORKSPACE"
export PATH=${DOTPATH}/bin:${PATH}
# export PATH=/usr/local/Cellar/node/21.7.1/bin:${PATH}
# export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}
autoload -Uz colors && colors   # use color

#-------------------------------------------------
# Functions
# usage: echo 'piyo' | _red
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }

function _black() { xargs -I{} echo $'\e[30m{}\e[m' }
function _red() { xargs -I{} echo $'\e[31m{}\e[m' }
function _green() { xargs -I{} echo $'\e[32m{}\e[m' }
function _yellow() { xargs -I{} echo $'\e[33m{}\e[m' }
function _blue() { xargs -I{} echo $'\e[34m{}\e[m' }
function _pink() { xargs -I{} echo $'\e[35m{}\e[m' }
function _cyan() { xargs -I{} echo $'\e[36m{}\e[m' }
function _white() { xargs -I{} echo $'\e[37m{}\e[m' }

function _black_fill() { xargs -I{} echo $'\e[40m{}\e[m' }
function _red_fill() { xargs -I{} echo $'\e[41m{}\e[m' }
function _green_fill() { xargs -I{} echo $'\e[42m{}\e[m' }
function _yellow_fill() { xargs -I{} echo $'\e[43m{}\e[m' }
function _blue_fill() { xargs -I{} echo $'\e[44m{}\e[m' }
function _pink_fill() { xargs -I{} echo $'\e[45m{}\e[m' }
function _cyan_fill() { xargs -I{} echo $'\e[46m{}\e[m' }
function _white_fill() { xargs -I{} echo $'\e[47m{}\e[m' }

#-------------------------------------------------
# Generic alias
#-------------------------------------------------
alias c='clear'
alias e='exit'
alias h='cd ${HOME}'
alias dot='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'

#-------------------------------------------------
# OS common settings
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # For MacOSX
    zsh-defer source ${ZSH_HOME}/zsh.d/core/macosx.zsh
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
    # For Linux only
	echo 'Wellcome to Linux!'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
    # For Windows (Cygwin) only
	echo 'Wellcome to Cygwin!'
else
    # For other OS only
	echo "Wellcome to $(uname -a) !"
fi

#-------------------------------------------------
# zsh
#-------------------------------------------------
# dilay default 0.4sec
KEYTIMEOUT=0

# complition - zcompdump
autoload -Uz compinit

# for dump in ~/.zcompdump(N.mh+24); do
#     compinit
# done

for dump in ${ZSH_HOME}/.zcompdump(N.mh+24); do
    compinit
done

compinit -C

# zcompcache
zstyle ':completion:*' cache-path ${ZSH_HOME}/zsh/.zcompcache


# history
HISTFILE=${HOME}/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

#-------------------------------------------------
# Go (GHQ)
#-------------------------------------------------
if _is_exist go; then
    export GOPATH="${HOME}/dev"
    mkdir -p ${GOPATH}
fi

#-------------------------------------------------
# Load Core
#-------------------------------------------------
source ${ZSH_HOME}/zsh.d/core/tmux.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/cdla.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/docker.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/git.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/peco.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/fzf.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/ripgrap.zsh
zsh-defer source ${ZSH_HOME}/zsh.d/core/gemini.zsh

#-------------------------------------------------
# Load Dev
#-------------------------------------------------
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/php.zsh
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/ruby.zsh
# zsh-defer source ${ZSH_HOME}/zsh.d/dev/vagrant.zsh
source ${ZSH_HOME}/zsh.d/dev/python.zsh
source ${ZSH_HOME}/zsh.d/dev/python.zsh

#-------------------------------------------------
# Load others
#-------------------------------------------------
zsh-defer source ${ZSH_HOME}/zsh.d/networking.zsh

#-------------------------------------------------
# Tools
#-------------------------------------------------
alias exif="exiftool $@"

# GithubGG

# ln -sf $(ghq root)/github.com/ontheroadjp/GithubGG/manage_github_repositories.sh ${DOTPATH}/bin
# ln -sf $(ghq root)/github.com/ontheroadjp/GithubGG/manage_github_issues.sh ${DOTPATH}/bin
# alias GGr='manage_github_repositories.sh'
# alias GGi='manage_github_issues.sh'

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

echo 'Load .zprofile.'
