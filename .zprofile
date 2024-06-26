#-------------------------------------------------
# Variables
#-------------------------------------------------
export EDITOR=vim
export TERM=xterm
export DOTPATH=${HOME}/dotfiles
export WORKSPACE="${HOME}/WORKSPACE"
# export PATH=${DOTPATH}/bin:${PATH}
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
# OS common settings
#-------------------------------------------------
alias c='clear'
alias e='exit'
alias h='cd ${HOME}'
alias dot='cd ${DOTPATH}'
alias w='cd ${WORKSPACE}'
alias init='exec $SHELL -l'

#-------------------------------------------------
# For MacOSX only
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    # variables
    # export PATH="/usr/local/sbin:${PATH}"       # for Homebrew
    # export PATH="/usr/local/share:${PATH}"      # for Python
    # export PATH="${HOME}/dotfiles/mac_osx/HandBrakeCLI1.4.2/HandBrakeCLI:${PATH}"   # for HandBrakeCLI
    export MEMO_PATH=${WORKSPACE}/Dropbox/Documents/NOTE/dev

    # Normal command replace
    alias tree='tree -N'    # for display Japanese char

    # Editor
    alias cot="open -a /Applications/CotEditor.app" # CotEditor
    alias md="open -a /Applications/MarkText.app"     # Typora

    # ctag
    # changing the BSD version to the version installed by Homebrew
    alias ctags="$(brew --prefix)/bin/ctags"

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

    # kill notifyd process
    function kill-notifyd-process() {
    	process=$(ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}')
    	sudo kill -9 ${process}
    }

    # show smtp(d) log
    alias smtplog='sudo log stream --predicater'\''(process == "smtpd") \
                            || (process == "smtp")'\'' --info'

#-------------------------------------------------
# For Linux only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
	echo 'Wellcome to Linux!'

#-------------------------------------------------
# For Windows (Cygwin) only
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
	echo 'Wellcome to Cygwin!'

#-------------------------------------------------
# For other OS only
#-------------------------------------------------
else
	echo "Wellcome to $(uname -a) !"
fi

#-------------------------------------------------
# zsh
#-------------------------------------------------
# dilay default 0.4sec
KEYTIMEOUT=0

# complition
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

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
    #export GOBIN="${GOPATH}/bin"
    # export PATH="${PATH}:${GOPATH}/bin"
    mkdir -p ${GOPATH}
fi

#-------------------------------------------------
# Load Core
#-------------------------------------------------
source ${HOME}/dotfiles/.zsh.d/core/tmux.zsh
zsh-defer source ${DOTPATH}/.zsh.d/core/cdla.zsh
zsh-defer source ${DOTPATH}/.zsh.d/core/docker.zsh
zsh-defer source ${DOTPATH}/.zsh.d/core/git.zsh
zsh-defer source ${DOTPATH}/.zsh.d/core/peco.zsh
zsh-defer source ${DOTPATH}/.zsh.d/core/fzf.zsh

#-------------------------------------------------
# Load Dev
#-------------------------------------------------
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}
# zsh-defer source ${DOTPATH}/.zsh.d/dev/php.zsh
# zsh-defer source ${DOTPATH}/.zsh.d/dev/ruby.zsh
# zsh-defer source ${DOTPATH}/.zsh.d/dev/vagrant.zsh
zsh-defer source ${DOTPATH}/.zsh.d/dev/python.zsh

#-------------------------------------------------
# Load others
#-------------------------------------------------
zsh-defer source ${DOTPATH}/.zsh.d/networking.zsh
# zsh-defer source ${DOTPATH}/.zsh.d/shell-tools.zsh
zsh-defer source ${DOTPATH}/tools/shell-tools/shell-tools.sh

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
alias dammyimg='_create_dammy_image'

# show image size
function _display_image_size() { identify $@ }
alias imgsize="_display_image_size"

# memo
alias me="glow ${MEMO_PATH}"

echo 'Load .zprofile.'

