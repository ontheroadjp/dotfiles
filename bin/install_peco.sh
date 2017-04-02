#!/bin/sh

install_dir="~/dotfiles/bin"

# ------------------------------------------
# Function
# ------------------------------------------

function _install_peco() {
    printf ">>> install peco..."
    if ! which "peco"; then
        if [ "$(uname)" == 'Darwin' ]; then 
            wget https://github.com/peco/peco/releases/download/v0.4.3/peco_darwin_386.zip -P ${DOTPATH} > /dev/null 2>&1
            tar xzf peco_darwin_386.zip -C peco --strip-components 1
            rm ${DOTPATH}/peco_darwin_386.zip
        elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
            wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz -P ~/dotfiles > /dev/null 2>&1
            tar xzf peco_linux_amd64.tar.gz -C peco --strip-components 1
            rm ${DOTPATH}/peco_linux_amd64.tar.gz
        fi
        mkdir -p ${HOME}/.peco && ln -sf ${DOYPATH}/peco/config.json ~/.peco/config.json
	    echo "done"
    else
        echo "skip"
    fi
}

function _install_peco() {

    if which peco; then {
        echo "peco is already installed."
        exit 0 
    fi
    
    if ! which "wget"; then
        echo "You need to install wget."
        exit 1 
    fi
    
    if ! which "tar"; then
        echo "You need to install tar."
        exit 1 
    fi

    pfintf "install peco..."

    # for Mac
    if [ "$(uname)" == 'Darwin' ]; then 
        wget https://github.com/peco/peco/releases/download/v0.4.2/peco_darwin_amd64.zip
        unzip peco_darwin_amd64.zip
        sudo cp peco_darwin_amd64/peco ${install_dir}
        rm -rf peco_*darwin*

    # for Linux
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        wget https://github.com/peco/peco/releases/download/v0.4.2/peco_linux_amd64.tar.gz
        tar xvzf peco_linux_amd64.tar.gz
        sudo cp peco_linux_amd64/peco ${install_dir}
        rm -rf peco_*_amd64*
    else
        echo "Unknown OS type."
        exit 1
    fi

    sudo chmod 755 ${install_dir}/peco
    mkdir -p ${HOME}/.peco && ln -sf ~/dotfiles/peco/config.json ~/.peco/config.json
    echo "done."
}

# ------------------------------------------
# Main
# ------------------------------------------

_install_peco

exit 0
