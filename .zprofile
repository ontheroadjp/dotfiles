#-------------------------------------------------
# Variables
#-------------------------------------------------
export EDITOR=vim
export TERM=xterm
#export LANG=ja_JP.UTF-8
export PATH=.:${DOTPATH}/bin:${PATH}
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}
export PATH=${HOME}/.nodebrew/current/bin:${PATH}
export DOTPATH=${HOME}/dotfiles

autoload -Uz colors && colors   # use color

#-------------------------------------------------
# Functions
#-------------------------------------------------
function _is_exist() {
    type $@ > /dev/null 2>&1
}

function _urlencode {
  echo "$1" | nkf -WwMQ | sed 's/=$//g' | tr = % | tr -d '\n'
}

function _red() { xargs -I{} echo $'\e[31m{}\e[m' }
function _yellow() { xargs -I{} echo $'\e[33m{}\e[m' }
function _green() { xargs -I{} echo $'\e[32m{}\e[m' }

#-------------------------------------------------
# OS common settings
#-------------------------------------------------
alias c='clear'
alias e='exit'
alias h='cd ~'
alias dot='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'
alias init='source ${HOME}/.zprofile && source ${HOME}/.zshrc'
#alias jj=$(:)

# auto URL encode in TERMINAL
# This causes pasted URLs to be automatically quoted, without needing to disable globbing.
#autoload -Uz bracketed-paste-magic
#zle -N bracketed-paste bracketed-paste-magic
#
#autoload -Uz url-quote-magic
#zle -N self-insert url-quote-magic

#-------------------------------------------------
# For MacOSX only
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    #echo "MacOSX with ..."

    # variables
    export PATH="/usr/local/sbin:${PATH}"       # for Homebrew
    export PATH="/usr/local/opt/php@7.4/bin:$PATH"
    export PATH="/usr/local/opt/php@7.4/sbin:$PATH"

    export PATH="/usr/local/share:${PATH}"      # for Python
    export PATH="${HOME}/dotfiles/mac_osx/HandBrakeCLI1.4.2/HandBrakeCLI:${PATH}"   # for HandBrakeCLI
    export WORKSPACE="/Users/hideaki/WORKSPACE"

    # sleep
    alias sleepon='sudo pmset -a disablesleep 0'
    alias sleepoff='sudo pmset -a disablesleep 1'

    # clipboard
    alias '.pb=. | ghead -c -1 | pbcopy'
    alias 'pb.=. | ghead -c -1 | pbcopy'

    ## display dot files on Finder
    #defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder
    #defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder

    # Normal command replace
    alias tree='tree -N'    # for display Japanese char

    # remove .DS_Store file
    alias rmds='find . -type f -name .DS_Store -print0 | xargs -0 rm'
#    alias c='rmds && clear'

#    function _cacheclean() {
#        # Homebrew
#        if [ -d ${HOME}/Library/Caches/Homebrew ]; then
#            brew cleanup -s
#        fi
#    }

    # text editor
    alias cot="open -a /Applications/CotEditor.app" # CotEditor

    # markdown editor
    alias md="open -a /Applications/MarkText.app"     # Typora
    #alias md="open -a /Applications/Typora.app"     # Typora
    #alias md="open -a /Applications/MacDown.app"   # MacDown
    #alias md="open -a /Applications/Bear.app"      # Bear

    # show smtp(d) log
    alias smtplog='sudo log stream --predicater'\''(process == "smtpd") || (process == "smtp")'\'' --info'

    # Ruby
    #RBENV_ROOT="$HOME/.rbenv"
    #export PATH="${RBENV_ROOT}/bin:${PATH}"
    #eval "$(rbenv init -)"

    # open finder
    alias finder='open .'

    # open terminal the same as current finder dir
    function _cd_to_finder_window_opened(){
    	target=$(osascript -e 'tell application "Finder" to if(count of Finder windows) > 0 then get POSIX path of(target of front Finder window as text)')
    	if [ "$target" != "" ]; then
    		cd "$target" && pwd
    	else
    		echo 'No Finder window found.' >&2
    	fi
    }
    alias terminal='_cd_to_finder_window_opened'

    #-------------------------------------------------
    # MarsEdit
    #-------------------------------------------------
    function searchMarsEditImage() {
        imgDir=$(find "${HOME}/Library/Application Support/MarsEdit/UploadedFiles" -name ${1} -exec dirname {} \;)
        [ -e ${imgDir} ] && {
            finder ${imgDir}
        } || { echo "${1} does not exitst." }
    }
    alias me='searchMarsEditImage $@'

    # alias(directory change:Mac)
    alias d='cd ${HOME}/Desktop'
    alias doc='cd ${HOME}/Documents'
    alias dl='cd ${HOME}/Downloads'
    alias gd='cd ${WORKSPACE}/Google\ Drive'
    alias od='cd ${WORKSPACE}/OneDrive'
    alias db='cd ${WORKSPACE}/Dropbox'

    # alias（for ctag）
    # changing the BSD version to the version installed by Homebrew
    alias ctags="`brew --prefix`/bin/ctags"

    # kill notifyd process
    function kill-notifyd-process() {
    	process=`ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}'`
    	sudo kill -9 ${process}
    }

#-------------------------------------------------
# For Linux only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Wellcome to Linux!'

#-------------------------------------------------
# For Windows(Cygwin) only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Wellcome to Cygwin!'
else

#-------------------------------------------------
# For other OS only
#-------------------------------------------------
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#-------------------------------------------------
# tmux
#-------------------------------------------------
source ${HOME}/dotfiles/.zprofile_conf/tmux.profile

#-------------------------------------------------
# zsh
#-------------------------------------------------

# history
[ $SHELL = '/bin/zsh' ] && {
    HISTFILE=${HOME}/.zsh-history
    HISTSIZE=100000
    SAVEHIST=1000000

    # share .zshhistory
    setopt inc_append_history
    setopt share_history
}

#-------------------------------------------------
# Changing directory(Common)
#-------------------------------------------------
function _print_la() {
    rm .DS_Store > /dev/null 2>&1
    [ $(uname) = 'Darwin' ] && {
        ls -laGh $@
    } || {
        ls -laGh --color=auto $@
    }
    current=$(pwd)
    items=$(ls -la $@ | wc -l | tr -d ' ') > /dev/null 2>&1
    #dirs=$(ls -ld */ | wc -l | tr -d ' ') > /dev/null 2>&1
    #print "${items} items: dir ${dirs} items"
}
alias la='_print_la'
alias lad='la -d */'

function _cdla() {
    [ $# -eq 0 ] && place=${HOME} || place=$@
	pushd ${place} && c && la
}
alias cd='_cdla'

# -------------------------------- back to the previous location
alias b='popd && clear && la'

# -------------------------------- general settings
alias HOME="cd ${HOME}"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."

function mkdircd() {
    mkdir $@ && cd $_
}

if [ $(uname) = "Darwin" ]; then
    function _copy_current_dir_path() {
        echo -n $(pwd) | pbcopy && echo 'copy: '$(pbpaste)
    }
    alias ,='_copy_current_dir_path'
fi



#-------------------------------------------------
# AG (grep)
#-------------------------------------------------
if _is_exist ag; then
    alias ag='ag -S --stats --pager "less -F"'
    alias agh='ag --hidden'
fi

#-------------------------------------------------
# Go (GHQ)
#-------------------------------------------------
if _is_exist go; then
    export GOPATH="${HOME}/dev"
    #export GOBIN="${GOPATH}/bin"
    export PATH="${PATH}:${GOPATH}/bin"
    mkdir -p ${GOPATH}
fi

#-------------------------------------------------
# peco
#-------------------------------------------------
if _is_exist peco; then
    source ${DOTPATH}/.zprofile_conf/peco.profile
fi

#-------------------------------------------------
# git
#-------------------------------------------------
if _is_exist git; then
    source ${DOTPATH}/.zprofile_conf/git.profile
fi

#-------------------------------------------------
# exiftool
#-------------------------------------------------
if _is_exist exiftool; then
    alias exif="exiftool $@"
fi

#-------------------------------------------------
# Dammy Image
#-------------------------------------------------
function _create_dammy_image() {
     convert -size "${1:=320}x${2:=200}" \
            -background "#95a5a6" \
            -fill "#2c3e50" \
            -gravity center label:"$1x$2" $1x$2.${3:=jpg}
}
alias dammyimg='_create_dammy_image'

#-------------------------------------------------
# WEB (Dockerhub)
#-------------------------------------------------
if _is_exist ghq && _is_exist peco; then
    function _open_my_dockerhub() {
        place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
        [ ! -z "${place}" ] && {
            open "https://${place}"
        }
    }
    alias dockerhub='_open_my_dockerhub';

    function dockerhub-build() {
        place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
        [ ! -z "${place}" ] && {
            open "https://${place}/builds"
        }
    }
fi

#-------------------------------------------------
# Docker
#-------------------------------------------------
if _is_exist docker; then
    [ -e ~/dotfiles/docker-dd ] && {
        source ${DOTPATH}/docker-dd/docker-dd-common.fnc
        source ${DOTPATH}/docker-dd/docker-dd-network.fnc
        source ${DOTPATH}/docker-dd/docker-dd-volume.fnc
    }

    #export TOYBOX_HOME=/home/nobita/workspace/docker-toybox
    #export PATH=${TOYBOX_HOME}/bin:${PATH}
    #if [ -f ${TOYBOX_HOME}/bin/complition.sh ]; then
    #    source ${TOYBOX_HOME}/bin/complition.sh
    #fi

    # for docker-compose.yml
    alias dd="docker-compose ${@}"
    alias ddup="docker-compose up ${@}"
    alias ddupd="docker-compose up -d ${@}"
    alias dddown="docker-compose down"
    alias ddrestart="docker-compose restart"

    echo "Load Docker settings."
fi

##-------------------------------------------------
## Vagrant
##-------------------------------------------------
if _is_exist vagrant; then
    source ${DOTPATH}/.zprofile_conf/vagrant.profile
fi

#-------------------------------------------------
# PHP: composer
#-------------------------------------------------
if _is_exist composer; then
    export PATH="${PATH}:${HOME}/.composer/vendor/bin"
fi

#-------------------------------------------------
# PHP: Laravel
#-------------------------------------------------
if _is_exist php; then
    alias art='php artisan '
    alias tinker='php artisan tinker'
    alias pub='php artisan vendor:publish --force'
    alias sv='php artisan serve'
    alias rl='php artisan route:list'
    alias t='vendor/bin/phpunit --colors'
fi

#-------------------------------------------------
# dstat - Server resourse monitoring
#-------------------------------------------------
if _is_exist dstat; then
    alias dfull='dstat -Tclmdrn'
    alias dmem='dstat -Tclm'
    alias dcpu='dstat -Tclr'
    alias dnet='dstat -Tclnd'
    alias ddisk='dstat -Tcldr'
    alias dplugins='la /usr/share/dstat/*.py'
fi

# --------------------------------------------
# System Utilities
# --------------------------------------------

# show IP Address
alias ip='ipconfig getifaddr en0'
#alias ip='ipconfig getifaddr en1'

# show image size
function _display_image_size() {
    identify $@
}
alias imgsize="_display_image_size"

# --------------------------------------------
# Shell tools
# --------------------------------------------
SHELL_TOOLS_DIR="$(ghq root)/github.com/ontheroadjp/shell-tools"

source ${SHELL_TOOLS_DIR}/dirmarks/dirmarks.fnc
source ${SHELL_TOOLS_DIR}/shell-stash/shell-stash.fnc
source ${SHELL_TOOLS_DIR}/backup/backup.fnc
source ${SHELL_TOOLS_DIR}/quick-memo/quick-memo.fnc

source ${SHELL_TOOLS_DIR}/file-info/file-info.fnc
source ${SHELL_TOOLS_DIR}/wifi-helth-check/wifi-helth-check.fnc
source ${SHELL_TOOLS_DIR}/colors/colors.fnc

source ${SHELL_TOOLS_DIR}/wareki/wareki.fnc
source ${SHELL_TOOLS_DIR}/weather/weather.fnc
source ${SHELL_TOOLS_DIR}/worldtime/worldtime.fnc
source ${SHELL_TOOLS_DIR}/holiday-jp/holiday-jp.fnc
# today.fnc must be loading after wareki, weather and worldtime loaded.
source ${SHELL_TOOLS_DIR}/today/today.fnc

# for Python scripts
PATH=${SHELL_TOOLS_DIR}/python:${PATH}
alias fix='fix_filename.py'
function _git_commit_msg() {
    gpt_git_commit_msg.py diff | pbcopy
}
alias gitcommitmsg='_git_commit_msg'

# --------------------------------------------
# Command path (my tools)
# --------------------------------------------
export PATH=${GOPATH}/src/github.com/ontheroadjp/dazai:${PATH}
export PATH=${GOPATH}/src/github.com/ontheroadjp/tidyphoto/bin:${PATH}
export PATH=${GOPATH}/src/github.com/ontheroadjp/file-list:${PATH}
export PATH=${GOPATH}/src/github.com/ontheroadjp/dammy:${PATH}
export PATH=${DOTPATH}/bin:${PATH}

alias li=battery
alias wifi=get_ssid

# --------------------------------------------
# GNU Core Utility
# --------------------------------------------
#PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# --------------------------------------------
# pyenv !! -- this must be in .zshrc -- !!
# --------------------------------------------
#export PYENV_ROOT=”$HOME/.pyenv”
#export PATH=”$PYENV_ROOT/bin:$PATH”
##eval "$(pyenv init --path)"
#eval “$(pyenv init -)”

echo 'Load .zprofile.'
