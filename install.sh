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
    peco_install_dir="/usr/local/bin"
    #if [ ! -e $peco_install_dir ]; then
    if hash "peco"; then
        wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz
        tar xvzf peco_linux_amd64.tar.gz
        sudo cp peco_linux_amd64/peco /usr/local/bin
        sudo chmod 111 /usr/local/bin/peco
	    ln -sf ~/dotfiles/peco ~/.config/peco
        rm peco_linux_amd64.tar.gz
        rm -rf peco_linux_amd64
	    echo "success: Peco installed!"
    else
        echo 'skip Peco Install'
    fi

#-------------------------------------------------
# デプロイ（Linux）
#-------------------------------------------------
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	echo 'Welcome to Linux !'

	for f in .bash_profile .bashrc .gitconfig .gitignore_global .vim .vimrc .gvimrc
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
source ~/.bash_profile >> /dev/null >&2>1
echo 'load .bash_profile'

# Install peco
function _install_peco() {
    if hash "peco"; then
        echo -n 'peco Install...'
        wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz
        tar xvzf peco_linux_amd64.tar.gz
        sudo cp peco_linux_amd64/peco /usr/local/bin
        sudo chmod 111 /usr/local/bin/peco
        echo "done."
    else
        echo 'skip peco install'
    fi
}

# Install NeoBundle for vim 
function _install_neobundle() {
    if hash "git" && test ! -e ~/dotfiles/.vim/bundle/neobundle.vim; then
        echo -n 'NeoBundle Install...'
        git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
        vim + ":NeoBundleInstall" +:q
        echo "done."
    else
        echo 'skip NeoBundleInstall'
    fi
}

# Install dopecker(https://github.com/ontheroadjp/dopecker.git)
function _install_dopecker() {
    if hash docker && hash git && [ ! -d ~/dotfiles/dopecker ]; then
        echo -n 'dopecker Install...'
        git clone https://github.com/ontheroadjp/dopecker.git ~/dotfiles/dopecker
        echo "done."
    else
        echo 'skip dopecker ienstall'
    fi
}

echo 'Complete!'

exit 0
