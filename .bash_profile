
#-------------------------------------------------
# Mac 用
#-------------------------------------------------

#現在のディレクトリをファインダーで開く
alias finder='open .'
alias chrome='open -a "/Applications/Google Chrome.app"' 

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


#ブラウザで開く
dev(){
	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp
}

devadmin(){
	open -a "/Applications/Google Chrome.app"/ http://dev.localhost.jp/wp-login.php
}

you(){
	open -a "/Applications/Google Chrome.app"/ http://you.localhost.jp
}

coteditor(){
	open -a "/Applications/CotEditor.app"/ $1
}

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

alias cd='cdla'
alias po='popd'
alias bashprofile='vim ${HOME}/.bash_profile'
alias vimrc='vim ${HOME}/.vimrc'

#エイリアス
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
# Laravel
#-------------------------------------------------
alias golaravelhome='cd ~/Vagrant/Laravel4-Vagrant/www'


