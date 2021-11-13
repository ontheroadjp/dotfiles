# dotfiles

* ``bash/zsh``, ``tmux``, ``vim``, ``git``, ``Docker`` の設定が中心
* 主なツール： ``peco``, ``ghq``, ``ag``, ``ctags``



### Mac

- ``Homebrew``, ``iTerm2``, ``karabiner``



## 主なディレクトリ構成

| ディレクトリ | パス                              |移動エイリアス|
| :--- | :--- | ---- |
| dotfiles | ``${HOME}/dotfiles``                              |``dot``|
| リポジトリ     | ``${HOME}/dev``                                    |``rr``|
| ワークスペース | ``${HOME}/WORKSPACE``                              |``ww``|
| クイックメモ | ``${HOME}/WORKSPACE/Dropbox/Documents/memo`` |``q``|
| メモ           | ``${HOME}/WORKSPACE/Dropbox/Documents/memo``       |``memo``|



## 主な PATH

- ``.``
- ``${HOME}/dotfiles/bin``



## shell (bash/zsh)



### ディレクトリ表示

* ``la`` で ``clear && ls -laG``
* ``lla`` または ``laa`` で サブディレクトリ 一覧を表示/選択して ``la`` 実行（peco）
* ``dirsize`` でディレクトリのサイズ表示（対象ディレクトリ指定ない場合はカレント）



### ディレクトリ移動

#### 基本

* ``cd`` すると自動的に ``la`` (``cd`` は ``pushd`` のエイリアス)
* ``b`` で一つ前の場所へ戻る (``popd``)
* ``.`` で ``pwd``
* ``..`` で一つ上の階層へ
* ``...`` で二つ上の階層へ
* ``....`` で三つ上の階層へ



#### ジャンプ & マーク（Dirmark）

* ``mm`` でカレントディレクトリを記憶し ``m`` で記憶したディレクトリへ移動
* ``nn`` でカレントディレクトリを記憶し ``n`` で記憶したディレクトリへ移動
* ``ii`` でカレントディレクトリを記憶し ``i`` で記憶したディレクトリへ移動
* ``oo`` でカレントディレクトリを記憶し ``o`` で記憶したディレクトリへ移動



#### ファイル/ディレクトリ コピー/移動補助（ShellStash）

- ``ss`` で Stash 一覧表示
- ``ss [ファイル/ディレクトリ]`` で Stash へ移動（``mv``）
- ``ss -c [ファイル/ディレクトリ]`` で Stash へコピー（``cp``）
- ``ss pop`` で ``peco`` 表示/選択してカレントディレクトリへ取り出す（``mv``）
- ``ss -c pop`` で ``peco`` 表示/選択してカレントディレクトリへ取り出す（``mv``）
- ``ss empty`` で Stash を空にする（空にすると元には戻せない）



#### ジャンプ & マーク（ローカル）

* ``cdd`` でカレントディレクトリ内のサブディレクトリを ``peco`` 表示/選択してディレクトリ移動
* ``cdh`` でディレクトリの訪問履歴を ``peco`` で表示/選択してディレクトリ移動
* ``cdm`` でディレクトリマーク一覧を ``peco`` で表示/選択してディレクトリ移動
* ``ww`` で ``~/WORKSPACE`` 内のディレクトリを ``peco`` で表示/選択してディレクトリ移動
* ``rr`` でリポジトリ（``${HOME}/dev``) を ``peco`` で表示/選択して移動
* リポジトリ内で ``G`` で Git ローカルリポジトリルートへ移動



#### ジャンプ & マーク（サーバー & web）

* ``vpn`` で SSH接続一覧 (``${HOME}/.ssh/config``) を ``peco`` で表示/選択してディレクトリ移動
* ``google [検索ワード]`` または ``g [検索ワード]`` で Google 検索
* ``web`` で ``peco`` でブックマーク一覧を表示/選択してブラウザで表示
    * ブックマークは ``~/dotfiles/.web_bookmark``
* ``stock`` で ``peco`` で上場銘柄一覧を表示/選択してブラウザで表示



#### Github（ローカルレポジトリ）へ移動

* ``rr`` で ``ghq`` 管理のレポジトリ一覧を ``peco`` で表示/選択してディレクトリ移動
* ``G`` でレポジトリルートへ移動



#### Github（リモートレポジトリ）へ移動

* ``rrgit`` で ``ghq`` 管理のレポジトリ一覧を ``peco`` で表示/選択してブラウザで開く
* ``myrepo`` で自分の Git リポジトリ一覧を ``peco`` で表示/選択してブラウザで開く
* ``github`` でカレントディレクトリの GitHub をブラウザで開く



#### その他ディレクトリへ移動

* ``dot``で ``${HOME}/dotfiles`` へ移動



### ファイルの移動/コピー ( Shell Stash )

- shell stash 使うと便利（``ss`` コマンドと ``ssp`` コマンド）
- ``ss`` で shell stash に保存されているファイル/ディレクトリの一覧を表示



#### shell stash へ入れる

- ``ss [ファイル/ディレクトリ]`` で shell stash へ移動（mv）
- ``ss -c [ファイル/ディレクトリ]`` で shell stash へコピーを移動（cp）



#### shell stash から取り出す

- 取り出し先は ``ssp`` コマンドを実行したディレクトリ

- ``ssp [ファイル/ディレクトリ]`` で shell stash から取り出す（mv）
- ``ssp -c [ファイル/ディレクトリ]`` で shell stash からコピーを取り出す（cp）

- ``ssp`` で shell stash にあるファイル/ディレクトリ一覧を ``peco`` で表示/選択して取り出す（mv）
- ``ssp -c`` で shell stash にあるファイル/ディレクトリ一覧を ``peco`` で表示/選択して取り出す（cp）



### 検索

* ``ff`` でカレントディレクトリ以下のファイル検索 (``find . -type f``)
* ``fd`` でカレントディレクトリ以下のディレクトリ検索 (``find . -type d``)
* ``fd --empty`` でカレントディレクトリ 以下の空のディレクトリ検索
* ``ffi`` でカレントディレクトリ以下の画像ファイル検索
* ``ffic`` でカレントディレクトリ以下の画像ファイル数カウント
* ``ff``, ``fd`` はディレクトリ指定可能
* ``ff``, ``fd`` にオプション（``--empty`` など）を指定する場合は検索対象ディレクトリを指定する



### その他エイリアス

* ``vp`` で ``.bash_profile`` を ``vim`` で開く
* ``sp`` で ``.bash_profile`` を再読み込み



### その他関数 & ミニアプリ

#### メモ

* ``p <メモの内容>`` で PromptMemo 追加（``p`` のみでプロンプトメモ消去）
* ``q`` で QuickMemo ファイル開く（``~/WORKSPACE/Dropbox/Documents/quick_note.md``）
    * ``quick_note.md`` 開いた日時が先頭行に自動追加
* ``memo`` で Note 一覧を ``peco`` で表示/選択して ``${MARKDOWN_EDITOR}`` で開く
* ``yubin`` で ``peco`` で郵便番号一覧を表示して検索



#### その他

* ``bk <対象ファイル or ディレクトリ>`` で、同じディレクトリにバックアップ作成（*.tag.gz)

* ``clock`` でタイムゾーン一覧が  ``peco`` で表示/選択して日時を表示する

    ```bash
    $ clock
    America/New_York: Wed Sep 30 06:09:47 EDT 2020
    ```

* ``wareki <数値>`` で和暦/西暦 対応を表示

    ```bash
    $ wareki 2020
    令和2年  2020
    ```

* ``holiday`` で日本の祝日・休日一覧を表示



## tmux

* 設定は ``~/.tmux.conf``
* プレフィックスキーは ``Ctrl`` + ``b`` （デフォルト）
* ``prefix`` + ``?`` で設定済みのキーバインド確認
* ``prefix`` + ``z`` でアクティブペイン拡大
* ``prefix`` + ``:`` でコマンド入力モードへ 



### セッション（キーバインドは全てデフォルト）

#### 基本操作（セッション間の移動）

1. ``prefix`` + ``s`` でセッション一覧を開く
2. ``j``又は ``k`` でセッション選択
3. 必要に応じて ``prefix`` + ``$`` でセッション名の変更
3. ``exit`` でセッション終了



#### コマンド

* ``prefix`` + ``s`` でセッション一覧 & セッション移動

* ``prefix`` + ``a`` でアタッチ

* ``prefix`` + ``d`` でデタッチ

* ``exit`` でセッション終了 → tmux を続ける場合は、

     既存セッションに接続する場合：``tmux a`` （又は ``tmux a -t [セッション名]``）

    新規セッションを作成する場合： ``tamux``



### ウインドウ（キーバインドは全てデフォルト）

#### 基本操作

1. ``prefix`` + ``c`` で新規ウインドウ作成
2. 必要に応じて ``prefix`` + ``,`` でウインドウ名の変更
3. ``prefix`` + ``n`` 又は ``prefix`` + ``p`` でウインドウ間の移動
4. ``prefix`` + ``&`` でウインドウ閉じる



#### コマンド

* ``prefix`` + ``w`` でウインドウ一覧 & ウインドウ移動
* ``prefix`` + ``c`` で新規ウインドウ作成
* ``prefix`` + ``n`` で次のウインドウへ移動
* ``prefix`` + ``1`` でウインドウ番号へ移動
* ``prefix`` + ``,`` でウインドウ名の変更
* ``prefix`` + ``.`` でウインドウ番号の変更



### ペイン

* ``prefix`` + ``q`` でペイン番号表示
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
* ``prefix`` + ``z`` でカレントペインを最大化



## vim の設定

* 基本設定は、 ``dotfiles/.vimrc``
* 設定されているキーバインド一覧を表示 ``:map``



### プラグイン

* 起動時にロードするプラグイン(NeoBundle の設定)は `dotfiles/.vim/vimrc_includes/plugins.vim`
* プラグイン自身の設定は、``dotfiles/.vim/vimrc_includes/xxx``
* これらは `.vimrc` から読み込まれる



## vim の使い方 (基本編)

* ``jj`` で挿入モードを抜けて、IME OFF (Karabiner 連動)
* ``<Leader>`` は、デフォルト（``\``）のまま
* モーションプレフィックスは ``スペースバー``
* ``00`` で空行挿入
* ``0i`` で空行挿入して下に1行開ける（自動的に挿入モードへ）
* ``Ctl`` + ``ss`` で ``:set filetype=bash``
* ``Ctl`` + ``n`` で行番号の表示/非表示切り替え
* インサートモードで、`<C-h>` でカーソルを左へ移動
* インサートモードで、`<C-l>` でカーソルを右へ移動
* ファイルをまたぐ（複数ファイルを扱う）操作は、基本的に ``,`` に統一
  * ``NERDTree`` の開閉は、``,e``
  * [Disabled] ``Tagbar`` の開閉は、``,t``
  * [Disabled] ``SrcExpl`` の開閉は、``,s``
  * ``grep`` は、``:Ag``
  * ``Unite`` の開閉のみは、``<C-e>`` (最近開いたファイル) ``<C-p>`` （カレントディレクトリ）など
* ``,c`` で Google Chrome 起動
* ``,s`` で Safari 起動



## vim の使い方（ファイル操作）

### 新規ファイル作成

* ``:pwd`` でカレントディレクトリを確認
* ``<Leader>cd``  で カレントディレクトリをカレントバッファのディレクトリへ変更
* ``<Leader>ww`` で ``~/WORKSPACE`` へカレントディレクトリを変更
* ``:e%%`` に続けて新規作成するファイル名でカレントディレクトリにファイル作成
* または、`,e` で NERDTree 開いて、`ma`
* ``:new`` で新規バッファ作成



### ファイルタイプ

- ``<Leader>`` + ``ft`` でカレントバッファのファイルタイプを表示
- ``c-s`` ``c-s`` で filetype を ``bash`` へ変更



### 新規テンプレート

- 拡張子が ``.vue`` のファイルを作成すると自動的に vue 専用のテンプレートで開く
- 拡張子が ``.sh`` のファイルを作成すると自動的に sh 専用のテンプレートで開く
- テンプレートの置き場所は ``dotfiles/.vim/templates/``
- ``:e%%[new file]`` で作成した時のみテンプレートが読み込まれる



### ファイル（バッファ）情報を見る

- ``<Leader>`` + ``ft`` でカレントバッファのファイルタイプを表示
- ``<Leader>`` + ``fp`` でカレントバッファのパスを表示
- ``<Leader>`` + ``enc`` でカレントバッファの文字コードを表示
- ``<Leader>`` + ``cd`` でカレントディレクトリをカレントバッファのっsレクトリへ変更





## vim の使い方（ウインドウ、バッファ、タブ）

### ウインドウ

* ``--`` で水平分割 （``<C-k>`` でも水平分割）
* ``\\`` で垂直分割
* ``Ctrl + w + c`` でカレントウインドウを閉じる
* ``Ctrl + w + h`` で左のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + j`` で下のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + k`` で上のウインドウへ移動(vim デフォルト)
* ``Ctrl + w + l`` で右のウインドウへ移動(vim デフォルト)
* ``Ctrl + ww`` でウインドウ間ローテーション



### バッファ

* ``<Leader>b`` でバッファ一覧表示
* ``:new`` で新規バッファ作成
* ``:bd`` でカレントバッファを閉じる
* ``[b`` で前のバッファへ
* ``]b`` で次のバッファへ
* ``[B`` で最初のバッファへ
* ``]B`` で最後のバッファへ



### タブ

- ``tn`` で新規タブ作成
- ``Ctrl-w`` + ``T`` で、分割されたバッファを新規タブで開く（デフォルト）
- ``<tab>`` で次のタブへ移動
- ``<Shift> + <tab>`` で次のタブへ移動
- ``t]`` でタブを右へ移動
- ``t[`` でタブを左へ移動
- ``[タブNo]gt`` で指定したタブへ移動（デフォルト）
- ``:tabo`` で現在のタブ以外を全て閉じる（デフォルト）



## vim の使い方（移動編）

### ジャンプ

* ジャンプ（大移動）は、``<Space>`` に統一
    * ``<Space>o`` で、ジャンプリスト戻る
    * ``<Space>]`` 又は ``<Space>[``  で、対になるカッコへ
    * ``<Space>i`` で、ジャンプリスト進む
    * ``<Space>.`` で、直近の編集場所へ

* ジャンプ（中移動）は、``Shift`` に統一
    * ``<Shift>k`` で、画面最上段へ
    * ``<Shift>m`` で、画面中央へ
    * ``<Shift>j`` で、画面最下段へ ← デフォルトの下段行と連結と被るので設定なし
    * ``<Shift>h`` で、行頭へ
    * ``<Shift>l`` で、行末へ






## vim の使い方（検索編）

- 検索方法は 3つ
    - ``/[検索ワード]`` で検索
    - ``:vim [検索ワード] %`` でカレントバッファを grep 検索
    - ``:Ag [検索ワード] %`` でカレントバッファを grep 検索（ag.vim プラグイン ）
- ``:vim [検索ワード] %`` でカレントバッファを検索して検索結果を QuickFix で開く
- ``:vim [検索ワード] ./src'' で ``./src`` ディレクトリのファイル内を検索
* ``ag`` の方が高速



### ag.vim

- 検索方法は ``:Ag [検索ワード] [検索対象]``

- ``%`` はカレントバッファ
- なので ``:Ag [検索ワード] %`` でカレントバッファ内を検索
- 検索対象を指定しないとカレントディレクトリ 配下全体を grep
- 検索結果は Quickfix ウインドウで一覧表示



#### 検索結果（Quickfix ウィンドウ）で結果の行を選択してキーを押したときの挙動

| キー | 挙動                                               |
| ---- | -------------------------------------------------- |
| e    | ファイルを開く（Quickfixを閉じる）                 |
| o    | ファイルを開く（Quickfixは閉じない）               |
| go   | ファイルを開くが、フォーカスはQuickfix             |
| t    | ファイルを新しいタブで開く                         |
| T    | ファイルを新しいタブで開くが、フォーカスはQuickfix |
| h    | ファイルを水平分割して開く                         |
| H    | ファイルを水平分割して開くが、フォーカスはQuickfix |
| v    | ファイルを垂直分割して開く                         |
| gv   | ファイルを垂直分割して開くが、フォーカスはQuickfix |
| q    | Quickfixを閉じる                                   |





### その他

* 対象の行を選択して ``zf`` で折り畳み（開くときは ``l``）
* 範囲を選択して ``=`` でインデント整形(vim デフォルト)
* 右インデントは ``<Shift>>>``(vim デフォルト)
* 左インデントは ``<Shift><<``(vim デフォルト)



## vim の使い方 (Unite)

* とりあえず、``<C-p>``（最近開いたファイル一覧） だけで十分便利
* ``<esc><esc>``, ``jj`` または ``,,`` で Unite を抜ける
* [Disabled] ``,,`` で、Unite ウインドウを前回閉じた状態で開く（:UniteResume）
* [Disabled]``,g`` でカレントディレクトリ以下を grep 検索(Unite grep:)
* [Disabled] ``,cg`` でカーソル位置の単語を grep 検索(Unite grep:)



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



## vim の使い方（surround）

### カーソル位置を囲む

- ``ysiw(`` で ``sample`` を ``( sample )`` へ　
- ``ysiw)`` で ``sample`` を ``(sample)`` へ
- ``yes)`` で ``hello world`` を ``(hello world)`` へ（行全体を囲む）



### 選択範囲を囲む

- 括弧で括りたい部分をビジュアルモードで選択して ``S`` に続けて ``(`` ``{`` ``<`` などをタイプ
- なので ``viwS{`` で ``sample`` が ``{ sample }`` へ
- 上記 ``sample`` の両端にスペースが入らないようにするためには ``viwSB`` 
- 括弧は ``b`` で ``)``、``B`` で ``}`` 、``r`` で ``]``、``a`` で ``>`` と同等（例： ``viwSb`` で ``sample`` が ``(sample)`` へ）



### 囲む（Tips）

- 括弧の開き側（``(``, ``{``, ``<``など）を使うと括ったときにスペースが入る
- 括弧の閉じ側（``)``, ``}``, ``>``など）を使うと括ったときにスペースが入らない
- 括弧は ``b`` で ``)``、``B`` で ``}`` 、``r`` で ``]``、``a`` で ``>`` と同等（例： ``viwSb`` で ``sample`` が ``(sample)`` へ）



### タグ（\<tag>sample\</tag>）で囲む

-  ``t`` または ``<`` で任意のタグが囲める（例： ``viwStli>`` で ``sample`` が ``<li>sample</li>`` へ）



### filetype=sh, or bash の場合

- ``V`` （大文字）で ``${}`` で囲む。なので、``viwSV`` で ``sample`` が ``${sample}`` へ
- ``v`` （小文字）で ``$()`` で囲む 。なので、``viwSv`` で ``sample`` が ``$(sample)`` へ



### 削除

- ``dt(`` で、囲んでいる ``()`` を削除
- ``dt"`` で、囲んでいる ``""`` を削除



### 変更

- `cs(}` で ``(sample)`` が ``{sample}`` へ
- ``cs"(`` で ``"sample"`` が ``( sample )`` へ



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

* ``:dicphp`` で PHP マニュアル検索（w/Unite）
* ``:dicfen <検索語句>`` で英語辞書で単語検索
* PHP 語句の上で ``Shift + k`` で PHP マニュアル検索
* 設定は ``.vim/vimdc_includs/vim-ref.vim``



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
* なのでレポジトリ追加は ``ghq get xxx/xxx``



### ワークフロー

* ``gg`` で git log 確認
* ``gs``, ``gd`` で変更箇所の確認
* ``ga`` でステージング
* ``gc`` でコミット



### 主なエイリアス

####  ``~/.bash_profile`` で定義

* ``gg``		= ``git graph``
* ``gs``		= ``git status``
* ``gd``		= ``git diff``
* ``ga``		= ``git add``
* ``gc``		= ``git commit``
* ``gb``		= ``git branch``



####  ``~/gitconfig`` で定義

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

* 設定ファイル ``~/.config/peco/config.json``



### tmux インストール（Mac）

```bash
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



## その他主な Tool

### YouTube

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
