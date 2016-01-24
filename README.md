# dotfiles

* ``install.sh`` でインストールされるファイル群

|ファイル|MacOSX|Linux|備考|
|:---|:---:|:---:|:---|
|~/.bash_profile|◯|◯|[Bash](http://www.gnu.org/software/bash/bash.html) の設定|
|~/.bashrc|◯|◯|[Bash](http://www.gnu.org/software/bash/bash.html) の設定|
|~/.tmux.conf|◯||[tmux](https://tmux.github.io/) の設定|
|~/Library/Application Support/Karabiner/private.xml|◯||[Karaviner.app](https://pqrs.org/osx/karabiner/index.html.ja) 設定|
|~/.vimrc|◯|◯|[vim](http://www.vim.org/) の設定|
|~/.vim/|◯|◯|[vim](http://www.vim.org/) の設定|
|~/.giticonfig|◯|◯|[Git](https://git-scm.com/) の設定|
|~/.gitignore_global|◯|◯|[Git](https://git-scm.com/) の設定|
|~/.config/peco|◯||[peco](https://github.com/peco/peco) の設定|
|~/.vim/bundle/.neobundle|◯|◯|vim プラグイン管理ツール|
|~/.vim/bundle/PDV--phpDocumentor-for-Vim|◯|◯|vim プラグイン|
|~/.vim/bundle/SrcExpl|◯|◯|vim プラグイン|
|~/.vim/bundle/ag.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/indentLine|◯|◯|vim プラグイン|
|~/.vim/bundle/neobundle.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/neocomplete-php.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/neocomplete.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/neomru.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/neosnippet|◯|◯|vim プラグイン|
|~/.vim/bundle/neosnippet-snippets|◯|◯|vim プラグイン|
|~/.vim/bundle/nerdtree|◯|◯|vim プラグイン|
|~/.vim/bundle/qfixhowm|◯|◯|vim プラグイン|
|~/.vim/bundle/tagbar|◯|◯|vim プラグイン|
|~/.vim/bundle/taglist.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/unite-outline|◯|◯|vim プラグイン|
|~/.vim/bundle/unite.vim|◯|◯|vim プラグイン|
|~/.vim/bundle/vdebug|◯|◯|vim プラグイン|
|~/.vim/bundle/vim-fugitive|◯|◯|vim プラグイン|
|~/.vim/bundle/vim-quickrun|◯|◯|vim プラグイン|
|~/.vim/bundle/vim-ref|◯|◯|vim プラグイン|
|~/.vim/bundle/vimproc|◯|◯|vim プラグイン|
|~/dotfiles/bin/battery.sh|◯|◯|[tmux](https://tmux.github.io/) のステータスバーにバッテリー残量を表示するスクリプト|
|~/dotfiles/bin/get_ssid.sh|◯|◯|[tmux](https://tmux.github.io/) のステータスバーに接続中の SSID を表示するスクリプト|
|~/dotfiles/bin/git/git-completion.bash|◯|◯|[Git](https://git-scm.com/) コマンド補完スクリプト|
|~/dotfiles/bin/git/git-prompt.sh|◯|◯|シェルプロンプトに [Git](https://git-scm.com/) 状態を表示するスクリプト|
|/usr/local/etc/bash_completion.d/vagrant|◯||[Vagrant](https://www.vagrantup.com/) コマンド補完スクリプト|



## bash

* ``ls -la`` は ``la`` で
* ``cd`` すると自動的に ``la``
* ``d`` で一つ前の場所へ戻る
* ``dd`` 過去の移動履歴一覧からジャンプ（peco）
* ``exps`` プロセス一覧から選択して kill （peco）

### その他の主なエイリアス

* 

## tmux の使い方（MacOSX のみ）

* プレフィックスキーは ``CMD`` + ``b``
* ``Prefixkey`` + ``-`` でペインを横分割
* ``Prefixkey`` + ``\`` でペインを縦分割
* ``PrefixKey`` + ``o`` でペインをローテーションしながら移動

* ``prefixkey`` + ``j`` でペインの境界を下へ移動
* ``prefixkey`` + ``k`` でペインの境界を上へ移動
* ``prefixkey`` + ``h`` でペインの境界を左へ移動
* ``prefixkey`` + ``l`` でペインの境界を右へ移動

## vim の使い方

* ``jj`` で挿入モードを抜ける
* ``CMD`` + ``Shift`` + ``o`` でウインドウ間の移動
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

### 1.1.2

* [Add] vagrant-completion の追加

### 1.1.1

* [FIX] NeoBundle がインストール済みの場合には、再度インストールしないように変更

### 1.1.0

* [Add] git-prompt の追加
* [Add] git-completion の追加
* [Add] vim で、``BS`` キーで改行を削除できるようにした
* [Fix] 軽微な Bagfix

###1.0.0

* 最初のリリース
