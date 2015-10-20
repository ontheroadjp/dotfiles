#! /bin/bash 

DOTPATH=~/dotfiles


## -----------------------------------
## dotfiles の取得
## -----------------------------------
#
## git が使えるなら git
#if has "git"; then
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

	for f in .atom .bash_profile .bashrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc 
	do
	    [ "$f" = ".git" ] && continue
	    ln -snfv "$DOTPATH/$f" "$HOME/$f"
	done

	#ln -s ~/dotfiles/.gvimrc ~/.gvimrc
	ln -sf ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

	source ~/.bash_profile

#-------------------------------------------------
# デプロイ（Linux ）
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Welcome to Linux!'

#-------------------------------------------------
# デプロイ（Windows(Cygwin) ）
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	echo 'Welcome to Cygwin!'
else
#-------------------------------------------------
# デプロイ（その他 OS）
#-------------------------------------------------
#	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi


