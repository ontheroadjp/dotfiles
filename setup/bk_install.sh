#! /bin/sh

DOTPATH=${HOME}/dotfiles

function _is_exist {
    type $@ > /dev/null 2>&1
}

function _deploy_dotfiles() {
    #-------------------------------------------------
    # for MacOSX
    #-------------------------------------------------
    if [ "$(uname)" == "Darwin" ]; then
    	echo "Welcome to MacOSX !"

        echo ">>> deploy dotfiles..."
        dotfiles=(
            .bash_profile
            .bashrc
            .gitconfig
            .gitignore_global
            .tmux.conf
            .vim
            .vimrc
        )

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
    	#ln -sf ${DOTPATH}/.gvimrc ~/.gvimrc
    	#ln -sf /usr/share/vim/vim73/colors/desert.vim ~/.vim/colors/

    	# Karabiner
    	ln -sf ${DOTPATH}/karabiner/private.xml ${HOME}/Library/Application\ Support/Karabiner/private.xml > /dev/null
    	echo "success: Karabiner - private.xml"

        #homebrew
        #brew install youtube-dl
        #brew install mplayer

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

    #-------------------------------------------------
    # for Windows Subsystem for Linux
    #-------------------------------------------------
#    elif [ "$(cat /proc/version_signature | grep -i 'microsoft')" ]; then
    	echo 'Welcome to Windows Subsystem for Linux!'

    else
    #-------------------------------------------------
    # for other OS
    #-------------------------------------------------
    	echo "Your platform ($(uname -a)) is not supported."
    	exit 1
    fi
}

#-------------------------------------------------
# Vim(NeoBundle)
#-------------------------------------------------
function _install_neobundle() {
    printf ">>> install NeoBundle for vim..."
    if _is_exist vim; then
        if _is_exist "git" && [ ! -e ${DOTPATH}/.vim/bundle/neobundle.vim ]; then
            git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
            #vim +:NeoBundleInstall +:q
            # https://github.com/Shougo/neobundle.vim/blob/master/bin/neoinstall
            vim -u ~/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q! | endtry" -e -s -V1
            echo "done."
        else
            echo "skip: already exist."
        fi
    else
        echo "skip - vim is not installed."
    fi
}

#-------------------------------------------------
# PHP Document
#-------------------------------------------------
function _getPhpDocument() {
    printf ">>> install PHP Document..."
    url=http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror
    mkdir -p ${DOTPATH}/.vim/ref
    if [ ! -d ${DOTPATH}/.vim/ref/php-chunked-xhtml ]; then
        wget -O ${DOTPATH}/.vim/ref/php-chunked-xhtml.tar.gz ${url}
        tar xzf ${DOTPATH}/.vim/ref/php-chunked-xhtml.tar.gz -C ${DOTPATH}/.vim/ref
        echo "done"
    else
        echo "skip: already installed."
    fi
}

#-------------------------------------------------
# Peco
#-------------------------------------------------
#
########################################################
# This is the function for the installing peco manually.
# now peco is going to be installed by Homebrew.
########################################################
#
#function _install_peco() {
#    printf ">>> install peco..."
#    if _is_exist wget; then
#        if ! _is_exist "peco"; then
#            if [ "$(uname)" == 'Darwin' ]; then
#                wget https://github.com/peco/peco/releases/download/v0.4.3/peco_darwin_386.zip -P ${DOTPATH}
#                tar xzf peco_darwin_386.zip -C peco --strip-components 1
#                rm ${DOTPATH}/peco_darwin_386.zip
#            elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
#                wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz -P ${DOTPATH}
#                tar xzf peco_linux_amd64.tar.gz -C peco --strip-components 1
#                rm ${DOTPATH}/peco_linux_amd64.tar.gz
#            fi
#            mkdir -p ${HOME}/.peco && ln -sf ${DOTPATH}/peco/config.json ~/.peco/config.json
#	        echo "done"
#        else
#            echo "skip: already installed."
#        fi
#    else
#        echo "skip: you need to install wget first."
#    fi
#}

#-------------------------------------------------
# go & ghq
#-------------------------------------------------
if [ "$(uname)" == 'Darwin' ]; then
    # Homebrew
    if ! _is_exist brew; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
	export PATH="/usr/local/bin:$PATH"
    export PATH="/usr/local/sbin:$PATH"
    alias brew="env PATH=${PATH/\/Users\/$(whoami)\/\.rbenv\/shims:?/} brew"

    # go & ghq
    if ! _is_exist go; then brew install go; fi
    if ! _is_exist ghq; then brew tap motemen/ghq && brew install ghq; fi
fi

#-------------------------------------------------
# Docker
#-------------------------------------------------
function _install_docker_dd() {
    if ! _is_exist peco; then
        _install_peco
    fi

    printf ">>> install docker-dd..."
    if [ -d "${DOTPATH}/docker-dd" ]; then
        if _is_exist git && [ ! -d ${DOTPATH}/docker-dd ]; then
            echo -n '>>> docker-dd Install...'
            git clone https://github.com/nutsllc/docker-dd.git
            echo "done"
        else
            echo 'skip'
        fi
    else
        echo 'skip: already installed.'
    fi
}

[ -z "$1" ] && {
    branch=master
    branch=dev
}

if [ ! -d ~/.dotfiles ]; then
    if ! _is_exist git; then
        echo "you need to install git first."; exit 2
    fi
    git clone -b ${branch} https://github.com/ontheroadjp/dotfiles.git ~/dotfiles
else
    cd ${DOTPATH} && git pull
fi

_deploy_dotfiles
_install_neobundle
_getPhpDocument
_install_peco
_install_docker_dd

echo ">>> load .bash_profile"
exec ${SHELL} -l

echo "Complete!"

exit 0
