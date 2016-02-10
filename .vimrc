
cnoremap vim source ~/.vimrc

"-------------------------
"カラースキーマー
"-------------------------

" 基本 
colorscheme desert
"colorscheme solarized

" 黒背景
"colorscheme hybrid

" 柔らかい
"colorscheme lucius
"set background=dark

" 柔らかい
"colorscheme Tomorrow-Night-Eighties

"let g:base16_shell_path = expand('~/.config/base16-shell/')
"let base16colorspace="256"
"set t_Co=256
"set background=dark
"
"if has('unix')
"	colorscheme base16-ocean
"endif

"colorscheme base16-eighties
"colorscheme base16-ocean

"-------------------------
" vim ステータスライン
"-------------------------

set laststatus=2
set statusline=%<     " 行が長すぎるときに切り詰める位置
set statusline+=[%n]  " バッファ番号
set statusline+=%m    " %m 修正フラグ
set statusline+=%r    " %r 読み込み専用フラグ
set statusline+=%h    " %h ヘルプバッファフラグ
set statusline+=%w    " %w プレビューウィンドウフラグ
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
set statusline+=%y    " バッファ内のファイルのタイプ
set statusline+=\     " 空白スペース
if winwidth(0) >= 130
	set statusline+=%F    " バッファ内のファイルのフルパス
else
	set statusline+=%t    " ファイル名のみ
endif
set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示（tpope/fugitive プラグイン使う）
set statusline+=\ \   " 空白スペース2個
set statusline+=%1l   " 何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%c    " 何列目にカーソルがあるか
set statusline+=%V    " 画面上の何列目にカーソルがあるか
set statusline+=\ \   " 空白スペース2個
set statusline+=%P    " ファイル内の何％の位置にあるか

" ステータスラインの色を変える
au InsertEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=white cterm=none

"-------------------------
"基本
"-------------------------

" 文字コード
"set encoding=utf-8
set encoding=utf-8 nobomb
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" 行番号表示
set number

" 折り返しなし
set nowrap

" BackSpace キーで改行を削除できるように
set backspace=2

" ESC の代わりに jj  
inoremap <silent> jj <esc>

" ESC の代わりに <leader><leader>
vnoremap <leader><leader> <esc>

" <Leader> の変更
"let mapleader = "\<Space>"
"map , <leader>

" 変更があれば保存
"noremap <leader><leader> :up<CR>

" 矩型選択モードへ
nnoremap <Leader><Leader> <C-v>

" w!! で sudo で保存
cabbr w!! w !sudo tee > /dev/null %

"-------------------------
" 検索 Search
"-------------------------

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase

" インクリメンタルサーチ
set incsearch

" n, N キーで「次の（前の）検索候補」を画面の中心に表示する
nnoremap n nzz
nnoremap N Nzz

" / で検索して、cs で置換して<esc>. その後は n.n.n. で内容確認しながら置換
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
			\:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

"-------------------------
"PHP 設定 :help 参照のこと
"-------------------------
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1

"-------------------------
"DB 設定
"-------------------------
let g:sql_type_default='mysql'

"-------------------------
"バックアップファイル
"-------------------------
"set backup
"set backupdir=~/.vim/backup
set nobackup

"-------------------------
"スワップファイル
"-------------------------
"set swapfile
"set directory=~/.vim/swap
set noswapfile

"-------------------------
"タブ & インデント
"-------------------------

"タブを空白文字(<space>)に置き換える
set expandtab

"インデントの幅
set tabstop=4

"自動インデントでずれる幅
set shiftwidth=4

"連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=4

"改行時に前の行のインデントを継続する
set autoindent

"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

"-------------------------
"ヤンク&ペースト
"-------------------------

"ペースト後にカーソルが下側に移動するように入れ替え
nnoremap p gp
nnoremap P gP
nnoremap gp p
nnoremap gP P

"-------------------------
" 自動的に閉じ括弧を入力
"-------------------------
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>

"-------------------------
" キーバインド key bindings
"-------------------------

" ウインドウ間の移動（Karabiner でさらに再設定）
nnoremap <c-w> <c-w><c-w>

" モーション移動のコマンド ` を <Space> で置き換え
nnoremap <Space> `
"nnoremap <Space><Space> ``

" ジャンプリスト（戻る）
nnoremap <Space>o <c-o>zz

" ジャンプリスト（進む）
nnoremap <Space>i <c-i>zz

" 行頭、行末への移動
nnoremap <Space>h ^
nnoremap <Space>l $
vnoremap <Space>h ^
vnoremap <Space>l $

" 行移動
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

"f 移動の後戻る
nnoremap <Space>; ,

"空行の挿入
nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j

"定義元へのジャンプ
nnoremap <Space>] g<c-]>

"対になるカッコへジャンプ
nnoremap <Space>[ %

"行番号を指定してジャンプ
"nnoremap {count}<Space> {count}G

"---------------------------------------------------------------------------
" NeoBundle の設定
" プラグインのインストール .vimrc に記述のち、:NeoBundleInstall を実行
" プラグインのアンインストール .vimrc の記述を削除したのち、:NeoBundleClean を実行
"---------------------------------------------------------------------------

set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neobundle.vim'

    "-------------------------
    " Core スクリプトの非同期実行
    "-------------------------
	NeoBundle 'Shougo/vimproc', {
				\ 'build' : {
				\     'windows' : 'make -f make_mingw32.mak',
				\     'cygwin' : 'make -f make_cygwin.mak',
				\     'mac' : 'make -f make_mac.mak',
				\     'unix' : 'make -f make_unix.mak',
				\    }
				\ }
    
    "-------------------------
    " Unite, NERDTree, Tagbar, SourceExplorer
    "-------------------------
	NeoBundle 'Shougo/unite.vim'    		" Unite: ファイルオープンを便利に
	NeoBundle 'Shougo/neomru.vim'   		" Unite: 最近使ったファイルを表示できるようにする
	NeoBundle 'Shougo/unite-outline'		" Unite: 変数/関数の一覧を表示
	NeoBundle 'tsukkee/unite-tag'          	" Unite: ctags の Unite 連携
	NeoBundle 'scrooloose/nerdtree'       	" NERDTree 表示

	NeoBundle 'majutsushi/tagbar'           " Tagbar 表示
	"NeoBundleLazy 'majutsushi/tagbar', {    " Tagbar 表示
    "    \ 'autoload': { 'commands': ['TagbarToggle'] }
    "    \ }

	NeoBundle 'wesleyche/SrcExpl'           "カーソル位置のファイル参照
	"NeoBundleLazy 'wesleyche/SrcExpl', {    "カーソル位置のファイル参照
    "    \ 'autoload' : { 'commands': ['SrcExplToggle'] }
    "    \ }

    "-------------------------
    " for Development
    "-------------------------
	NeoBundle 'thinca/vim-quickrun'	    	" コード片の実行
	NeoBundle 'tpope/vim-fugitive'	    	" git コマンド使えるようにする
    NeoBundle 'Shougo/neosnippet'           " スニペット
	NeoBundle 'Shougo/neosnippet-snippets'  " 基本スニペット集
	if has('lua')					    	" 入力補完
	  NeoBundleLazy 'Shougo/neocomplete.vim', {
	      \ 'depends' : 'Shougo/vimproc',
	      \ 'autoload' : { 'insert' : 1,}
	      \ }
    else
        NeoBundleLazy 'Shougo/neocomplcache'
            let g:nocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_ignore_case = 1
            let g:neocomplcache_enble_smart_case = 1
	endif

    "-------------------------
    " for PHP
    "-------------------------
    NeoBundle 'violetyk/neocomplete-php.vim' " PHP入力補完に説明追加
	NeoBundle 'joonty/vdebug'	    		 " xdebug クライアント	
    NeoBundle 'PDV--phpDocumentor-for-Vim'   " Doc コメントを簡単に追加

    "-------------------------
    " Utilities
    "-------------------------
	NeoBundle 'rking/ag.vim'	    		 " grep に ag 使う
    NeoBundle 'thinca/vim-ref'               " 辞書検索(PHP マニュアル/英語辞書の閲覧)
    NeoBundle 'fuenor/qfixhowm'              " 簡単にメモを取る

    "-------------------------
    " minor leage
    "-------------------------
	"NeoBundle 'tpope/vim-markdown'          " Markdown 用
	"NeoBundle 'tyru/open-browser.vim'       " ブラウザプレビュー

    "NeoBundle 'm2mdas/phpcomplete-extended' " PHP 入力補完
	"NeoBundle 'm2mdas/phpcomplete-extended-laravel' "Laravel 入力補完
	"NeoBundle 'chriskempson/base16-vim'     " カラースキーマー
	"NeoBundle 'jpalardy/vim-slime'
	"NeoBundle 'scrooloose/syntastic'        " シンタックスチェック

    call neobundle#end()
endif

filetype plugin indent on
filetype indent on
syntax on

"---------------------------------------------------------------------------
" Tagbar の設定
" http://rcmdnk.github.io/blog/2014/07/25/computer-vim/#tagbar-srcexpl-nerdtree
"---------------------------------------------------------------------------
if ! empty(neobundle#get("tagbar"))
	" Width (default 40)
	let g:tagbar_width = 30
	" Map for toggle
	"nn <silent> <leader>t :TagbarToggle<CR>
    nn <silent> ,t :TagbarToggle<CR>
endif

"---------------------------------------------------------------------------
" Sorce Explorer の設定
"---------------------------------------------------------------------------
if ! empty(neobundle#get("SrcExpl"))

    " Set refresh time in ms
    let g:SrcExpl_RefreshTime = 1000 "1秒
    
    " Is update tags when SrcExpl is opened
    let g:SrcExpl_isUpdateTags = 0

    " Tag update command
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'

    " Update all tags
    function! g:SrcExpl_UpdateAllTags()
        let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -R .'
        call g:SrcExpl_UpdateTags()
        let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
    endfunction

    " Source Explorer Window Height
    let g:SrcExpl_winHeight = 14
    
    " Mappings
    nn [srce] <Nop>
    nm <Leader>n [srce]
    nn <silent> [srce]<CR> :SrcExplToggle<CR>
    nn <silent> [srce]u :call g:SrcExpl_UpdateTags()<CR>
    nn <silent> [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
    nn <silent> [srce]n :call g:SrcExpl_NextDef()<CR>
    nn <silent> [srce]p :call g:SrcExpl_PrevDef()<CR>

endif

"---------------------------------------------------------------------------
" QFixHowm
"---------------------------------------------------------------------------
"使い方(https://sites.google.com/site/fudist/Home/qfixhowm/quick-start)

"g,c メモを作成する
"g,<Space> メモを作成する（同一ファイル）
"g,j メモを作成する（開いているバッファに紐付け）

"g,m 最近閲覧/作成/更新したリストを表示
"g,g メモを検索する 

"g,u クイックメモ

"<C-w>, Quickfix ウインドウの開閉
"---------------------------------------------------------------------------

"QFixHowmキーマップ
let QFixHowm_Key = 'g'

"保存先
let howm_dir = '~/Dropbox/memo'

"保存ファイル名
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'

"ファイルのエンコード
let howm_fileencoding = 'utf-8'

"ファイルの改行コード
let howm_fileformat = 'unix'

"タイトル記号
let QFixHowm_Title = '#'

"タイトル行検索正規表現の辞書を初期化
let QFixMRU_Title = {}

"MRUでタイトル行とみなす正規表現(Vimの正規表現で指定)
let QFixMRU_Title['mkd'] = '^###[^#]'

"grepでタイトル行とみなす正規表現(使用するgrepによっては変更する必要があり)
let QFixMRU_Title['mkd_regxp'] = '^###[^#]'

let QFixHowm_DiaryFile = 'diary/%Y/%m/%Y-%m-%d-000000.howm'


"---------------------------------------------------------------------------
" PDV-phpDocumentor for Vim の設定
" http://www.phpdoc.org/
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("PDV--phpDocumentor-for-Vim"))

    nnoremap <Leader>d :call PhpDocSingle()<CR>

"endif

"---------------------------------------------------------------------------
" neocomplete の設定
"---------------------------------------------------------------------------
if ! empty(neobundle#get("neocomplete"))

    " 色の指定
    " 1: red
    " 2: green
    " 3: yellow
    " 4: blue
    " 5: red
    " 6: cyan
    " 7: white
    " 8: black
    " 9: black
    
    hi Pmenu ctermbg=7 "背景の色
    hi PmenuSel ctermbg=6 "選択項目の色
    "hi PMenuSbar ctermbg=4
    
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_camel_case = 1
    let g:neocomplete#use_vimproc = 1
    
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
    
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
            \ }
    
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
      " For no inserting <CR> key.
      "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
    
    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1
    
    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
    
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
    
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    
    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

endif

"---------------------------------------------------------------------------
" neocomplete-php の設定
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("neocomplete-php"))

    let g:neocomplete_php_locale = 'ja'

"endif

"---------------------------------------------------------------------------
" NERDTree の設定
" https://github.com/oouchida/vimrc/blob/master/vim_conf/nerd_tree.vim
"---------------------------------------------------------------------------
if ! empty(neobundle#get("nerdtree"))

    " ツリー開閉のキーバインド
    "nnoremap <silent><C-e> :NERDTreeToggle<CR>
    "nnoremap <Leader>e :NERDTreeToggle<CR>
    nnoremap ,e :NERDTreeToggle<CR>
    
    " デフォルトでツリーを表示
    "autocmd VimEnter * execute 'NERDTree'
    
    "ツリーを開く場所 - left または right
    "let g:NERDTreeWinPos="left"
    
    "ツリーの幅 "初期値31
    "let g:NERDTreeWinSize=45
    
    "ツリーで行番号を表示する
    let g:NERDTreeShowLineNumbers=1
    
    " デフォルトでブックマークを表示
    let g:NERDTreeShowBookmarks=1
    
    "ブックマークファイル名 - 初期値: $HOME/.NERDTreeBookmarks
    "let g:NERDTreeBookmarksFile=
    
    "表示しないファイル設定 - 初期値 ['\~$']
    let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
    
    " 隠しファイルをデフォルトで表示させる
    " let NERDTreeShowHidden = 1
    
    " ファイルを開いたら自動で閉じる
    let g:NERDTreeQuitOnOpen=1
    
    "他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    
    "ツリー表示でカレントディレクトリの変更
    "初期値(0) -  0:行わない、1:変更を行えるようにする、2:自動的に変更する 
    let g:NERDTreeChDirMode=2
    
    " ファイル拡張子の色を変える
    function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.a:extension .'$#'
    endfunction
    
    call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
    call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
    call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
    call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
    call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
    call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
    call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
    call NERDTreeHighlightFile('php', 'green', 'none', '#ff00ff', '#151515')
    
    "カラー表示する - 初期値(1):カラー表示
    ""let g:NERDChristmasTree=1
    
    "カーソル位置の自動調節を行うか - 初期値(1):自動調節
    ""let g:NERDTreeAutoCenter=1
    
    "カーソルの自動調節位置設定 - 初期値(3)
    ""let g:NERDTreeAutoCenterThreshold
    
    "ファイル表示の自動ソート - 初期値(0):ソートを行わない
    "let g:NERDTreeCaseSensitiveSort=1
    
    "カーソルラインをハイライト表示 - 初期値(1):行う
    "let g:NERDTreeHighlightCursorline=1
    
    "セカンドツリーを表示を有効に ":edit <ディレクトリ名> " - 初期値(1):有効
    "let g:NERDTreeHijackNetrw=1
    
    "マウスでの操作 - 初期値(1)
    "1: ダブルクリックでファイル・ディレクトリが開く
    "2: ディレクトリはダブルクリック・ファイルはシングルクリックで開く
    "3: シングルクリックでファイル・ディレクトリが開く
    let g:NERDTreeMouseMode=3
    
    "ツリーにファイル名を表示する - 初期値(1):表示する
    "let g:NERDTreeShowFiles=1
    
    "ソートを行う時の、表示順番設定 (正規表現で設定) - 初期値 ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
    "let g:NERDTreeSortOrder=
    
    "ステータス表示 - 初期値: %{b:NERDTreeRoot.path.strForOS(0)}
    "let g:NERDTreeStatusline=
    
    "ブックマークやヘルプのショートカットを表示 - 初期値(0):表示する
    "let g:NERDTreeMinimalUI=0
    
    "古い形式である|と+と~の記号だけでツリー表示 - 初期値(1):グラフィカルに表示する
    "let g:NERDTreeDirArrows=0

endif

"---------------------------------------------------------------------------
" Unit.vimの設定
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("unite"))

    " 入力モードで開始する
    let g:unite_enable_start_insert=1
    
    " 大文字小文字を区別しない
    let g:unite_enable_ignore_case = 1
    let g:unite_enable_smart_case = 1
    
    " ESCキーを2回押すと終了する
    au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
    
    " , キーを2回押すと終了する
    au FileType unite nnoremap <silent> <buffer> ,, :q<CR>
    au FileType unite inoremap <silent> <buffer> ,, <ESC>:q<CR>
    
    " ウィンドウを分割して開く
    au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    
    " ウィンドウを縦に分割して開く
    au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
    
    " ----------------------------
    "" unite.vim {{{
    " The prefix key.
    nnoremap    [unite]   <Nop>
    "nmap    <Leader>f [unite]
    nmap    ,f [unite]
    
    " unite.vim keymap
    nnoremap [unite]u  :<C-u>Unite -no-split<Space>
    nnoremap <silent> [unite]f :<C-u>Unite<Space>file_rec<CR>
    nnoremap <silent> [unite]c :<C-u>Unite<Space>file<CR>
    nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
    nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
    nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
    nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
    nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
    nnoremap <silent> [unite]p :<C-u>Unite<Space>file_point<CR>
    nnoremap <silent> [unite]y :<C-u>Unite<Space>register<CR>
    nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
    nnoremap <silent> [unite]d :<C-u>Unite<Space>directory/new<CR>
    nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
    nnoremap <silent> [unite]t :<C-u>Unite<Space>outline<CR>
    nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
    nnoremap <silent> ,, :UniteResume<CR>
    "" }}}

"endif

"---------------------------------------------------------------------------
" rking/ag(grep → ag) の設定
"---------------------------------------------------------------------------

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif


"---------------------------------------------------------------------------
" taglist の設定
"---------------------------------------------------------------------------

""tags ファイルの場所指定
"set tags=tags
"
""ctag コマンドのパス
"let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
"
""現在編集中のソースのタグしか表示しない
""let Tlist_Show_One_File = 1 
"
""taglist が最後のウインドウなら vim を閉じる
""let Tlist_Exit_OnlyWiindow = 1 
"
"" tagsジャンプの時に複数ある時は一覧表示                                        
""nnoremap <C-]> g<C-]>
"
"" ツリー開閉のキーバインド(Karabiner で再割り当て)
"nnoremap <silent><C-l> :TlistToggle<CR>
"
""新しいタブで開く
""map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"
""縦分割して開く
""nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
"
""横分割して開く
"nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>


"---------------------------------------------------------------------------
" Vdebug の設定
" <F5>: デバッガの起動 / 次のブレイクポイントまで移動
" <F2>: ステップオーバー
" <F3>: ステップイン
" <F4>: ステップアウト
" <F6>: デバッガの停止
" <F7>: デバッガーからデタッチ
" <F9>: カーソル行まで実行
" <F10>: ブレイクポイントの設定
" <F11>: show context variables (e.g. after "eval")
" <F12>: カーソル行の変数を評価
" :Breakpoint <type> <args>: 色んな種類のブレイクポイントが打てる。 (see :help VdebugBreakpoints)
" :VdebugEval <code>: <code>の変数を評価
" <Leader>e: evaluate the expression under visual highlight and display the " result
"---------------------------------------------------------------------------

let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F1>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "<F6>",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<F10>",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<F12>",
\}

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : '',
\    "remote_path" : "",
\    "local_path" : "",
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\}


"---------------------------------------------------------------------------
" QuickRun の設定(Markdown用)
" 参考: http://qiita.com/us10096698/items/1ac05c5c9543d2f79fa3
" .md ファイルがシンタックスハイライト有効に
" \r で実行 
"---------------------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
			\   'outputter': 'browser'
			\ }


"---------------------------------------------------------------------------
" thinca/vim-ref の設定
" テキストブラウザ（lynx）使う
"
" 使い方
" :man 検索ワード(ex. :man ls)
" :phpm 検索ワード(ex. :phpm echo)
" :eng 検索ワード(ex. :dic happy)
"---------------------------------------------------------------------------
"lynx.cfg の場所(Homebrew でlynx をインストールした場合)
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg

"lynx.cfg の場所(HMacPorts で lynx をインストールした場合)
"/opt/local/etc/lynx.cfg


"---------------------------------------------------------------------------
" man の設定
"---------------------------------------------------------------------------
cnoremap man Ref man<Space>

"---------------------------------------------------------------------------
" PHP Manual の設定
"---------------------------------------------------------------------------
let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'
cnoremap phpm Ref phpmanual<Space>


"---------------------------------------------------------------------------
" webdictでalcを使う設定
"---------------------------------------------------------------------------
let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
let g:ref_source_webdict_use_cache = 1
let g:ref_source_webdict_sites = {
			\ 'alc' : {
			\   'url' : 'http://eow.alc.co.jp/%s/UTF-8/'
			\   }
			\ }
function! g:ref_source_webdict_sites.alc.filter(output)
	return join(split(a:output, "\n")[29 :], "\n")
endfunction

cnoremap dic Ref webdict alc<Space>


"---------------------------------------------------------------------------
" Dash.app 連携
"---------------------------------------------------------------------------
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>
"au FileType nim  nmap K :DashNim<CR>\|:redraw!<CR>


" NeoBundle 関連はここまで
"---------------------------------------------------------------------------

" filetypeの自動検出(最後の方に書いた方がいいらしい)
filetype on


