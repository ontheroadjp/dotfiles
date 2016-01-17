# dotfiles

* bash の設定（``.bash_profile`` ``.bashrc``）
* tmux の設定（``.tmux.conf``） ※ MacOSX のみ
* karaviner の設定 ※ MacOSX のみ
* vim の設定（``.vimrc``）
* git の設定（``.giticonfig`` など）

## bash

* ``ls`` は ``la`` で

* peco
	* ``$ dd`` 過去の移動履歴一覧からジャンプ
	* ``$ exps`` プロセス一覧から選択して kill 
* git-prompt
* git-completion


## vim の使い方

* ``jj`` で挿入モードを抜ける
* ``<Leader>`` は、デフォルト（``\``） のまま
* ファイルをまたぐ（複数ファイルを扱う）操作は、``,`` に統一
	* ``Unite`` も、``,``
	* ``NERDTree`` も、``,``
	* ``SrcExpl`` も、``,``
	* ``grep`` も、``,``
	
	(``grep`` は Unite grep で ag を使用する)

* ジャンプ（移動）関連の操作は、``<Space>`` に統一
	* ``<Space>h`` で、行頭へ移動
	* ``<Space>l`` で、行末へ移動
	* ``<Space>[`` で、対になるカッコへ移動
	* ``<Space>o`` で、ジャンプリスト戻る
	* ``<Space>i`` で、ジャンプリスト進む
	* ``<Space><Space>`` で、直近の編集場所へ移動
	* ``<Space>]`` で、定義元ファイルへジャンプ

## unite の使い方

* とりあえず、``,fr``（最近開いたファイル一覧） と ``,ff``（カレントディレクトリのファイル一覧） だけで十分便利
* ``,,`` で、 Unite ウインドウを閉じる
* ``,,`` で、Unite ウインドウを前回閉じた状態で開く（:UniteResume）

* ``,g`` でカレントディレクトリ以下を grep 検索(Unite grep:)
* ``,cg`` でカーソル位置の単語を grep 検索(Unite grep:)

### コマンド

|col1|col2|
|:---|:---|
|,fr|最近開いたファイル一覧（file_mru）|
|,ff|カレントディレクトリ以下のファイル一覧（file_rec）|
|,fc|カレントディレクトリのみのファイル一覧（file）|
|,fb|開いているバッファの一覧（buffer）|
|,fm|ブックマーク一覧（bookmark）|
|,fa|ブックマークへ追加（UniteBookmarkAdd）|
|,fy|レジスタ一覧（register）|
|,fh|ヤンク履歴一覧（history/yank）|
|,ft|アウトライン一覧（outline）|
|,fd|新規ディレクトリ作成（directory/new）|
|,fn|新規ファイル作成（file/new）|

* 新規ディレクトリ作成（``,fd``）と新規ファイル作成（``,fn``）は NERDTree で行った方がわかりやすい。

## NERDTree の使い方

* ツリーのルートを変更すると自動的にカレントディレクトリも変更する
* ファイルを開くと自動的にツリーを閉じる
* NERDTree ウインドウ内での操作（キーバインド）はデフォルトのまま

### 基本コマンド

|col1|col2|
|:---|:---|
|``,e``|ツリーの開閉|
|``?``|ヘルプ表示/非表示切り替え|
|``k``|カーソルを上へ移動|
|``j``|カーソルを下へ移動|
|``o``|ファイル開く|
|``s``|ウインドウを横に分割してファイルを開く|
|``ma``|新規ファイル/ディレクトリ作成（ファイル名の最後に ``/`` を付けるとディレクトリ作成）|

## その他

### インストール

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


#### tmux インストール

```
$ brew install tmux
```

#### vim のインストール

```
sudo apt-get update
sudo apt-get install -y vim
```

#### NeoBundle のインストール

```
mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

### スワップ/バックアップ用のディレクトリ作成

```
mkdir ~/.vim/backup
mkdir ~/.vim/swap
```

## 変更履歴

### 1.1.1

* [Fix] NeoBundle がインストール済みの場合は、再インストールしないように変更

### 1.1.0

* [Add] git-prompt の追加
* [Add] git-completion の追加
* [Change] vim で、``BS`` キーで改行を削除できるようにした
* [Fix] 軽微な Bagfix

###1.0.0

* 最初のリリース
