
# dotfiles


#! /bin/bash 

### Symbolic Link

```
ln -s ~/dotfiles/.bashrc ~/.bashrc  
ln -s ~/dotfiles/.bash_profile ~/.bash_profile  
ln -s ~/dotfiles/.vimrc ~/.vimrc  
#ln -s ~/dotfiles/.gvimrc ~/.gvimrc  
ln -s ~/dotfiles/.atom ~/.atom
#ln -s ~/dotfiles/.bash_history ~/.bash_history
#ln -s ~/dotfiles/.gitconfig ~/.gitconfig
#ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global

source ~/.bash_profile
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


