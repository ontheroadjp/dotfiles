#echo "Load .zprofile."

export EDITOR=vim
export TERM=xterm

#-------------------------------------------------
# use color
#-------------------------------------------------
autoload -Uz colors && colors

#-------------------------------------------------
# utilities
# usage:
#    if _is_exist vim; then
#        alias vp='vim ~/.zprofile'
#        alias vv='vim ~/.zshrc'
#    fi
#
#-------------------------------------------------
function _is_exist() {
    type $@ > /dev/null 2>&1
}

#-------------------------------------------------
# test
#-------------------------------------------------
function opeco() {
    if [ $# -eq 0 ]; then
        search_dir=$(pwd)
    elif [ ! -d $1 ]; then
        echo "bad argument." && return
    else
        search_dir=$1
    fi

    item=$(ls "${search_dir}" | peco) && [ -z "${item}" ] && return
    while [ -d "${search_dir}/${item}" ]; do
        search_dir="${search_dir}/${item}"
        item=$(ls "${search_dir}" | peco) && [ -z "${item}" ] && return
    done

    if [ -f ${item} ]; then
        cat ${item}
    fi

    #open "${search_dir}/${item}"
    cd "${search_dir}/${item}"
}

function laracast() {
    opeco $HOME/dev/src/github.com/iamfreee/laracasts-downloader/Downloads
}

#-------------------------------------------------
# For MacOSX only
#-------------------------------------------------
if [ is_osx ];then
    #echo "MacOSX with ..."

    # remove .DS_Store file
    alias rmds='find . -name .DS_Store | xargs rm'

    # for Homebrew
    export PATH="/usr/local/sbin:$PATH"

    # Ruby
    #RBENV_ROOT="$HOME/.rbenv"
    #export PATH="$RBENV_ROOT/bin:$PATH"
    #eval "$(rbenv init -)"

	# opening the current directory of the Terminal.app in the Finder.app
	alias finder='open .'

	# opening the current directory of the Finder.app in the Terminal.app
	function terminal(){
		target=`osascript -e 'tell application "Finder" to if(count of Finder windows) > 0 then get POSIX path of(target of front Finder window as text)'`
		if [ "$target" != "" ]
		then
			cd "$target"
			pwd
		else
			echo 'No Finder window found.' >&2
		fi
	}

	# Chrome
    # https://developers.google.com/web/updates/2017/04/headless-chrome
	alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

	# Sublime Text 3
	alias subl='open -a "/Applications/Sublime Text.app"'

	# Bear Editor
	alias bear='open -a "/Applications/Bear.app"'

	# Markdown Editor
	alias md='open -a "/Applications/MacDown.app"'

	# Markdown Editor
	alias typora='open -a "/Applications/Typora.app"'

    # Cot Editor
    alias cot='open -a "/Applications/CotEditor.app"'

	# changing vi and vim to MacVim
	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias mvim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

    # alias(directory change:Mac)
	alias Desktop='cdla ${HOME}/Desktop'
	alias Documents='cdla ${HOME}/Documents'
	alias Downloads='cdla ${HOME}/Downloads'

	alias googledrive='cdla ${HOME}/WORKSPACE/Google\ Drive'
	alias onedrive='cdla ${HOME}/WORKSPACE/OneDrive'
	alias dropbox='cdla ${HOME}/WORKSPACE/Dropbox'

	alias cdmemo='cdla ${HOME}/WORKSPACE/Dropbox/アプリ/PlainText\ 2/INBOX'

	# alias（for ctag）
	# changing the BSD version to the version installed by Homebrew
	alias ctags="`brew --prefix`/bin/ctags"

	# MacPorts Installer addition on 2015-10-09_at_13:13:23: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.

    # Python
	export PATH="/usr/local/share:$PATH"

	# kill notifyd process
	function kill-notifyd-process() {
		process=`ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}'`
		sudo kill -9 ${process}
	}

##-------------------------------------------------
## For Linux only
##-------------------------------------------------
#elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
#	echo 'Wellcome to Linux!'
#
##-------------------------------------------------
## For Windows(Cygwin) only
##-------------------------------------------------
#elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
#	echo 'Wellcome to Cygwin!'
#else
#
##-------------------------------------------------
## For other OS only
##-------------------------------------------------
#	echo "Your platform ($(uname -a)) is not supported."
#	exit 1

fi

#-------------------------------------------------
# tmux
#-------------------------------------------------
source ${HOME}/dotfiles/.zprofile_conf/tmux.profile

#-------------------------------------------------
# OS common settings
#-------------------------------------------------
alias c='clear && la'
alias e='exit'
#alias jj=$(:)

#-------------------------------------------------
# Changing directory(Common)
#-------------------------------------------------
function _print_la() {
    ls -laG $@
    if [ $# -ne 0 ]; then
        if [ ${1:0:1} == '/' ]; then
            printf "\e[31m$1\e[m\n"
        else
            printf "\e[31m$(pwd)/$1\e[m\n"
        fi
    fi
}
#alias la='ls -laG'
alias la='_print_la'

cdla() {
    [ $# -eq 0 ] && place=${HOME} || place=$@
	pushd ${place} && clear && la
}
alias cd='cdla'

# -------------------------------- back to the previous location
alias b='popd && clear && la'

# -------------------------------- general settings
alias home="cd ${HOME}"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#-------------------------------------------------
# Directory mark and jump
#-------------------------------------------------
dirmarks="$HOME/dotfiles/.dirmarks"
mkdir -p ${dirmarks}

function _mark_to_directory() {
    [ $# -eq 1 ] && pwd > ${dirmarks}/${1}${1}; echo 'markd!'
}

function _jump_to_directory() {
    [ $# -eq 1 ] && [ -f ${dirmarks}/${1}${1} ] && {
        cd $(cat ${dirmarks}/${1}${1})
    } || echo "not set."
}

alias mm='_mark_to_directory m'
alias nn='_mark_to_directory n'
alias ii='_mark_to_directory i'
alias oo='_mark_to_directory o'

alias m='_jump_to_directory m'
alias n='_jump_to_directory n'
alias i='_jump_to_directory i'
alias o='_jump_to_directory o'

#-------------------------------------------------
# Vim
#-------------------------------------------------
function _open_file_specify_file_extension() {
    [ ! -z "${1}" ] && {
        place="$(find . -type d -name node_modules -prune -o -type d -name vendor -prune -o -type f -name "*.${1}" | peco)"
        [ ! -z "${place}" ] && {
            vim ${place}
        }
    } || {
        echo 'need one argument must be file exension'
    }
}
alias ee='_open_file_specify_file_extension'

#-------------------------------------------------
# Go
#-------------------------------------------------
if _is_exist go; then
    export GOPATH="${HOME}/dev"
    #export GOBIN="${GOPATH}/bin"
    export PATH="${PATH}:${GOPATH}/bin"
    mkdir -p ${GOPATH}
fi

##-------------------------------------------------
## Peco
##-------------------------------------------------
source ${HOME}/dotfiles/.zprofile_conf/peco.profile

#-------------------------------------------------
# Git
#-------------------------------------------------
source ${HOME}/dotfiles/.zprofile_conf/git.profile

#-------------------------------------------------
# WEB (Dockerhub)
#-------------------------------------------------
function _open_my_dockerhub() {
    place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}"
    }
}
alias rrdh='_open_my_dockerhub';

function dockerhub-build() {
    place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}/builds"
    }
}

#-------------------------------------------------
# Docker
#-------------------------------------------------
if _is_exist docker; then
    if [ ! -d ~/dotfiles/docker-dd ]; then
        git clone https://github.com/nutsllc/docker-dd ${HOME}/dotfiles/docker-dd
    fi

    source ~/dotfiles/docker-dd/docker-dd-common.fnc
    source ~/dotfiles/docker-dd/docker-dd-network.fnc
    source ~/dotfiles/docker-dd/docker-dd-volume.fnc

    #export TOYBOX_HOME=/home/nobita/workspace/docker-toybox
    #export PATH=${TOYBOX_HOME}/bin:${PATH}
    #if [ -f ${TOYBOX_HOME}/bin/complition.sh ]; then
    #    source ${TOYBOX_HOME}/bin/complition.sh
    #fi
    echo "Load Docker settings."

    # for docker-compose.yml
    alias dd="docker-compose ${@}"
    alias ddup="docker-compose up ${@}"
    alias ddupd="docker-compose up -d ${@}"
    alias dddown="docker-compose down"
    alias ddrestart="docker-compose restart"
fi

#-------------------------------------------------
# Vagrant
#-------------------------------------------------
if _is_exist vagrant; then
    alias v='vagrant ssh'
    alias vu='vagrant up'
    alias vh='vagrant halt'
    alias vd='vagrant destroy'

    alias von='vagrant sandbox on'
    alias voff='vagrant sandbox off'
    alias vrb='vagrant sandbox rollback'
    alias vc='vagrant sandbox commit'

    alias vbl='vagrant box list'
    alias vs='vagrant status'

#    # enable completion for the vagrant
#    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
#        source `brew --prefix`/etc/bash_completion.d/vagrant
#    elif _is_exist brew; then
#        brew tap homebrew/completions
#        source `brew --prefix`/etc/bash_completion.d/vagrant
#    fi
    echo "Load Vagrant settings."
fi

#-------------------------------------------------
# PHP
#-------------------------------------------------
if _is_exist composer; then
    export PATH="${PATH}:${HOME}/.composer/vendor/bin"
fi

#-------------------------------------------------
# Laravel
#-------------------------------------------------
alias art='php artisan '
alias tinker='php artisan tinker'
alias pub='php artisan vendor:publish --force'
alias sv='php artisan serve'
alias rl='php artisan route:list'
alias t='vendor/bin/phpunit --colors'

#-------------------------------------------------
# dstat
#-------------------------------------------------
if _is_exist dstat; then
    alias dfull='dstat -Tclmdrn'
    alias dmem='dstat -Tclm'
    alias dcpu='dstat -Tclr'
    alias dnet='dstat -Tclnd'
    alias ddisk='dstat -Tcldr'
    alias dplugins='la /usr/share/dstat/*.py'
fi

#-------------------------------------------------
# SSH
#-------------------------------------------------
function sshx() {
	cat ~/.ssh/config | egrep "^Host " | awk '{print NR, $0}'
	echo -n "Number: "
	read no

	line=`cat ~/.ssh/config | egrep "^Host " | awk '{print NR, $0}' | egrep "${no}"`
	if [ ! -z "${line}" ]  ; then
		host=`echo ${line} | awk '{print $3}'`
		#sudo tee -a ssh ${host}
		ssh ${host}
	else
		echo "There is no number you inputed."
	fi
}

# --------------------------------------------
# others( beta )
# --------------------------------------------
# find extension
function findx(){
	find $1 -name "$2" | awk '{print NR, $0}'
	echo -n 'no?'
	read no

	line=`find $1 -name "$2" | awk '{print NR, $0}' | egrep "${no}"`
	if [ ! -z "${line}" ]  ; then
		path=`echo ${line} | awk '{print $2}' | sed -e s/$2//`
		echo $path
		cd $path
	else
		echo "There is no number you inputed."
	fi
}

# files/directories backup
function bk() {
    if [ $# -eq 0 ]; then
        echo 'no such file or directory.'
    else
        [ $# -ne 0 ] && [ -f ${1} ] && {
            cp -r ${1} ${1}.bk
            echo "backed up! (${1})"
        }
    fi
}

#-------------------------------------------------
# Functions for peco
#-------------------------------------------------
# http://qiita.com/uchiko/items/f6b1528d7362c9310da0

peco_history() {
    declare l=$(HISTTIMEFORMAT= history | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
    # for OSX
    if [ `uname` = "Darwin" ]; then
        ${READLINE_LINE}
    fi
    ${l}
}
alias his="peco_history"

#-------------------------------------------------
# others
#-------------------------------------------------
#export DDD_HOME=${HOME}/dev/src/github.com/nutsllc/docker-dd-compose
#export DDD_SEARCH_DIR=${HOME}/dev/src
#source ${DDD_HOME}/docker-dd-compose

if [ -f ${HOME}/dotfiles/peco/peco.conf ]; then
    source ${HOME}/dotfiles/peco/peco.conf
fi
