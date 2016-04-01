#!/bin/sh

wget https://github.com/peco/peco/releases/download/v0.2.9/peco_linux_amd64.tar.gz
tar xvzf peco_linux_amd64.tar.gz
sudo cp peco_linux_amd64/peco /usr/local/bin
sudo chmod 111 /usr/local/bin/peco
