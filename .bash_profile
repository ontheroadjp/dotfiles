if [ -f ~/.bashrc ] ; then
	. ~/.bashrc
fi

export EDITOR=vim
export TERM=xterm

#-------------------------------------------------
# utilities
#-------------------------------------------------

function _is_exist() {
    type $@ > /dev/null 2>&1
}

#-------------------------------------------------
# dotfiles
#-------------------------------------------------
alias dot='cd ${HOME}/dotfiles'
alias sp='source ~/.bash_profile'

if _is_exist vim; then
    alias vp='vim ~/.bash_profile'
    alias vv='vim ~/.vimrc'
    alias v='vim'
    echo "Load vim settings."
fi

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
if [ "$(uname)" == 'Darwin' ]; then

    # remove .DS_Store file
    alias dsrm='find . -name .DS_Store | xargs rm'

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
			echo 'No Finder window found' >&2
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
	alias cdh='cdla ${HOME}'
	#alias cdd='cdla ${HOME}/Desktop'
	alias cddoc='cdla ${HOME}/Documents'
	alias cddl='cdla ${HOME}/Downloads'

	alias cdgd='cdla ${HOME}/Google\ Drive'
	alias cdod='cdla ${HOME}/OneDrive'
	alias cddb='cdla ${HOME}/Dropbox'

	alias cdmemo='cdla ${HOME}/Dropbox/アプリ/PlainText\ 2/INBOX'
	alias cdv='cdla ${HOME}/Vagrant'

	# alias（for ctag）
	# changing the BSD version to the version installed by Homebrew
	alias ctags="`brew --prefix`/bin/ctags"

	# MacPorts Installer addition on 2015-10-09_at_13:13:23: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.

    # Python
	export PATH="/usr/local/share:$PATH"

	#tmux a -d

#if [ -z $TMUX ]; then
#	if $(tmux has-session); then
#		tmux attach
#	else
#		tmux
#	fi
#fi

	#-------------------------------------------------
	# tmux settings
	# see：http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
	# see：https://github.com/b4b4r07/dotfiles
	#-------------------------------------------------

    alias lat='tmux ls'

	function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
	function is_osx() { [[ $OSTYPE == darwin* ]]; }
	function is_screen_running() { [ ! -z "$STY" ]; }
	function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
	function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
	function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
	function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

	function tmux_automatically_attach_session()
	{
		if is_screen_or_tmux_running; then
			! is_exists 'tmux' && return 1

			if is_tmux_runnning; then
				echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
				echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
				echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
				echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
				echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
			elif is_screen_running; then
				echo "This is on screen."
			fi
		else
			if shell_has_started_interactively && ! is_ssh_running; then
				if ! is_exists 'tmux'; then
					echo 'Error: tmux command not found' 2>&1
					return 1
				fi

				if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
					# detached session exists
					tmux list-sessions
					echo -n "Tmux: attach? (y/N/num) "
					read
					if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
						tmux attach-session
						if [ $? -eq 0 ]; then
							echo "$(tmux -V) attached session"
							return 0
						fi
					elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
						tmux attach -t "$REPLY"
						if [ $? -eq 0 ]; then
							echo "$(tmux -V) attached session"
							return 0
						fi
					fi
				fi

				if is_osx && is_exists 'reattach-to-user-namespace'; then
					# on OS X force tmux's default command
					# to spawn a shell in the user's namespace
					#tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
					tmux -f < $(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
				else
					tmux new-session && echo "tmux created new session"
				fi
			fi
		fi
	}
	tmux_automatically_attach_session

	#---------------- end of tmux ------------------

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
# OS common settings
#-------------------------------------------------
alias c='clear && la'
alias e='exit'
#alias jj=$(:)

if [ -f ${HOME}/dotfiles/peco/peco ]; then
    export PATH=${PATH}:${HOME}/dotfiles/peco
fi

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

# show sub directories
alias lla='la $(find . -type d | grep -v .git | peco)'
alias laa='la $(find . -type d | grep -v .git | peco)'

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

# -------------------------------- peco - cd to sub directory
function _cd_to_sub_directory() {
    [[ $(ls -F | wc -l) -eq 0 ]] && {
        echo 'no sub directory.'
        return 0
    }
    to=$(find . -type d | grep -v ^.$ | grep -v .git | sort | uniq | peco --prompt "to SUB DIR.>" --query "${*}" 2>/dev/null)
    [ ! -z ${to} ] && cd ${to}
}
alias cdd='_cd_to_sub_directory'

# -------------------------------- peco - cd by history
function _cd_by_dirspeco() {
    [ is_exists peco -ne 0 ] && {
        echo "peco is not installed."
        return 1
    }

    to="$(dirs -v | awk '{print $2}' | sort | uniq | peco --prompt "cd to >" | sed -e s:^~:${HOME}:)"
    [[ ! -z ${to} ]] && cd ${to}
    echo ${to}
}
alias hh='_cd_by_dirspeco'

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

function _markspeco() {
    [ $(ls -U ${dirmarks} | wc -l) -ne 0 ] && {
        to=$(for x in ${dirmarks}/*; do cat ${x}; done | sort | uniq | peco --prompt "cd to >" )
    }
    [ ! -z ${to} ] && cd ${to}
}
alias jj='_markspeco'

#-------------------------------------------------
# Vim
#-------------------------------------------------
function _open_javascript_file_with_vim() {
    [ ! -z "${1}" ] && {
        place="$(find . -type d -name node_modules -prune -o -type d -name vendor -prune -o -type f -name "*.${1}" | peco)"
        [ ! -z "${place}" ] && {
            vim ${place}
        }
    } || {
        echo 'need one argument must be file exension'
    }
}
alias ee='_open_javascript_file_with_vim'

#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then
    alias gg='git graph'
    alias ggs='git graph --stat'
    alias gs='git status'
    alias gd='git diff'
    alias gdni='git diff --no-index'
    alias gcom='git commit -v'
    alias gb='git branch'
    alias gc='git checkout'
    alias gm='git merge --no-ff'
    alias gbk='git commit -m "[BK] wip"'
    alias wip='git commit -m "[BK] wip"'

    function git_add_status() {
        git add "$@" && git status
    }
    alias ga='git_add_status'

#    function _git_reset_status() {
#        git reset "$@" && git status
#    }
#    alias gr='_git_reset_status'

    function _cd_to_repository_root() {
        now=$(pwd)
        while [ ! -d $(pwd)/.git ]; do
            if [ $(pwd) = / ]; then
                cd ${now}
                echo 'This directory is not managed by git.'
                break 1
            else
                cd ..
            fi
        done
    }
    alias ggg="_cd_to_repository_root"
    #alias ggg=$(git rev-parse --show-toplevel)

# not working
#    function _pecorin() {
#        peco --prompt="${2}" --query="${3}" ${1} 2>/dev/null
#    }

    function _cd_to_repository_managed_by_ghq() {
        to=$(ghq list | peco --prompt "Git Repository>" --query "${*}" 2>/dev/null)
        [ ! -z ${to} ] && cd $(ghq root)/${to}
    }
    if _is_exist ghq; then
        alias rr='_cd_to_repository_managed_by_ghq'
    fi

    function _open_github_repository_managed_by_ghq() {
        place="$(ghq list | peco)"
        [ ! -z ${place} ] && {
            open "https://${place}"
        }
    }
    if _is_exist ghq; then
        alias rrgit='_open_github_repository_managed_by_ghq';
    fi

    function _open_github_for_current_dir() {
        now=$(pwd)
        _cd_to_repository_root && {
            place="$(basename $(pwd))"
            vendor="$(basename $(pwd | xargs dirname))"
            open "https://github.com/${vendor}/${place}"
            cd ${now}
        }
    }
    alias github='_open_github_for_current_dir';

    echo "Load Git settings."
fi

#-------------------------------------------------
# WEB (Github)
#-------------------------------------------------
function _open_my_repository_on_github() {
    place="$(cat ${HOME}/dotfiles/.bash_profile_git_repository_list.txt | peco | cut -f 2 -d ' ')"
    [ ! -z "${place}" ] && {
        open "https://github.com/${place}?tab=repositories"
    }
}
alias myrepo='_open_my_repository_on_github';
alias editmyrepo='vim ${HOME}/dotfiles/.bash_profile_git_repository_list.txt'

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
# Go
#-------------------------------------------------
if _is_exist go; then
    export GOPATH="${HOME}/dev"
    #export GOBIN="${GOPATH}/bin"
    export PATH="${PATH}:${GOPATH}/bin"
    mkdir -p ${GOPATH}
fi

#-------------------------------------------------
# Peco
#-------------------------------------------------
if ! _is_exist peco; then
    tar xvzf src/peco_linux_amd64.tar.gz -C ${HOME}/dotfiles/src
    sudo cp ${HOME}/dotfiles/src/peco_linux_amd64/peco /usr/bin
fi

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

    function _docker_build() {
        docker build -t ${1} .
    }
    alias db="_docker_build"

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

    # enable completion for the vagrant
    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
        source `brew --prefix`/etc/bash_completion.d/vagrant
    elif _is_exist brew; then
        brew tap homebrew/completions
        source `brew --prefix`/etc/bash_completion.d/vagrant
    fi
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
