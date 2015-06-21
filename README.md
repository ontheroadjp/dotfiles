
# dotfiles


#! /bin/bash 

### Symbolic Link

```
ln -sf ~/dotfiles/.bashrc ~/.bashrc  
ln -sf ~/dotfiles/.bash_profile ~/.bash_profile  
ln -sf ~/dotfiles/.vimrc ~/.vimrc  
#ln -sf ~/dotfiles/.gvimrc ~/.gvimrc  
ln -sf ~/dotfiles/.atom ~/.atom
#ln -sf ~/dotfiles/.bash_history ~/.bash_history
#ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
#ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

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


