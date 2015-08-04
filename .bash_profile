
if [ -f ~/.bashrc ] ; then
	. ~/.bashrc
fi

#-------------------------------------------------
# Mac 固有の設定
#-------------------------------------------------
if [ "$(uname)" == 'Darwin' ]; then 

	#現在のディレクトリをファインダーで開く
	alias finder='open .'

 
	#現在のファインダーをTerminal.appで開く
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
	
	## Chrome
	alias chrome='open -a "/Applications/Google Chrome.app"' 
	
	## Sublime Text 3
	alias sub='open -a "/Applications/Sublime Text.app"'
	
	## Markdown Editor
	alias md='open -a "/Applications/MacDown.app"'
	
	## vi, vim をMacVim へ変更
	#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
	

# Linux 固有の設定
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Wellcome to Linux!'	

# Windows(Cygwin) 固有の設定
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Wellcome to Cygwin!'
else
#	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi


#-------------------------------------------------
# 基本
#-------------------------------------------------

## プロンプトの表示変更
export PS1="[\h@\t \w]\$ "
export PS1="[\h@\t \w\[\033[31m\]$(__git_ps1)]\$ "
export PS1="[\h@\t \w$(__git_ps1)]\$ "

## エイリアス
alias la='ls -laG'

## cd した後に la する
cdla() {
	\pushd "$@" && la
}

## エイリアス（移動:cd）
alias cd='cdla'

alias d='dirs -v | less'
alias p='popd'
alias cd2='pushd +2'
alias cd3='pushd +3'
alias cd4='pushd +4'
alias cd5='pushd +5'
alias cd6='pushd +6'
alias cd7='pushd +7'
alias cd8='pushd +8'
alias cd9='pushd +9'
alias cd10='pushd +10'
alias cd11='pushd +11'
alias cd12='pushd +12'
alias cd13='pushd +13'
alias cd14='pushd +14'
alias cd15='pushd +15'
alias cd16='pushd +16'
alias cd17='pushd +17'
alias cd18='pushd +18'
alias cd19='pushd +19'
alias cd20='pushd +20'

## エイリアス（移動:git）
alias cdg='cd $(git rev-parse --show-toplevel)'

## エイリアス（移動:Mac）
alias cdh='cdla ${HOME}'
alias cdd='cdla ${HOME}/Desktop'
alias cddoc='cdla ${HOME}/Documents'
alias cddl='cdla ${HOME}/Downloads'

alias cdgd='cdla ${HOME}/Google\ Drive'
alias cdod='cdla ${HOME}/OneDrive'
alias cddb='cdla ${HOME}/Dropbox'

alias cdmemo='cdla ${HOME}/Dropbox/アプリ/PlainText\ 2/INBOX'
alias cdm='cdla ${HOME}/MAMP_ROOT'
alias cdv='cdla ${HOME}/Vagrant'

#-------------------------------------------------
# WordPress - http://dev.ontheroad.jp
#-------------------------------------------------

export TARGET=dev
export DOCUMENTROOT=${HOME}/MAMP_ROOT

#基本設定
export WPROOT=${DOCUMENTROOT}/${TARGET}
export WPTHEME=${WPROOT}/wp-content/themes/channel
export WPPLUGIN=${WPROOT}/wp-content/plugins

#エイリアス（移動用）
alias wproot='cdla $WPROOT'
alias wptheme='cdla $WPTHEME'
alias wpplugin='cdla $WPPLUGIN'

#エイリアス（編集用）
alias wp-config='vim ${WPROOT}/wp-config.php'
alias header='vim ${WPTHEME}/header.php'
alias home='vim ${WPTHEME}/home.php'
alias pindex='vim ${WPTHEME}/index.php'
alias single='vim ${WPTHEME}/single.php'
alias archive='vim ${WPTHEME}/archive.php'
alias sidebar='vim ${WPTHEME}/sidebar.php'
alias style='vim ${WPTHEME}/style.css'
alias functions='vim ${WPTHEME}/functions.php'

#ファイルのバックアップ
makebk() {
	prefix=bk_$(date +%Y%m%d)_
	if [ -f $@ ]; then
		cp "$@" ./${prefix}$@
		echo ${prefix}" has been backuped."
	else
		zip -vr ${prefix}$@.zip $@
	fi
}

#-------------------------------------------------
# ネットワーク
#-------------------------------------------------
alias hosts='sudo vim /etc/hosts'

#-------------------------------------------------
# MAMP
#-------------------------------------------------
export MAMPROOT=/Applications/MAMP
export PATH=$PATH:${MAMPROOT}/bin
export PATH=$PATH:${MAMPROOT}/bin/php/php5.5.14/bin
export PATH=$PATH:${MAMPROOT}/Library/bin

#Apache
alias httpdconf='vim ${MAMPROOT}/conf/apache/httpd.conf'
alias vhosts='vim ${MAMPROOT}/conf/apache/extra/httpd-vhosts.conf'


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
				tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
				tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
			else
				tmux new-session && echo "tmux created new session"
			fi
		fi
	fi
}
tmux_automatically_attach_session

#-------------------------------------------------



