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

#-------------------------------------------------
# Variables
#-------------------------------------------------
export EDITOR=vim
export TERM=xterm
#export LANG=ja_JP.UTF-8
export DOTPATH=${HOME}/dotfiles
export PATH=.:${DOTPATH}/bin:${PATH}
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

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
    export PATH="/usr/local/sbin:${PATH}"       # for Homebrew
	export PATH="/usr/local/share:${PATH}"      # for Python
    export PATH="${HOME}/dotfiles/mac_osx/HandBrakeCLI1.4.2/HandBrakeCLI:${PATH}"   # for HandBrakeCLI
    export WORKSPACE="/Users/hideaki/WORKSPACE"

    # clipboard
    alias '.pb=. | ghead -c -1 | pbcopy'
    alias 'pb.=. | ghead -c -1 | pbcopy'

    # Normal command replace
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

    # markdown editor
    alias md="open -a /Applications/Typora.app"     # Typora
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

#    # Preview
#    alias preview='open -a Preview'
#
#	# Safari
#    alias safari='open -a "/Applications/Safari.app" "$(_urlencode $@)"'
#
#	# Chrome
#    # https://developers.google.com/web/updates/2017/04/headless-chrome
#	alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
#
#	# Spark
#	alias spark='open -a "/Applications/Spark.app" $@'
#	alias mailer='spark'
#
#    # Text Editor
#    alias cot='open -a "/Applications/CotEditor.app"'
#	alias subl='open -a "/Applications/Sublime Text.app"'
#	alias atom='open -a "/Applications/Atom.app"'
#    alias drafts='open -a "/Applications/Drafts.app"'
#
#    # Markdown Editor
#    alias typora='open -a "/Applications/Typora.app"'
#    alias macdown='open -a "/Applications/MacDown.app"'
#    alias bear='open -a "/Applications/Bear.app"'
#
#    # Typinator
#    alias typinator="open -a /Applications/Typinator.app"
#
#	# changing vi and vim to MacVim
#	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#	alias mvim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

    # alias(directory change:Mac)
	alias DESKTOP='cd ${HOME}/Desktop'
	alias DOCUMENTS='cd ${HOME}/Documents'
	alias DOWNLOADS='cd ${HOME}/Downloads'
    alias HOME='cd ~'
    alias WORKSPACE='cd ${WORKSPACE}'
    alias WS='cd ${WORKSPACE}'
	alias GOOGLEDRIVE='cd ${WORKSPACE}/Google\ Drive'
	alias ONEDRIVE='cd ${WORKSPACE}/OneDrive'
	alias DROPBOX='cd ${WORKSPACE}/Dropbox'

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
alias DOT='cd ${HOME}/dotfiles'
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
    ls -laGh $@
    current=$(pwd)
    items=$(ls -la $@ | wc -l | tr -d ' ') > /dev/null 2>&1
    #dirs=$(ls -ld */ | wc -l | tr -d ' ') > /dev/null 2>&1
    #print "${items} items: dir ${dirs} items"
}
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

#-------------------------------------------------
# find count
#-------------------------------------------------
function _find_count() {
    [ -z $3 ] && {
        find $1 -type $2 -maxdepth 1 | grep -v "^\.$" | sort
        local count=$(find $1 -type $2 -maxdepth 1 | \
            grep -v "^\.$" | wc -l | tr -d ' ')
    } || {
        find -E $1 -type $2 -regex "^.*\.${3}$" | grep -v "^.$" | sort
        local count=$(find -E $1 -type $2 -regex "^.*\.${3}$" | wc -l)
    }

    echo "------------------"
    [ ${count} -gt 1 ] && {
        [ $2 = f ] && { label="files" } || { label="directories" }
    } || {
        [ $2 = f ] && { label="file" } || { label="directory" }
    }
    echo "${count} ${label}."
}

alias ff='(){_find_count ${1:-.} f}'
alias fd='(){_find_count ${1:-.} d}'
alias fimg='(){_find_count ${1:-.} f "(JPG|jpg|jpeg|PNG|png|TIFF|TIF|tiff|tif|CR2|NEF|ARW)"}'
alias fmov='(){_find_count ${1:-.} f "(MOV|mov|AVI|avi|MPG|mpg|mpeg|mp4)"}'
alias fmus='(){_find_count ${1:-.} f "(mp3)"}'

#-------------------------------------------------
# AG (grep)
#-------------------------------------------------
if _is_exist ag; then
    alias ag='ag -S --stats --pager "less -F"'
    alias agh='ag --hidden'
fi

#-------------------------------------------------
# Directory mark and jump
#-------------------------------------------------
#dirmarks="${HOME}/dotfiles/.dirmarks"
#mkdir -p ${dirmarks}
#
#function _mark_to_directory() {
#    [ $# -eq 1 ] && pwd > ${dirmarks}/${1}${1}; echo 'markd!'
#}
#
#function _jump_to_directory() {
#    [ $# -eq 1 ] && [ -f ${dirmarks}/${1}${1} ] && {
#        cd $(cat ${dirmarks}/${1}${1})
#    } || echo "not set."
#}
#
#alias mm='_mark_to_directory m'
#alias nn='_mark_to_directory n'
#alias ii='_mark_to_directory i'
#alias oo='_mark_to_directory o'
#
#alias m='_jump_to_directory m'
#alias n='_jump_to_directory n'
#alias i='_jump_to_directory i'
#alias o='_jump_to_directory o'
#
##-------------------------------------------------
## note
##-------------------------------------------------
#function _quick_memo() {
#    if ! _is_exist gsed; then
#        echo "error: you need to install gsed(gnu-sed)"
#        echo "install: brew install gnu-sed"
#        return
#    fi
#
#    local quick_memo_dir="${WORKSPACE}/Dropbox/Documents/QuickMemo"
#    #header="## =====> $(date '+%Y%m%d %H:%M:%S') <=====\n\n"
#    header="## =====> $(date) <=====\n\n"
#    gsed -i -e "1s/^/${header}/" ${quick_memo_dir}/quick_memo.md
#    vim ${quick_memo_dir}/quick_memo.md
#}
#alias qm="_quick_memo"
#
#function _send_mail_quick_memo() {
#    local subject="Quick Memo ($(date))"
#    local to='hishihara1975@gmail.com'
#    cat ${WORKSPACE}/Dropbox/note/INBOX/note.md \
#        | mail -s ${subject} ${to}
#    echo "mail (quick memo) sent!"
#}
#alias qmail='_send_mail_quick_memo'

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
# Go
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
# vim
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
# usage: $ee md, $ee README etc.

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

# show IP Address
alias ip='ipconfig getifaddr en0'
#alias ip='ipconfig getifaddr en1'

# show sub directory size
function _display_directory_size() {
    du -sh ${1:-"$(pwd)"}/* 2>&1 | grep -v "Operation not permitted" | sort -hr
}
alias dirsize="_display_directory_size"

# show image size
function _display_image_size() {
    identify $@
}
alias imgsize="_display_image_size"

# --------------------------------------------
# Mini Applications
# --------------------------------------------
SHELL_TOOLS_DIR="${HOME}/WORKSPACE/shell-tools"
#export PATH=${SHELL_TOOLS_DIR}/dirmarks:${PATH}
#source ${SHELL_TOOLS_DIR}/dirmarks/dirmarks
#alias mm='_dirmarks mark m'
#alias nn='_dirmarks mark n'
#alias ii='_dirmarks mark i'
#alias oo='_dirmarks mark o'
#alias m='_dirmarks jump m'
#alias n='_dirmarks jump n'
#alias i='_dirmarks jump i'
#alias o='_dirmarks jump o'

export PATH=${SHELL_TOOLS_DIR}/ShellStash:${PATH}
export PATH=${SHELL_TOOLS_DIR}/Backup:${PATH}
export PATH=${SHELL_TOOLS_DIR}/QuickMemo:${PATH}

export PATH=${SHELL_TOOLS_DIR}/Colors:${PATH}
export PATH=${SHELL_TOOLS_DIR}/WifiCheck:${PATH}

export PATH=${SHELL_TOOLS_DIR}/Wareki:${PATH}
export PATH=${SHELL_TOOLS_DIR}/HolidayJP:${PATH}
export PATH=${SHELL_TOOLS_DIR}/WorldTime:${PATH}
alias now='worldtime'
