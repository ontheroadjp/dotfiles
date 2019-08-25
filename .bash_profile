if [ -f ~/.bashrc ] ; then
	. ~/.bashrc
fi

export EDITOR=vim
export TERM=xterm

alias dot='cd ${HOME}/dotfiles'

function _is_exist {
    type $@ > /dev/null 2>&1
}

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
    open "${search_dir}/${item}"
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

    # Cot Editor
    alias cot='open -a "/Applications/CotEditor.app"'

	# changing vi and vim to MacVim
	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias mvim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

    # alias(directory change:Mac)
	alias cdh='cdla ${HOME}'
	alias cdd='cdla ${HOME}/Desktop'
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
alias cdh='cdla ${HOME}'
alias c='clear && la'
alias cc='clear'
alias e='exit'
alias jj=$(:)

if [ -f ${HOME}/dotfiles/peco/peco ]; then
    export PATH=${PATH}:${HOME}/dotfiles/peco
fi

#-------------------------------------------------
# Changing directory(Common)
#-------------------------------------------------
alias la='ls -laG'

cdla() {
    if [ $# -eq 0 ]; then
        place=${HOME}
    else
        place=$@
    fi
	clear && pushd "${place}" && la
}
alias cd='cdla'

# back to the previous location
alias p='popd && la'

# -------------------------------- base
alias hh="cd ${HOME}"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# -------------------------------- return previous directory
function exdirs() {
    selected="$(dirs -v | peco)"
	if [ ! -z "${selected}" ]; then
		path=`echo ${selected} | awk '{print $2}' | sed -e s:^~:${HOME}:`
		cd ${path}
        pwd
	fi
}
alias d='exdirs'

#-------------------------------------------------
# Changing directory(Mark)
#-------------------------------------------------
dirmarks="$HOME/dotfiles/.dirmarks"
mkdir -p ${dirmarks}
function mm() {
    if [ $# -eq 0 ]; then
        pwd | tee ${dirmarks}/mm.txt
    elif [ $1 = "show" ]; then
        [ ! -f ${dirmarks}/mm.txt ] && {
            echo "not set." && return
        }
        cat ${dirmarks}/mm.txt
    fi
}
alias showmm='printf "mm: " && cat ${dirmarks}/mm.txt'

function m() {
    if [ -f ${dirmarks}/mm.txt ]; then
        cd $(cat ${dirmarks}/mm.txt)
    else
        echo "not set."
    fi
}
function nn() {
    if [ $# -eq 0 ]; then
        pwd | tee ${dirmarks}/nn.txt
    elif [ $1 = "show" ]; then
        [ ! -f ${dirmarks}/nn.txt ] && {
            echo "not set." && return
        }
        cat ${dirmarks}/nn.txt
    fi
}
alias shownn='printf "nn: " && cat ${dirmarks}/nn.txt'

function n() {
    if [ -f ${dirmarks}/nn.txt ]; then
        cd $(cat ${dirmarks}/nn.txt)
    else
        echo "not set."
    fi
}
function bb() {
    if [ $# -eq 0 ]; then
        pwd | tee ${dirmarks}/bb.txt
    elif [ $1 = "show" ]; then
        [ ! -f ${dirmarks}/bb.txt ] && {
            echo "not set." && return
        }
        cat ${dirmarks}/bb.txt
    fi
}
alias showbb='printf "bb: " && cat ${dirmarks}/bb.txt'
alias showbm='showmm && shownn && showbb'

function b() {
    if [ -f ${dirmarks}/bb.txt ]; then
        cd $(cat ${dirmarks}/bb.txt)
    else
        echo "not set."
    fi
}

#-------------------------------------------------
# Vim
#-------------------------------------------------
if _is_exist vim; then
    alias vp='vim ~/.bash_profile'
    alias sp='source ~/.bash_profile'
    alias vv='vim ~/.vimrc'
    alias v='vim'
    echo "Load vim settings."
fi

function open_javascript_file_with_vim() {
    [ ! -z "${1}" ] && {
        place="$(find . -type d -name node_modules -prune -o -type d -name vendor -prune -o -type f -name "*.${1}" | peco)"
        [ ! -z "${place}" ] && {
            vim ${place}
        }
    } || {
        echo 'need one argument must be file exension'
    }
}
alias ee='open_javascript_file_with_vim'

#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then
    alias gg='git graph'
    alias gs='git status'
    alias gd='git diff'
    alias gdni='git diff --no-index'
    alias ga='git_add_status'
    alias gr='git_reset_status'
    alias gcom='git commit -v'
    alias gb='git branch'
    alias gc='git checkout'
    alias gm='git merge --no-ff'

    function git_add_status() {
        git add "$@" && git status
    }

    function git_reset_status() {
        git reset "$@" && git status
    }

    # move project root dir of Git
    alias .g="cd $(git rev-parse --show-toplevel)"
    echo "Load Git settings."
fi

#-------------------------------------------------
# Git repository( my repository )
#-------------------------------------------------
function open_my_github() {
    place="$(cat ${HOME}/dotfiles/.bash_profile_git_repository_list.txt | peco | cut -f 2 -d ' ')"
    [ ! -z "${place}" ] && {
        open "https://github.com/${place}?tab=repositories"
    }
}
alias mygit='open_my_github';
alias editmygit='vim ${HOME}/dotfiles/.bash_profile_git_repository_list.txt'

#-------------------------------------------------
# Git repository( project )
#-------------------------------------------------
function cd_to_repository() {
    #place=$(ghq list -p | peco)
    place="$(ghq root)/$(ghq list | peco)"
    [ ! -z "${place}" ] && {
        cd ${place}
    }
}
alias rr='cd_to_repository'
alias prj='cd_to_repository'
alias rrr="cd ${HOME}/dev"

function open_github_for_current_dir() {
    if [ -d ".git" ]; then
        place="$(basename $(pwd))"
        vendor="$(basename $(pwd | xargs dirname))"
        open "https://github.com/${vendor}/${place}"
    else
        echo "This directory is not managed by Github."
    fi
}
alias opengit='open_github_for_current_dir';
alias og='open_github_for_current_dir';

function open_github_for_project() {
    place="$(ghq list | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}"
    }
}
alias rrgit='open_github_for_project';
alias prjgit='open_github_for_project';

function open_dockerhub() {
    place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}"
    }
}
alias rrdocker='open_dockerhub';
alias prjdocker='open_dockerhub';

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

    alias dd="docker-compose ${@}"
    alias ddu="docker-compose up"
    alias ddd="docker-compose down"
    alias dde="docker-compose exec ${@}"
    alias ddv="vim docker-compose.yml"
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
	echo -n "no?"
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
	prefix=bk_$(date +%Y%m%d)_
	if [ -f $@ ]; then
		cp "$@" ./${prefix}$@
		echo ${prefix}" has been backuped."
	else
		zip -vr ${prefix}$@.zip $@
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
    echo ${l}
}
alias his="peco_history"

#-------------------------------------------------
# others
#-------------------------------------------------
#export DDD_HOME=${HOME}/dev/src/github.com/nutsllc/docker-dd-compose
#export DDD_SEARCH_DIR=${HOME}/dev/src
#source ${DDD_HOME}/docker-dd-compose
