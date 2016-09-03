#!/bin/sh

# ------------------------------------------
# Function
# ------------------------------------------
function _install_peco() {
    if hash "wget" && hash "tar"; then
        echo -n "install peco ..."
        local install_dir="/usr/bin"

        # for Mac
        if [ "$(uname)" == 'Darwin' ]; then 
            wget https://github.com/peco/peco/releases/download/v0.4.2/peco_darwin_amd64.zip
            unzip peco_darwin_amd64.zip
            sudo cp peco_darwin_amd64/peco ${install_dir}

        # for Linux
        elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
            wget https://github.com/peco/peco/releases/download/v0.4.2/peco_linux_amd64.tar.gz
            tar xvzf peco_linux_amd64.tar.gz
            sudo cp peco_linux_amd64/peco ${install_dir}
        fi

        sudo chmod 111 ${install_dir}/peco
        rm -rf peco_*_amd64*
        echo "done."
    else
        echo "wget and/or tar doesn't installed."
        exit 1
    fi
}

# ------------------------------------------
# Main
# ------------------------------------------
_install_peco
exit 0
