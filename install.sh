#! /bin/bash 

DOTPATH=~/dotfiles

## -----------------------------------
## dotfiles の取得
## -----------------------------------
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

function _deploy_dotfiles() {
    #-------------------------------------------------
    # for MacOSX
    #-------------------------------------------------
    if [ "$(uname)" == "Darwin" ]; then 
    	echo "Welcome to MacOSX !"
    
        echo ">>> deploy dotfiles..."
        dotfiles=(.bash_profile .bashrc .gitconfig .gitignore_global .tmux.conf .vim .vimrc)
    	for f in ${dotfiles[@]}
    	do
    		[ "${f}" = ".git" ] && continue
    		if [ -e ${DOTPATH}/${F} ]; then
    			ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}" > /dev/null
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
    
    #-------------------------------------------------
    # for Linux
    #-------------------------------------------------
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    	echo "Welcome to Linux !"
    
        echo ">>> deploy dotfiles..."
        dotfiles=(.bash_profile .bashrc .gitconfig .gitignore_global .vim .vimrc .gvimrc)
    	for f in ${dotfiles[@]}
    	do
    		[ "${f}" = ".git" ] && continue
    		if [ -e ${DOTPATH}/${F} ]; then
    			ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}" > /dev/null
    			echo "success: ${f}"
    		else
    			echo "missing file/directory: ${f}"
    		fi
    	done
    
    #-------------------------------------------------
    # for Windows(Cygwin)
    #-------------------------------------------------
    elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
    	echo 'Welcome to Cygwin!'
    else
    #-------------------------------------------------
    # for other OS
    #-------------------------------------------------
    	echo "Your platform ($(uname -a)) is not supported."
    	exit 1
    fi
}

#-------------------------------------------------
# Vim
#-------------------------------------------------
function _install_neobundle() {
    printf ">>> install NeoBundle for vim..."
    if hash "git" && test ! -e ~/dotfiles/.vim/bundle/neobundle.vim; then
        git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
        vim + ":NeoBundleInstall" +:q
        echo "done."
    else
        echo "skip"
    fi
}

#-------------------------------------------------
# Peco
#-------------------------------------------------
function _install_peco() {
    printf ">>> install peco..."
    if ! hash "peco"; then
        if [ "$(uname)" == 'Darwin' ]; then 
            wget https://github.com/peco/peco/releases/download/v0.4.3/peco_darwin_386.zip -P ${DOTPATH} > /dev/null 2>&1
            tar xzf peco_darwin_386.zip -C peco --strip-components 1
            rm ${DOTPATH}/peco_darwin_386.zip
        elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
            wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz -P ~/dotfiles > /dev/null 2>&1
            tar xzf peco_linux_amd64.tar.gz -C peco --strip-components 1
            rm ${DOTPATH}/peco_linux_amd64.tar.gz
        fi
        mkdir -p ${HOME}/.peco && ln -sf ~/dotfiles/peco/config.json ~/.peco/config.json
	    echo "done"
    else
        echo "skip"
    fi
}

#-------------------------------------------------
# Docker
#-------------------------------------------------
function _install_docker_dd() {
    printf ">>> install docker-dd..."
    if hash git && [ ! -d ~/dotfiles/docker-dd ]; then
        echo -n '>>> docker-dd Install...'
        git clone https://github.com/nutsllc/docker-dd.git
        #git clone https://github.com/ontheroadjp/dopecker.git ~/dotfiles/dopecker
        echo "done"
    else
        echo 'skip'
    fi
}

_deploy_dotfiles
#_install_neobundle
_install_peco
_install_docker_dd

echo "Complete! - note:you must source ~/.bash_profile"

exit 0
