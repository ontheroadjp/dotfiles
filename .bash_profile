
if [ -f ~/.bashrc ] ; then
	. ~/.bashrc
fi

export EDITOR=vim

#-------------------------------------------------
# Mac 固有の設定
#-------------------------------------------------
if [ "$(uname)" == 'Darwin' ]; then 

    # 環境変数
	export PATH="/usr/local/bin:$PATH"

    # Ruby
    #RBENV_ROOT="$HOME/.rbenv"
    #export PATH="$RBENV_ROOT/bin:$PATH"
    #eval "$(rbenv init -)"

    # vagrant コマンド補完の有効化
    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
        source `brew --prefix`/etc/bash_completion.d/vagrant
    elif hash "brew"; then
        brew tap homebrew/completions
        source `brew --prefix`/etc/bash_completion.d/vagrant
    fi

	# 現在のディレクトリをファインダーで開く
	alias finder='open .'
 
	# 現在のファインダーをTerminal.appで開く
	terminal(){
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
	alias chrome='open -a "/Applications/Google Chrome.app"' 
	
	# Sublime Text 3
	alias sub='open -a "/Applications/Sublime Text.app"'
	
	# Markdown Editor
	alias md='open -a "/Applications/MacDown.app"'
	
    # Cot Editor
    alias cot='open -a "/Applications/CotEditor.app"'

	# vi, vim をMacVim へ変更
	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	alias mvim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	
	# エイリアス（移動:Mac）
	alias cdh='cdla ${HOME}'
	alias cdd='cdla ${HOME}/Desktop'
	alias cddoc='cdla ${HOME}/Documents'
	alias cddl='cdla ${HOME}/Downloads'
	
	alias cdgd='cdla ${HOME}/Google\ Drive'
	alias cdod='cdla ${HOME}/OneDrive'
	alias cddb='cdla ${HOME}/Dropbox'
	
	alias cdmemo='cdla ${HOME}/Dropbox/アプリ/PlainText\ 2/INBOX'
	alias cdv='cdla ${HOME}/Vagrant'

	# エイリアス（for ctag）
	# 標準の BSD版から brew でインストールした ctag を使う
	alias ctags="`brew --prefix`/bin/ctags"

	# MacPorts Installer addition on 2015-10-09_at_13:13:23: adding an appropriate PATH variable for use with MacPorts.
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
	# Finished adapting your PATH environment variable for use with MacPorts.

	#-------------------------------------------------
	# tmux の設定
	# 参考：http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
	# 参考：https://github.com/b4b4r07/dotfiles
	#-------------------------------------------------

	tmux a -d

#if [ -z $TMUX ]; then
#	if $(tmux has-session); then
#		tmux attach
#	else
#		tmux
#	fi
#fi
						  
	#-------------------------------------------------
	# tmux の設定
	# 参考：http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
	# 参考：https://github.com/b4b4r07/dotfiles
	#-------------------------------------------------

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
	
	# notifyd プロセス削除
	function kill-notifyd-process() {
		process=`ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}'`
		sudo kill -9 ${process}
	}

	#-------------------------------------------------
	# Projects
	#-------------------------------------------------

	export PROJECT_ROOT=${HOME}/Desktop/test/
	alias cdp='cdla ${PROJECT_ROOT}NutsPages/'
	alias cdv='cdla ${PROJECT_ROOT}NutsPages/vendor/ontheroadjp/'

	#-------------------------------------------------
	# Laravel
	#-------------------------------------------------

	alias pub='php artisan vendor:publish --force'
	alias sv='php artisan serve'
	alias rl='php artisan route:list'
	alias t='vendor/bin/phpunit --colors'
	
	#-------------------------------------------------
	# WordPress  
	#-------------------------------------------------

	#echo "Where is the WordPress root directory?"
	#read wproot

	#echo "Where is the theme directory name?"
	#read themedir

	#基本設定
	#export WPROOT=${wproot}
	#export WPTHEME=${WPROOT}/wp-content/${themedir}/channel
	#export WPPLUGIN=${WPROOT}/wp-content/plugins
	
	#エイリアス（移動用）
	#alias wpr='cdla $WPROOT'
	#alias wpt='cdla $WPTHEME'
	#alias wpp='cdla $WPPLUGIN'
	

#-------------------------------------------------
# Linux 固有の設定
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Wellcome to Linux!'	

#-------------------------------------------------
# Windows(Cygwin) 固有の設定
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Wellcome to Cygwin!'
else
#-------------------------------------------------
# その他 OS
#-------------------------------------------------
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#-------------------------------------------------
# 共通設定
#-------------------------------------------------

alias c='clear'
alias e='exit'

#-------------------------------------------------
# エイリアス: for vim
#-------------------------------------------------
alias vp='vim ~/.bash_profile'
alias sp='source ~/.bash_profile'
alias vv='vim ~/.vimrc'
alias v='vim'

#-------------------------------------------------
# エイリアス: 移動用
#-------------------------------------------------
alias la='ls -laG'
alias laa='la | peco'

# cd した後に la する
cdla() {
	pushd "$@" && la
}
alias cd='cdla'

# d でひとつ前の場所へ
alias p='popd && la'

#-------------------------------------------------
# エイリアス: for Git
#-------------------------------------------------
alias gg='git graph'
alias gs='git status'
alias gd='git diff'
alias gdni='git diff --no-index'
alias ga='git_add_status'
alias gr='git_reset_status'
alias gcom='git commit -v'
alias gb='git branch'
alias gcheck='git checkout'

function git_add_status() {
    git add "$@" && git status
}

function git_reset_status() {
    git reset "$@" && git status
}

# Git プロジェクトルートへ移動 
alias gitop='cd `git rev-parse --show-toplevel`'

#-------------------------------------------------
# エイリアス: for Vagrant
#-------------------------------------------------
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

#-------------------------------------------------
# エイリアス: for Vagrant
#-------------------------------------------------
#alias d='docker'
#alias dps='docker ps '
#alias D='docker ps | tail -n +2'
#alias Da='docker ps -a | tail -n +2'
#alias Di='docker images | tail -n +2'
#alias dimages='docker images'
#alias dstart='docker start '
#alias dstop='docker stop '
alias dattach='docker attach '
#alias drm='docker rm '
#alias drmi='docker rmi '
#alias drmstop="docker $(docker ps -a -q)"

#alias dcid='docker ps -q'
#alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(docker ps -q)"

#-------------------------------------------------
# Functions
#-------------------------------------------------

function mm() {
    pwd > $HOME/dotfiles/mm.txt
}

function m() {
    cd $(cat $HOME/dotfiles/mm.txt)
}

# dirs 拡張
function exdirs() {
	dirs -v | awk '!colname[$2]++{print $1,": ",$2,"(",$1,")"}'
	echo -n "no?"
	read no
	
	line=`dirs -v | awk '!colname[$2]++{print $0}' |  egrep "^ *${no}  "`
	if [ ! -z "${line}" ]  ; then 
		path=`echo ${line} | awk '{print $2}' | sed -e s:^~:${HOME}:`
		cd ${path}
	else
		echo "There is no number you input."
	fi
}
alias d='exdirs'

# SSH 拡張
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

# find 拡張
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

#ファイルのバックアップ
function bk() {
	prefix=bk_$(date +%Y%m%d)_
	if [ -f $@ ]; then
		cp "$@" ./${prefix}$@
		echo ${prefix}" has been backuped."
	else
		zip -vr ${prefix}$@.zip $@
	fi
}

##-------------------------------------------------
## Functions for peco
##-------------------------------------------------
#if [ -n "`which peco 2> /dev/null`" ]; then
#    # dirs 拡張( for peco )
#    function exdirs-peco() {
#    	path=`dirs -v | awk '!colname[$2]++{print $0}' | peco | awk '{print $2}' | sed -e s:^~:${HOME}:`
#    	#echo ${path}
#    	cd ${path}
#    }
#    alias dd='exdirs-peco'
#    
#    # ps 拡張( for peco )
#    function killl() {
#    	process=`ps aux | peco | awk '{print $2}'`
#        if [ ! -z "$id" ] ; then
#    	    sudo kill -9 ${process}
#        fi
#    }
#fi

#-------------------------------------------------
# Functions for Docker
#-------------------------------------------------
function DD() {
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<RUNNING>\033[0m"
    #docker ps | tail -n +2 | awk 'BEGIN{OFS=" "}{print NR ": " $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15}'
    docker ps | tail -n +2 | awk 'BEGIN{OFS=" "}
        function red(s) { printf "\033[1;31m" s "\033[0m " }
        function green(s) { printf "\033[1;32m" s "\033[0m " }
        function blue(s) { printf "\033[1;34m" s "\033[0m " }
        { printf NR ": " $1 " " }
        { blue($2) }{ green($3) }
        { print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20 }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<STOPPED>\033[0m"
    #docker ps -a | grep "Exited \([0-9]*\)" | awk 'BEGIN{OFS="\t"}{print NR ": " $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}'
    docker ps -a | grep "Exited \([0-9]*\)" | awk 'BEGIN{OFS=" "}
        function red(s) { printf "\033[1;31m" s "\033[0m " }
        function green(s) { printf "\033[1;32m" s "\033[0m " }
        function blue(s) { printf "\033[1;34m" s "\033[0m " }
        { printf NR ": " $1 " " }
        { blue($2) }{ green($3) }
        { print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20 }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<IMAGES>\033[0m"
    #docker images | tail -n +2 | awk 'BEGIN{OFS="\t"}{print NR ": " $1,$2,$3,$4,$5,$6,$7,$8,$9,$10}'
    docker images | tail -n +2 | awk 'BEGIN{OFS="\t"} \
        function red(s) { printf "\033[1;31m" s "\033[0m \t" }
        function green(s) { printf "\033[1;32m" s "\033[0m \t" }
        function blue(s) { printf "\033[1;34m" s "\033[0m \t" }
        { printf NR ": " }
        { blue($1) }{ blue($2) }
        { print $3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20 }'
}

function DDps() {
    echo '<docker ps>'
   docker ps | tail -n +2
}
function DDpsa() {
    echo '<docker ps -a>'
   docker ps -a | tail -n +2
}
function DDi() {
    echo '<docker images>'
    docker images | tail -n +2
}
function DDstart() {
    id=$(docker ps -a | grep "Exited \([0-9]*\)" | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker start'
        docker start ${id}
    fi
}
function DDstop() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker stop'
        docker stop ${id}
    fi
}
function DDstopa() {
    echo 'docker stop'
    docker stop $(docker ps -a -q)
}
function DDrm() {
    id=$(docker ps -a | grep "Exited \([0-9]*\)" | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker rm'
        docker rm ${id}
    fi
}
function DDreset() {
    echo 'docker stop'
    docker stop $(docker ps -q)
    echo 'docker rm'
    docker rm $(docker ps -a -q)
}
function DDrmi() {
    id=$(docker images | tail -n +2 | peco | awk '{print $3}')
    if [ ! -z "$id" ] ; then
        echo 'docker rmi'
        docker rmi ${id}
    fi
}
function DDbash() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} /bin/bash
    fi
}
function DDmysql() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} mysql -u root -proot
    fi
}
function DDstats() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker stats ${id}
    fi
}
function DDtop() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker top ${id}
    fi
}
function DDlogs() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker logs ${id}
    fi
}
function DDlogsf() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker logs -f ${id}
    fi
}
function DDhistory() {
    id=$(docker images | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker history ${id}
    fi
}
function DDinspect() {
    id=$(docker ps -a | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker inspect ${id} | less
    fi
}
function DDip() {
    id=$(docker ps | tail -n +2 | peco | awk '{print $2}')
    if [ ! -z "$id" ] ; then
        echo -e "\033[1;33m<IPAddress@${id}>\033[0m"
        docker inspect -f '{{ .NetworkSettings.IPAddress }}' ${id}
    fi
}
function DDport() {
    item=$(docker ps -a | tail -n +2 | peco)
    if [ ! -z "$item" ] ; then
        name=$(echo ${item} | awk '{print $2}')
        id=$(echo ${item} | awk '{print $1}')
        echo -e "\033[1;33m<port@${name}>\033[0m"
        docker port ${id}
    fi
}
function DDvol() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker inspect -f '{{ .Volumes }}' ${id}
    fi
}
function DDenv() {
    id=$(docker images | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo -e "\033[1;33m<env@${id}>\033[0m"
        docker run --rm ${id} env
    fi
}
function DDhosts() {
    id=$(docker images | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo -e "\033[1;33m</etc/hosts@${id}>\033[0m"
        docker run --rm ${id} cat /etc/hosts
    fi
}
## ------------------------
## Docker for WordPress
## ------------------------
#function DDwp() {
#    docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -d nuts/mysql:5.7
#    docker run --name wordpress --link mysql:mysql -p 80:80 -v "/var/www/html/":/var/www/html -d wordpress
#}

