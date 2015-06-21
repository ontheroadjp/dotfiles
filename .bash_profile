
#-------------------------------------------------
# Mac 用
#-------------------------------------------------

#現在のディレクトリをファインダーで開く
alias finder='open .'

#指定ファイルをクロームで開く usage: $ chrome ./index.html
alias chrome='open -a "/Applications/Google Chrome.app"' 

#指定ファイルを SublimeText3 で開く 
alias sub='open -a "/Applications/Sublime Text.app"'
 
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


##ブラウザで開く
#dev(){
#	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp
#}
#
#devadmin(){
#	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp/wp-login.php
#}
#
#you(){
#	open -a "/Applications/Google Chrome.app"/ http://you.localhost.jp
#}
#
#coteditor(){
#	open -a "/Applications/CotEditor.app"/ $1
#}

#-------------------------------------------------
#基本
#-------------------------------------------------

#プロンプトの表示変更
export PS1="[\h@\t \w]\$ "

# vi, vim をMacVim へ変更
#alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
#alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

#エイリアス
alias la='ls -laG'

#cd した後に la する
cdla() {
	\pushd "$@" && la
}

#エイリアス
alias cd='cdla'
alias po='popd'

#エイリアス（移動用）
alias gohome='cdla ${HOME}'
alias godesktop='cdla ${HOME}/Desktop'
alias godocuments='cdla ${HOME}/Documents'
alias godownload='cdla ${HOME}/Downloads'

alias gogoogledrive='cdla ${HOME}/Google\ Drive'
alias goonedrive='cdla ${HOME}/OneDrive'
alias godropbox='cdla ${HOME}/Dropbox'

alias gotext='cdla ${HOME}/Dropbox/アプリ/PlainText\ 2/INBOX'
alias gomamproot='cdla ${HOME}/MAMP_ROOT'

#-------------------------------------------------
# WordPress - http://dev.ontheroad.jp
#-------------------------------------------------

export TARGET=dev

#基本設定
export DOCUMENTROOT=${HOME}/MAMP_ROOT
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
alias wphome='vim ${WPTHEME}/home.php'
alias wpindex='vim ${WPTHEME}/index.php'
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
# 参考：http://qiita.com/b4b4r07/items/01359e8a3066d1c37edc
# 参考：https://github.com/b4b4r07/dotfiles


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



