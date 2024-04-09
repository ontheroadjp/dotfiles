#-------------------------------------------------
# Variables
#-------------------------------------------------
#export LANG=ja_JP.UTF-8
export EDITOR=vim
export TERM=xterm
#export PATH=.:${DOTPATH}/bin:${PATH}
export PATH=${DOTPATH}/bin:${PATH}
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}
export PATH=${HOME}/.nodebrew/current/bin:${PATH}
export DOTPATH=${HOME}/dotfiles
autoload -Uz colors && colors   # use color

#-------------------------------------------------
# Functions
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }
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
alias init='exec $SHELL -l'
#alias jj=$(:)

#-------------------------------------------------
# Networking
#-------------------------------------------------
source ${DOTPATH}/.zsh.d/networking.zsh

#-------------------------------------------------
# For MacOSX only
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # variables
    export PATH="/usr/local/sbin:${PATH}"       # for Homebrew
    export PATH="/usr/local/share:${PATH}"      # for Python
    export PATH="${HOME}/dotfiles/mac_osx/HandBrakeCLI1.4.2/HandBrakeCLI:${PATH}"   # for HandBrakeCLI
    export WORKSPACE="${HOME}/WORKSPACE"
    export MEMO_PATH=${WORKSPACE}/Dropbox/Documents/NOTE/dev

    # Normal command replace
    alias tree='tree -N'    # for display Japanese char

    # cd
    alias d='cd ${HOME}/Desktop'
    alias doc='cd ${HOME}/Documents'
    alias dl='cd ${HOME}/Downloads'
    alias gd='cd ${WORKSPACE}/Google\ Drive'
    alias od='cd ${WORKSPACE}/OneDrive'
    alias db='cd ${WORKSPACE}/Dropbox'

    function _copy_current_dir_path() {
        echo -n $(pwd) | pbcopy && echo 'copy: '$(pbpaste)
    }
    alias ,='_copy_current_dir_path'

    # Editor
    alias cot="open -a /Applications/CotEditor.app" # CotEditor
    alias md="open -a /Applications/MarkText.app"     # Typora
    #alias md="open -a /Applications/Typora.app"     # Typora
    #alias md="open -a /Applications/MacDown.app"   # MacDown
    #alias md="open -a /Applications/Bear.app"      # Bear

    # Ruby
    #RBENV_ROOT="$HOME/.rbenv"
    #export PATH="${RBENV_ROOT}/bin:${PATH}"
    #eval "$(rbenv init -)"

    # ctag
    # changing the BSD version to the version installed by Homebrew
    alias ctags="`brew --prefix`/bin/ctags"

    # open finder
    function finder() { [ -z $1 ] && { open .  } || open $1 }

    # open terminal the same as current finder dir
    function _cd_to_finder_window_opened(){
    	target=$(osascript -e \
            'tell application "Finder" to if(count of Finder windows) > 0 then get POSIX path of(target of front Finder window as text)')
    	if [ "$target" != "" ]; then
    		cd "$target" && pwd
    	else
    		echo 'No Finder window found.' >&2
    	fi
    }
    alias terminal='_cd_to_finder_window_opened'

    # sleep
    alias sleepon='sudo pmset -a disablesleep 0'
    alias sleepoff='sudo pmset -a disablesleep 1'

#    # Cache
#    function _cacheclean() {
#        # Homebrew
#        if [ -d ${HOME}/Library/Caches/Homebrew ]; then
#            brew cleanup -s
#        fi
#    }

    ## display dot files on Finder
    #defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder
    #defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder

    # kill notifyd process
    function kill-notifyd-process() {
    	process=`ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}'`
    	sudo kill -9 ${process}
    }

    # show smtp(d) log
    alias smtplog='sudo log stream --predicater'\''(process == "smtpd") \
                            || (process == "smtp")'\'' --info'

    # MarsEdit
    function searchMarsEditImage() {
        imgDir=$(find "${HOME}/Library/Application Support/MarsEdit/UploadedFiles" -name ${1} -exec dirname {} \;)
        [ -e ${imgDir} ] && {
            finder ${imgDir}
        } || { echo "${1} does not exitst." }
    }
    alias marsimage='searchMarsEditImage $@'

#-------------------------------------------------
# For Linux only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Wellcome to Linux!'

#-------------------------------------------------
# For Windows (Cygwin) only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Wellcome to Cygwin!'

#-------------------------------------------------
# For other OS only
#-------------------------------------------------
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#-------------------------------------------------
# tmux
#-------------------------------------------------
source ${HOME}/dotfiles/.zsh.d/tmux.zsh

#-------------------------------------------------
# zsh
#-------------------------------------------------
# dilay default 0.4sec
KEYTIMEOUT=0

# complition
autoload -Uz compinit
compinit -u

# history
HISTFILE=${HOME}/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

#----------------------------------------------------------------
# Changing directory (Common)
#----------------------------------------------------------------
function _print_la() {
    [ $(uname) = 'Darwin' ] && {
        rm .DS_Store > /dev/null 2>&1
        ls -laGh $@
    } || {
        ls -laGh --color=auto $@
    }
}
alias la='_print_la'
alias lsd='ls -ad */'
alias lad='la -ad */'

function _cdla() {
    [ $# -eq 0 ] && place=${HOME} || place=$@
#	pushd ${place} && clear && _print_la
	pushd ${place} && _print_la
}
alias cd='_cdla'

# back to the previous location -----------------------------------
alias b='popd && clear && _print_la'

# general settings ------------------------------------------------
alias HOME="cd ${HOME}"
alias .="pwd"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
#alias .....="cd ../../../.."
#alias ......="cd ../../../../.."
#alias .......="cd ../../../../../.."
#alias ........="cd ../../../../../../.."
#alias .........="cd ../../../../../../../.."
#alias ..........="cd ../../../../../../../../.."
#alias ...........="cd ../../../../../../../../../.."

function mkdircd() {
    mkdir $@ && cd $_
}
alias mkcd='mkdircd'

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
# Load Core
#-------------------------------------------------
zsh-defer source ${DOTPATH}/.zsh.d/docker.zsh
zsh-defer source ${DOTPATH}/.zsh.d/git.zsh
zsh-defer source ${DOTPATH}/.zsh.d/peco.zsh
zsh-defer source ${DOTPATH}/.zsh.d/fzf.zsh
zsh-defer source ${DOTPATH}/.zsh.d/php.zsh
zsh-defer source ${DOTPATH}/.zsh.d/vagrant.zsh
zsh-defer source ${DOTPATH}/.zsh.d/shell-tools.zsh

#-------------------------------------------------
# Tools
#-------------------------------------------------
export RIPGREP_CONFIG_PATH="${DOTPATH}/.config/ripgrep/.ripgreprc"
alias exif="exiftool $@"

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
zsh-defer alias dammyimg='_create_dammy_image'

# show image size
function _display_image_size() { identify $@ }
alias imgsize="_display_image_size"

# memo
alias me="glow ${MEMO_PATH}"

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
