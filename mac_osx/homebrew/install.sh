#!/bin/bash
set -e

components=(
    curl
    gettext
    go
    htop-osx
    httping
    jpeg
    jpegoptim
    jq
    libevent
    mas
    nmap
    oniguruma
    openssl
    optipng
    pkg-config
    tmux
    tree
    ttyrec
    vagrant-completion
    wget
)

function _install() {
    for comp in ${components[@]}; do
        printf ">> ${comp} installing..."
        brew install ${comp} > /dev/null 2>&1
        echo "done"
    done
}

if which brew; then
    _install && {
        echo "complete!"
    }
else
    echo "brew isn't installed"
    echo "see http://brew.sh/"
fi

exit 0
