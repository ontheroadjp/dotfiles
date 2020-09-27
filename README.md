# dotfiles

* ``bash/zsh``, ``tmux``, ``vim``, ``git``, ``karabiner``(Mac only) の設定が中心
* 主な連携ツール： ``peco``, ``ghq``, ``ag``, ``ctags``

## shell

### ディレクトリ移動（基本）

* ``ls -laG`` は ``la`` で
* ``cd`` すると自動的に ``la`` (``cd`` は ``pushd`` のエイリアス)
* ``b`` で一つ前の場所へ戻る (``popd``)
* ``.`` で ``pwd``
* ``..`` で一つ上の階層へ
* ``...`` で二つ上の階層へ
* ``....`` で三つ上の階層へ

### ディレクトリ移動（ジャンプ）
* ``cdd`` で ``peco`` が起動して ``~/WORKSPACE`` 配下のディレクトリへ移動
* ``cds`` で ``peco`` が起動して配下のサブディレクトリへ移動
* ``cdm`` でマーク一覧を `peco` で表示/選択して移動

``zsh`` の場合は、
* ``^R`` でも ``cdd`` (``^`` は ``Ctrl``)

### ローカルレポジトリ移動
* ``rr`` で ``ghq`` 管理のレポジトリ一覧を ``peco`` で表示/選択してディレクトリ移動
* ``ggg`` でレポジトリルートへ移動

### リモートレポジトリ移動
* ``rrgit`` で ``ghq`` 管理のレポジトリ一覧を ``peco`` で表示/選択してブラウザで開く
* ``myrepo`` で自分の Git リポジトリ一覧を ``peco`` で表示/選択してブラウザで開く
* ``github`` でカレントディレクトリの GitHub をブラウザで開く

### ジャンプ & マーク
* ``mm`` でカレントディレクトリを記憶し `m` で記憶したディレクトリへ移動
* ``nn`` でカレントディレクトリを記憶し `n` で記憶したディレクトリへ移動
* ``ii`` でカレントディレクトリを記憶し `i` で記憶したディレクトリへ移動
* ``oo`` でカレントディレクトリを記憶し `o` で記憶したディレクトリへ移動

### その他
* ``dot``で ``${HOME}/dotfiles`` へ移動
* ``vp`` で ``.bash_profile`` を ``vim`` で開く
* ``sp`` で ``.bash_profile`` を再読み込み

### コマンド履歴
``zsh`` の場合、
    * ``^H`` で ``peco`` が起動してコマンド履歴からコマンド実行

## tmux
* 設定は ``~/.tmux.conf``
* プレフィックスキーは ``Ctrl`` + ``b`` （デフォルト）

### セッション（キーバインドは全てデフォルト）
* ``prefix`` + ``s`` でセッション一覧 & セッション移動
* ``prefix`` + ``d`` でデタッチ

### ウインドウ（キーバインドは全てデフォルト）
* ``prefix`` + ``w`` でウインドウ一覧 & ウインドウ移動
* ``prefix`` + ``c`` で新規ウインドウ作成
* ``prefix`` + ``n`` で次のウインドウへ移動
* ``prefix`` + ``1`` でウインドウ番号へ移動
* ``prefix`` + ``,`` でウインドウ名の変更
* ``prefix`` + ``.`` でウインドウ番号の変更

### ペイン
* ``Prefix`` + ``-`` でペインを横分割
* ``Prefix`` + ``\`` でペインを縦分割
* ``prefix`` + ``z`` でペインの最大化

* ``Prefix`` + ``o`` でペインをローテーションしながら移動

* ``prefixkey`` + ``j`` でペインの境界を下へ移動
* ``prefixkey`` + ``k`` でペインの境界を上へ移動
* ``prefixkey`` + ``h`` でペインの境界を左へ移動
* ``prefixkey`` + ``l`` でペインの境界を右へ移動

### その他
* ``prefix`` + ``t`` で時刻表示

## vim の設定

* 基本設定は、 ``dotfiles/.vimrc``
* インストールするプラグインの設定(NeoBundle の設定)は `dotfiles/.vim/vimrc_includes/plugins.vim`
* プラグイン自身の設定は、``dotfiles/.vim/vimrc_includes/xxx`` * これらは `.vimrc` から読み込まれる

## vim の使い方 (基本編)

* ``jj`` で挿入モードを抜けて、IME OFF (Karabiner 連動)
* ``<Leader>`` は、デフォルト（``\``） のまま
* ``00`` で空行挿入
* ``0i`` で空行挿入して下に1行開ける（自動的に挿入モードへ）
* インサートモードで、`<C-h>` でカーソルを左へ移動
* インサートモードで、`<C-l>` でカーソルを右へ移動
* ファイルをまたぐ（複数ファイルを扱う）操作は、基本的に ``,`` に統一
	* ``NERDTree`` の開閉は、``,e``
	* ``Tagbar`` の開閉は、``,t``
	* ``SrcExpl`` の開閉は、``,s``
	* ``grep`` は、``,g`` (``grep`` は Unite grep で ag を使用する)
	* ``Unite`` の開閉のみは、``<C-e>`` (最近開いたファイル) ``<C-p>`` （カレントディレクトリ）など

## vim の使い方（新規ファイル作成）

* ``:e%%`` に続けて新規作成するファイル名でカレントディレクトリにファイル作成
* または、`,e` で NERDTree 開いて、`ma`

## vim の使い方（移動編）

### バッファ
* ``[b`` で前のバッファへ
* ``]b`` で次のバッファへ
* ``[B`` で最初のバッファへ
* ``]B`` で最後のバッファへ

### ウインドウ
* ``:--`` で水平分割 （``<C-k>`` でも水平分割）
* ``:\\`` で垂直分割
* ``Ctrl + w + h`` で左のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + j`` で下のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + k`` で上のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + l`` で右のウインドウへ移動(vim デフォルト)
* ``Ctrl + ww`` でウインドウ間ローテーション

### ジャンプ

* ジャンプ（大移動）は、``<Space>`` に統一
	* ``<Space>o`` で、ジャンプリスト戻る
	* ``<Space>]`` 又は ``<Space>[``  で、対になるカッコへ
	* ``<Space>i`` で、ジャンプリスト進む
	* ``<Space>.`` で、直近の編集場所へ

* ジャンプ（中移動）は、``Shift`` に統一
	* ``<Shift>k`` で、画面最上段へ
	* ``<Shift>m`` で、画面中央へ
	* ``<Shift>j`` で、画面最下段へ
	* ``<Shift>h`` で、行頭へ
	* ``<Shift>l`` で、行末へ

### その他

* 対象の行を選択して ``zf`` で折り畳み（開くときは ``l``）
* 範囲を選択して ``=`` でインデント整形(vim デフォルト)
* 右インデントは ``<Shift>>>``(vim デフォルト)
* 左インデントは ``<Shift><<``(vim デフォルト)

## vim の使い方 (Unite)

* とりあえず、``<C-p>``（最近開いたファイル一覧） だけで十分便利
* ``<esc><esc>``, ``jj`` または ``,,`` で Unite を抜ける
* ``,,`` で、Unite ウインドウを前回閉じた状態で開く（:UniteResume） * 現在無効
* ``,g`` でカレントディレクトリ以下を grep 検索(Unite grep:)
* ``,cg`` でカーソル位置の単語を grep 検索(Unite grep:)

### Unite コマンド

|コマンド|内容|
|:---|:---|
|``<C-e>``または``,fr``|最近開いたファイル一覧（file_mru）|
|``<C-p>``または``,ff``|カレントディレクトリ以下のファイル一覧（file_rec）|
|``,fg``|カレントディレクトリ以下を grep|

* 新規ディレクトリ作成（``,fd``）と新規ファイル作成（``,fn``）は NERDTree で行った方がわかりやすい。

## vim の使い方 (NERDTree)

* ツリーのルートを変更すると自動的にカレントディレクトリも変更する
* ファイルを開くと自動的にツリーを閉じる
* NERDTree ウインドウ内での操作（キーバインド）はデフォルトのまま

### NERDTree 基本コマンド

|コマンド|内容|
|:---|:---|
|``,e``|ツリーの開閉|
|``?``|ヘルプ表示/非表示切り替え|
|``k``|カーソルを上へ移動|
|``j``|カーソルを下へ移動|
|``o``|ファイル開く|
|``i``|横分割してファイル開く|
|``s``|ウインドウを横に分割してファイルを開く|
|``ma``|新規ファイル/ディレクトリ作成（ファイル名の最後に ``/`` を付けるとディレクトリ作成）|
|``mc``|ファイルコピー|
|``md``|ファイル/ディレクトリ削除|
|``I``|隠しファイルの表示/非表示切りかえ|

## vim の使い方 (入力補完: SupreTab)

* ``TAB`` で入力補完
* スニペット展開可能であればスニペット展開 (SnipMate) が優先

## vim の使い方（入力補完： vim-emmet)

* `<emmet-leader>` は `<C-y>` (デフォルトのまま)
* `div.hoge` と入力して、`<emmet-leader>,` で `<div class="hoge"></div>` に展開
* ``div.hoge.foo[style="display: flex;"]`` で `<div class="hoge foo" style="display: flex;">` に展開
* [Emmit 公式チートシート](https://docs.emmet.io/cheat-sheet/)


## vim の使い方 (スニペット: SnipMate)

* ``TAB`` でスニペット補完
* スニペット展開できなければ入力補完 (SuperTab)

### スニペット登録

* ``<Leader>es`` で ``:~/.vim/snippets/`` が入力されるので、``php<TAB>`` で PHP 用のスニペット登録用ファイルを開く
)
* スニペット登録ファイルの場所は ``~/.vim/snippets/``
* スニペット登録ファイルは ``ファイルタイプ.snippets``
* なので PHP ファイル (xxx.php) に適用するには ``~/.vim/snippets/php.snippets``

### tags と PHP 辞書の作成

* 補完候補元は ``tags`` と PHP 辞書
* ``tags`` ファイル作成は ``ctags --languages=php -f tags $(pwd)``
* PHP 辞書作成は ``php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict``


## vim の使い方 (辞書/マニュアル検索: vim-ref)

* ``:refphp`` で PHP マニュアル検索（w/Unite）
* ``:refen <検索語句>`` で英語辞書で単語検索
* PHP 語句の上で ``Shift + k`` で PHP マニュアル検索

## vim の使い方 (grep 検索)

* 標準の ``vimgrep`` と ``ag`` が使える
* ``ag`` の方が高速
* ``:Ag % <検索文字列>`` でカレントバッファ内を検索して quickfix で開く
* ``:Ag <検索文字列>`` でカレントディレクトリ以下も再帰的に検索して quickfix で開く

## vim の使い方 (開発)

* ``,=`` でインデント整形

## vim の使い方 (PHP)

### use

* ファイル保存時に自動的に ``php -l`` 実行して結果を quickfix で開く
* class 名の上で ``<Leader>n`` で ``use`` 文自動挿入
* class 名の上で ``<Leader>nf`` で class フルパス表示
* 上記 ``<Leader>n`` と ``<Leader>nf`` は vim の カレントディレクトリに ``tags`` 必要
* ``use`` 文全体を選択して ``<Leader>su`` で短いもの順にソート

### getter/setter

* 変数宣言の行で ``<Leader>g`` で getter を自動挿入
* 変数宣言の行で ``<Leader>s`` で setter を自動挿入
* 変数宣言の行で ``<Leader>b`` で setter/getter を自動挿入
* 変数宣言の行で ``<Leader>p`` で setter/getter/both の自動挿入プロンプト表示

### コメント

* クラス/関数宣言の行で ``<Leader>d`` でドキュメントコメントを自動生成

### フォーマット

* ``<Leader>psr`` で psr-2 フォーマットへ整形

* ``ghq get https://github.com/[ベンダー名]/[レポジトリ名]`` でレポジトリ取得
* レポジトリ保存場所は、``~/.gitconfig`` で設定（``~/dev/src`` 指定済み）


## git 関連

### レポジトリ管理

* ``ghq`` で管理
* なのでレポジトリ追加は ``ghq add xxx/xxx``

### ワークフロー
* ``gg`` で git log 確認
* ``gs``, ``gd`` で変更箇所の確認
* ``ga`` でステージング
* ``gc`` でコミット
* ``wip`` で ``git commit -m "[wip] still working"

### 主なエイリアス
(1) ``~/.bash_profile`` で定義

* ``gg``		= ``git graph``
* ``gs``		= ``git status``
* ``gd``		= ``git diff``
* ``ga``		= ``git add``
* ``gc``		= ``git commit``
* ``gb``		= ``git branch``

(2) ``~/gitconfig`` で定義

* ``graph`` = ``log --graph --date-order --all --pretty=format:'%h %Cred%d %Cgreen%ad %Cblue%cn %Creset%s' --date=short``

## vagrant 関連

### 主なエイリアス

(1) ``~/.bash_profile`` で定義

* ``v`` = ``vagrant ssh``
* ``vu`` = ``vagrant up``
* ``vh`` = ``vagrant halt``
* ``vd`` = ``vagrant destroy``

(2) ``~/.bash_profile`` で定義（sandbox プラグイン用）

* ``von`` = ``vagrant sandbox on``
* ``voff`` = ``vagrant sandbox off``
* ``vrb`` = ``vagrant sandbox rollback``
* ``vc`` = ``vagrant sandbox commit``

## Docker 関連

docker がインストールされている場合、``nutsllc/docker-dd`` がインストールされる

* ``dd`` = ``docker-compose ${@}``
* ``ddu`` = ``docker-compose up``
* ``ddd`` = ``docker-compose down``
* ``dde`` = ``docker-compose exec ${@}``
* ``ddv`` = ``vim docker-compose.yml``

## インストール

### dotfiles 本体

```bash
# dotfiles のインストール
$ git clone -b bk https://github.com/ontheroadjp/dotfiles.git ~/
$ sh ~/dotfiles/install.sh
$ source ~/.bash_profile
```

### vim + lua のインストール

```
$ sudo yum install -y lua lua-devel
$ git clone https://github.com/vim/vim.git /usr/local/src
$ cd /usr/local/src
$ ./configure \
	--with-features=huge \
	--enable-multibyte \
	--enable-luainterp=dynamic \
	--enable-gpm \
	--enable-cscope \
	--enable-fontset
$ make -j4
$ make install
```

### NeoBundle のインストール

* ``install.sh`` 実行時に実行される

```
mkdir -p ~/.vim/bundle
git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
```

### vim プラグインのインストール

```bash
$ vim
:NeoBundleInstall
```

### peco のインストール

```bash
$ sh ~/dotfiles/bin/install_peco.sh
```

### tmux インストール（Mac のみ）

```
$ brew install tmux
```

### PHP マニュアルのインストール

```bash
mkdir -p ${HOME}/.vim/ref
wget -O ${HOME}/.vim/ref/php-manual.tar.gz http://jp2.php.net/get/php_manual_ja.tar.gz/from/this/mirror
tar xzf ${HOME}/.vim/ref/php-manual.tar.gz -C ${HOME}/.vim/ref
```

### PHP 辞書の作成

```bash
php -r '$f=get_defined_functions();echo join("\n",$f["internal"]);'|sort > ~/.vim/dict/php.dict
```

### tags ファイルの作成

```bash
ctags --languages=php -f tags `pwd`
```

### ag のインストール

```bash
brew install ag
```

### php-cs-fixer のインストール

```bash
composer global require fabpot/php-cs-fixer
PATH=$PATH:${HOME}/.composer/bin
```

## その他 Tool

### youtube

```bash
youtube-dl <DLする動画ページの URL>
```

### mplayer

```bash
mplayer <再生する動画/音楽ファイル>
```

## 変更履歴

### 1.3.0

* [Update] peco のバージョン変更

### 1.2.0

* [New] ディレクトリを保存できる mm コマンド nn コマンドを追加

### 1.1.2

* [New] vagrant-completion の追加

### 1.1.1

* [FIX] NeoBundle がインストール済みの場合には、再度インストールしないように変更

### 1.1.0

* [New] git-prompt の追加
* [New] git-completion の追加
* [Modified] vim で、``BS`` キーで改行を削除できるようにした
* [Fix] 軽微な Bugfix

###1.0.0

* 最初のリリース
