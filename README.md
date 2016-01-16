# dotfiles

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

### Unite

``,`` に続けて、

* fr で、最近開いたファイル一覧（file_mru）
* ff で、カレントディレクトリ以下のファイル一覧（file_rec）
* fc で、カレントディレクトリのみのファイル一覧（file）
* fb で、開いているバッファの一覧（buffer）
* fm で、ブックマーク一覧（bookmark）
* fa で、ブックマークへ追加（UniteBookmarkAdd）
* fy で、レジスタ一覧（register）
* fh で、ヤンク履歴一覧（history/yank）
* ft で、アウトライン一覧（outline）
* fd で、新規ディレクトリ作成（directory/new）
* fn で、新規ファイル作成（file/new）

とりあえず、``,fr`` と ``,ff`` だけで十分便利

* ``,,`` で、 Unite ウインドウを閉じる
* ``,,`` で、Unite ウインドウを前回閉じた状態で開く（:UniteResume）

* ``,g`` でカレントディレクトリ以下を grep 検索(Unite grep:)
* ``,cg`` でカーソル位置の単語を grep 検索(Unite grep:)

### NERDTree

* ``,e`` で、ツリーの表示/非常時切り替え
* ツリーのルートを変更すると自動的にカレントディレクトリも変更する
* ファイルを開くと自動的にツリーを閉じる
* NERDTree ウインドウ内での操作（キーバインド）はデフォルトのまま


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

### Mac 設定

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

### 1.0.0

* git-prompt の追加
* git-completion の追加
* vim で、``BS`` キーで改行を削除できるようにした
* 軽微な Bagfix

###1.0.0

* 最初のリリース
