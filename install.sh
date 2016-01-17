#! /bin/bash 

DOTPATH=~/dotfiles

## -----------------------------------
## dotfiles の取得
## -----------------------------------
#
## git が使えるなら git
#if hash "git"; then
#    git clone --recursive "$GITHUB_URL" "$DOTPATH"
#
## 使えない場合は curl か wget を使用する
#elif has "curl" || has "wget"; then
#    tarball="https://github.com/b4b4r07/dotfiles/archive/master.tar.gz"
#    
#    # どっちかでダウンロードして，tar に流す
#    if has "curl"; then
#        curl -L "$tarball"
#
#    elif has "wget"; then
#        wget -O - "$tarball"
#
#    fi | tar xv -
#    
#    # 解凍したら，DOTPATH に置く
#    mv -f dotfiles-master "$DOTPATH"
#
#else
#    die "curl or wget required"
#fi
#
#cd ~/dotfiles
#if [ $? -ne 0 ]; then
#    die "not found: $DOTPATH"
#fi

## -----------------------------------
# デプロイ（Mac）
## -----------------------------------
if [ "$(uname)" == 'Darwin' ]; then 
	echo Welcome to MacOSX !

	for f in .bash_profile .bashrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc 
	do
		[ "$f" = ".git" ] && continue
		if [ -e $DOTPATH/$F ]; then
			ln -snfv "$DOTPATH/$f" "$HOME/$f" > /dev/null
			echo "success: ${f}"
		else
			echo "missing file/directory: ${f}"
		fi
	done

	## gvim(MacVim)
	#ln -sf ~/dotfiles/.gvimrc ~/.gvimrc
	#ln -sf /usr/share/vim/vim73/colors/desert.vim ~/.vim/colors/

	# Karabiner
	ln -sf ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml > /dev/null
	echo "success: Karabiner - private.xml"

	# peco
	ln -sf ~/dotfiles/peco ~/.config/peco
	echo "success: Peco config files"

#-------------------------------------------------
# デプロイ（Linux）
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Welcome to Linux !'

	for f in .bash_profile .bashrc .gitconfig .gitignore_global .vim .vimrc 
	do
		[ "$f" = ".git" ] && continue
		if [ -e $DOTPATH/$F ]; then
			ln -snfv "$DOTPATH/$f" "$HOME/$f" > /dev/null
			echo "success: ${f}"
		else
			echo "missing file/directory: ${f}"
		fi
	done

#-------------------------------------------------
# デプロイ（Windows(Cygwin) ）
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Welcome to Cygwin!'
else
#-------------------------------------------------
# デプロイ（その他 OS）
#-------------------------------------------------
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#-------------------------------------------------
# 共通
#-------------------------------------------------
if hash "git" && test ! -e ~/dotfiles/.vim/bundle/neobundle.vim; then
    echo 'NeoBundle Install...'
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    vim +":NeoBundleInstall" +:q
else
    echo 'skip NeoBundleInstall'
fi

source ~/.bash_profile >> /dev/null >&2>1
echo 'load .bash_profile'
echo 'Complete!'

