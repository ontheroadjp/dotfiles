#-------------------------------------------------
# Variables
#-------------------------------------------------
export EDITOR=vim
export TERM=xterm
#export LANG=ja_JP.UTF-8
autoload -Uz colors && colors   # use color

export DOTPATH=${HOME}/dotfiles
export PATH=.:${DOTPATH}/bin:${PATH}

#-------------------------------------------------
# Functions
#-------------------------------------------------
function _is_exist() {
    type $@ > /dev/null 2>&1
}

#-------------------------------------------------
# My tools
#-------------------------------------------------
export PATH=${HOME}/dev/src/github.com/ontheroadjp/dazai:${PATH}
export PATH=${HOME}/dev/src/github.com/ontheroadjp/tidyphoto/bin:${PATH}

#-------------------------------------------------
# For MacOSX only
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    #echo "MacOSX with ..."

    # variables
    export PATH="/usr/local/sbin:${PATH}"   # for Homebrew
	export PATH="/usr/local/share:$PATH"    # for Python
    export WORKSPACE="/Users/hideaki/WORKSPACE"
    export WEB_BROWSER="/Applications/Safari.app"
    #export WEB_BROWSER="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    #export MARKDOWN_EDITOR="/Applications/MacDown.app"  # MacDown
    export MARKDOWN_EDITOR="/Applications/Typora.app"   # Typora
    #export MARKDOWN_EDITOR="/Applications/Bear.app"     # Bear

    # Normal command
    alias tree='tree -N'    # for display Japanese char

    # remove .DS_Store file
    alias rmds='find . -type f -name .DS_Store -print0 | xargs -0 rm'
    alias c='rmds && clear'

#    function _cacheclean() {
#        # Homebrew
#        if [ -d ${HOME}/Library/Caches/Homebrew ]; then
#            brew cleanup -s
#        fi
#    }

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
#		else
			echo 'No Finder window found.' >&2
		fi
	}
    alias terminal='_cd_to_finder_window_opened'

    # Preview
    alias preview='open -a Preview'

	# Safari
	alias safari='open -a "/Applications/Safari.app" $@'

	# Chrome
    # https://developers.google.com/web/updates/2017/04/headless-chrome
	alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

	# Spark
	alias spark='open -a "/Applications/Spark.app" $@'
	alias mailer='spark'

	# Sublime Text 3

    # Text Editor
    alias cot='open -a "/Applications/CotEditor.app"'
	alias subl='open -a "/Applications/Sublime Text.app"'
	alias atom='open -a "/Applications/Atom.app"'
    alias drafts='open -a "/Applications/Drafts.app"'

    # Markdown Editor
    alias typora='open -a "/Applications/Typora.app"'
    alias macdown='open -a "/Applications/MacDown.app"'
    alias bear='open -a "/Applications/Bear.app"'
    alias md="open -a ${MARKDOWN_EDITOR}"

    # Typinator
    alias typinator="open -a /Applications/Typinator.app"

	# changing vi and vim to MacVim
	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias mvim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

    # alias(directory change:Mac)
	alias Desktop='cd ${HOME}/Desktop'
	alias Documents='cd ${HOME}/Documents'
	alias Downloads='cd ${HOME}/Downloads'
    alias WORKSPACE='cd ${WORKSPACE}'
	alias GoogleDrive='cd ${WORKSPACE}/Google\ Drive'
	alias OneDrive='cd ${WORKSPACE}/OneDrive'
	alias Dropbox='cd ${WORKSPACE}/Dropbox'

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
# OS common settings
#-------------------------------------------------
alias c='clear'
alias e='exit'
alias dot='cd ${HOME}/dotfiles'
#alias jj=$(:)

#-------------------------------------------------
# History
#-------------------------------------------------

# history
HISTFILE=${HOME}/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

#-------------------------------------------------
# Changing directory(Common)
#-------------------------------------------------
function _print_la() {
    ls -laG $@
#    if [ $# -ne 0 ]; then
#        if [ ${1:0:1} == '/' ]; then
#            printf "\e[31m$1\e[m\n"
#        else
#            printf "\e[31m$(pwd)/$1\e[m\n"
#        fi
#    fi

    current=$(pwd)
    items=$(ls -la $@ | wc -l | tr -d ' ') > /dev/null 2>&1
    #dirs=$(ls -ld */ | wc -l | tr -d ' ') > /dev/null 2>&1
    #print "${items} items: dir ${dirs} items"
    print "${items} items"
}
#alias la='ls -laG'
alias la='_print_la'
alias lad='la -d */'

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
# find
#-------------------------------------------------
alias ff="find . -type f"
alias fd="find . -type d"
IMAGE_EXTENTION="(JPG|jpg|jpeg|PNG|png|TIFF|TIF|tiff|tif|CR2|NEF|ARW|MOV|mov|AVI|avi)"
alias ffi='find -E . -type f -regex "^.*\.${IMAGE_EXTENTION}$"'

alias ffc='ff | wc -l'
alias fdc="fd | wc -l"
alias ffic='ffi | wc -l'

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
# note
#-------------------------------------------------
function _quick_memo() {
    if ! _is_exist gsed; then
        echo "error: you need to install gsed(gnu-sed)"
        echo "install: brew install gnu-sed"
        return
    fi

    local quick_memo_dir="${WORKSPACE}/Dropbox/Documents/memo"
    #header="## =====> $(date '+%Y%m%d %H:%M:%S') <=====\n\n"
    header="## =====> $(date) <=====\n\n"
    gsed -i -e "1s/^/${header}/" ${quick_memo_dir}/quick_memo.md
    vim ${quick_memo_dir}/quick_memo.md
}
alias qmemo="_quick_memo"
alias q="_quick_memo"

function _send_mail_quick_memo() {
    local subject="Quick Memo ($(date))"
    local to='hishihara1975@gmail.com'
    cat ${WORKSPACE}/Dropbox/note/INBOX/note.md \
        | mail -s ${subject} ${to}
    echo "mail (quick memo) sent!"
}
alias qmail='_send_mail_quick_memo'

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
if _is_exist peco; then
    source ${DOTPATH}/.zprofile_conf/peco.profile
fi

#-------------------------------------------------
# Git
#-------------------------------------------------
if _is_exist git; then
    source ${DOTPATH}/.zprofile_conf/git.profile
fi

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
# exiftool
#-------------------------------------------------
if _is_exist exiftool; then
    alias exif="exiftool $@"
fi

#-------------------------------------------------
# WEB (Dockerhub)
#-------------------------------------------------
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

#-------------------------------------------------
# Docker
#-------------------------------------------------
if _is_exist docker; then
#    if [ ! -d ~/dotfiles/docker-dd ]; then
#        git clone https://github.com/nutsllc/docker-dd ${HOME}/dotfiles/docker-dd
#    fi

    [ -e ~/dotfiles/docker-dd ] && {
        source ~/dotfiles/docker-dd/docker-dd-common.fnc
        source ~/dotfiles/docker-dd/docker-dd-network.fnc
        source ~/dotfiles/docker-dd/docker-dd-volume.fnc
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
# show sub directory size
function _display_directory_size() {
    du -sh ${1:-$(pwd)}/* 2>&1 | grep -v "Operation not permitted" | sort -hr
}
alias dirsize="_display_directory_size"

# --------------------------------------------
# show wareki and century
# --------------------------------------------
source ${DOTPATH}/bin/wareki/wareki.fnc

# --------------------------------------------
# show wareki and century
# --------------------------------------------
function _honyaku() {
    safari "https://translate.google.co.jp/?hl=ja#view=home&op=translate&sl=auto&tl=en&text=${1}"
}
alias honyaku='_honyaku "$@"'

# --------------------------------------------
# make backup files/directories
# --------------------------------------------
function _create_backup() {
    [ $# -ne 1 ] && echo 'no file/dir' && return
    [ ! -e $(basename $1) ] && echo 'no file/dir' && return
    #cp -r ${1} ${1}.bk
    tar czf $(basename $1).tar.gz $1
    echo "backed up! ($1)"
}
alias bk="_create_backup"

function _restore_backup() {
    local strip=$(echo $1 | sed -e 's/\.tar\.gz$//g')

    [ $# -ne 1 ] && echo 'no file/dir' && return
    [ ! -e $1 ] && [ ! -e ${strip}.tar.gz ] && echo 'no file/dir' && return

    local target=$(echo $1 | sed 's/\.tar\.gz//g')
    tar xzf ${strip}.tar.gz
    echo "Restored! (${strip}.tar.gz)"
}
alias restore="_restore_backup"
alias re="_restore_backup"

# --------------------------------------------
# Google WEB Search
# --------------------------------------------
function _google_web_search() {
    local url="https://www.google.com/search?q=$@"
    open -a "/Applications/Safari.app" ${url}
}
alias google="_google_web_search"
alias g="_google_web_search"

#-------------------------------------------------
# others
#-------------------------------------------------
#export DDD_HOME=${HOME}/dev/src/github.com/nutsllc/docker-dd-compose
#export DDD_SEARCH_DIR=${HOME}/dev/src
#source ${DDD_HOME}/docker-dd-compose


