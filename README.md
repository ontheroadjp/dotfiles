
# dotfiles


#! /bin/bash 

### Symbolic Link

```
## for General
ln -sf ~/dotfiles/.bashrc ~/.bashrc  
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile  
#ln -sf ~/dotfiles/.bash_history ~/.bash_history

## for git
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

## for tmux
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/bin/get_ssid.sh /usr/local/bin/get_ssid
ln -sf ~/dotfiles/bin/battery.sh /usr/local/bin/battery

## for vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc  
#ln -sf ~/dotfiles/.gvimrc ~/.gvimrc  

## for Karabiner.app
ln -sf ~/dotfiles/karabiner/private.xml ~/Library/Application\ Support/Karabiner/private.xml

## for atom
ln -sf ~/dotfiles/.atom ~/.atom

source ~/.bash_profile
```

## tmux 関連

### インストール

```
$ brew install tmux
```


## vim 関連

### vim のインストール

```
sudo apt-get update
sudo apt-get install -y vim
```

### NeoBundle のインストール

```
mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

### スワップ/バックアップ用のディレクトリ作成

```
mkdir ~/.vim/backup
mkdir ~/.vim/swap
```


