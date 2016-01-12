
# dotfiles

## インストール

```
# dotfiles 取得
$ git clone -b bk https://github.com/ontheroadjp/dotfiles.git

# ディレクトリ作成
$ mkdir dotfiles/.vim/bundle

# NeoBundle インストール
$ git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# vim プラグインのインストール
$ vim
:NeoBundleInstall
```

## Mac 設定

### tmux インストール

```
$ brew install tmux
```

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


