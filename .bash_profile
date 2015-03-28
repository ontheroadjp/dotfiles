
#-------------------------------------------------
# Mac 用
#-------------------------------------------------

#現在のディレクトリをファインダーで開く
alias openfinder='open .'

#現在のファインダーをTerminal.appで開く
openterminal(){
	target=`osascript -e 'tell application "Finder" to if(count of Finder windows) > 0 then get POSIX path of(target of front Finder window as text)'`
	if [ "$target" != "" ]
	then
		cd "$target"
		pwd
	else
		echo 'No Finder window found' >&2
	fi
}

#-------------------------------------------------
#基本
#-------------------------------------------------

#プロンプトの表示変更
export PS1="[\h@\t \w]\$ "

# vi, vim をMacVim へ変更
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env_LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'

#エイリアス
alias la='ls -laG'

#cd した後に la する
cdla() {
	\pushd "$@" && la
}

alias cd='cdla'
alias po='popd'
alias bashprofile='vim ${HOME}/.bash_profile'
alias vimrc='vim ${HOME}/.vimrc'

#エイリアス
alias home='cdla ${HOME}'
alias desk='cdla ${HOME}/Desktop'
alias doc='cdla ${HOME}/Documents'
alias down='cdla ${HOME}/Downloads'

alias gdrive='cdla ${HOME}/Google Drive'
alias odrive='cdla ${HOME}/OneDrive'
alias dbox='cdla ${HOME}/Dropbox'

alias mroot='cdla ${HOME}/MAMP_ROOT'
#-------------------------------------------------
# WordPress - http://dev.ontheroad.jp
#-------------------------------------------------

export TARGET=dev

#基本設定
export DOCUMENTROOT=${HOME}/DocumentRoot

export WPROOT=${DOCUMENTROOT}/${TARGET}
export WPTHEME=${WPROOT}/wp-content/themes/channel
export WPPLUGIN=${WPROOT}/wp-content/plugins

#エイリアス（移動用）
alias wproot='cdla $WPROOT'
alias wptheme='cdla $WPTHEME'
alias wpplugin='cdla $WPPLUGIN'

#エイリアス（編集用）
alias vimwpconf='vim ${WPROOT}/wp-config.php'
alias vimheader='vim ${WPTHEME}/header.php'
alias vimhome='vim ${WPTHEME}/home.php'
alias vimsingle='vim ${WPTHEME}/single.php'
alias vimarchive='vim ${WPTHEME}/archive.php'
alias vimsidebar='vim ${WPTHEME}/sidebar.php'
alias vimstyle='vim ${WPTHEME}/style.css'
alias vimfunctions='vim ${WPTHEME}/functions.php'

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

#ブラウザで開く
dev(){
	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp
}

devadmin(){
	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp/wp-login.php
}

alias finder='open .'

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

#Apache
alias httpdconf='vim ${MAMPROOT}/conf/apache/httpd.conf'
alias vhosts='vim ${MAMPROOT}/conf/apache/extra/httpd-vhosts.conf'

