#!/bin/sh

# ------------------------------------------
# Function
# ------------------------------------------
function _install_peco() {
    if hash "wget" && hash "tar"; then
        echo -n "install peco ..."
        wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz
        tar xvzf peco_linux_amd64.tar.gz
        sudo cp peco_linux_amd64/peco /usr/local/bin
        sudo chmod 111 /usr/local/bin/peco
        rm -rf peco_linux_amd64*
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
