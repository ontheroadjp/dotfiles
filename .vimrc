
" vim ステータスライン
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
set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
set statusline+=\ \   " 空白スペース2個
set statusline+=%1l   " 何行目にカーソルがあるか
set statusline+=/
set statusline+=%L    " バッファ内の総行数
set statusline+=,
set statusline+=%c    " 何列目にカーソルがあるか
set statusline+=%V    " 画面上の何列目にカーソルがあるか
set statusline+=\ \   " 空白スペース2個
set statusline+=%P    " ファイル内の何％の位置にあるか


"-------------------------
"基本
"-------------------------
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

set number
inoremap <silent> jj <esc>

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
"バックアップ
"-------------------------
"set backup
"set backupdir=~/.vim/backup
set nobackup

"-------------------------
"スワップ
"-------------------------
"set swapfile
"set directory=~/.vim/swap
set noswapfile

"-------------------------
"カラースキーマー
"-------------------------
colorscheme desert

"-------------------------
"タブ設定
"-------------------------

"タブ入力を複数の空白文字に置き換える
"set expandtab

"画面上でタブ文字が占める幅
set tabstop=2

"自動インデントでずれる幅
set shiftwidth=2

"連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set softtabstop=2

"改行時に前の行のインデントを継続する
set autoindent

"改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent


""""""""""""""""""""""""""""
" 自動的に閉じ括弧を入力
""""""""""""""""""""""""""""
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>


"-------------------------
" キーバインドの設定
"-------------------------
" Shift + 矢印でウインドウサイズを変更
nnoremap <S-Left> <C-w>><CR>
nnoremap <S-Right> <C-w><<CR>
nnoremap <S-Up> <C-w>-<CR> "動かない？
nnoremap <S-Down> <C-w>+<CR> "動かない？

" Ctrl + hjkl でウインドウ間を移動
"nnoremap <S-h> <C-w>h
"nnoremap <S-j> <C-w>j
"nnoremap <S-k> <C-w>k
"nnoremap <S-l> <C-w>l

" 行頭、行末への移動
nnoremap <Space>h ^
nnoremap <Space>l $
vnoremap <Space>h ^
vnoremap <Space>l $

"-------------------------
" NeoVundle の設定
" プラグインのインストール .vimrc に記述のち、:NeoBundleInstall を実行
" プラグインのアンインストール .vimrc の記述を削除したのち、:NeoBundleClean を実行
"-------------------------

set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
		NeoBundleFetch 'Shougo/neobundle.vim'
		NeoBundle 'Shougo/neobundle.vim'
		NeoBundle 'Shougo/vimproc'
		NeoBundle 'Shougo/unite.vim'	"ファイルオープンを便利に
		NeoBundle 'Shougo/neomru.vim'	"最近使ったファイルを表示できるようにする
		NeoBundle 'thinca/vim-ref'		"PHP マニュアルの閲覧
		NeoBundle 'rking/ag.vim'			"grep に ag 使う
		NeoBundle 'tpope/vim-markdown'		"Markdown 用
		NeoBundle 'tyru/open-browser.vim'	"ブラウザプレビュー
		NeoBundle 'thinca/vim-quickrun'		"コード片の実行
		NeoBundle 'Yggdroot/indentLine'		"インデントの可視化
		NeoBundle 'tpope/vim-fugitive'		"git コマンド使えるようにする
		"NeoBundle 'Shougo/vimshell'
		"NeoBundle 'Shougo/neocomplcache'
		"NeoBundle 'Shougo/neosnippet'
		"NeoBundle 'jpalardy/vim-slime'
		"NeoBundle 'scrooloose/syntastic'
	call neobundle#end()
endif

filetype plugin indent on
filetype indent on
syntax on

let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'

""""""""""""""""""""""""""""""
" Unit.vimの設定
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""

" 入力モードで開始する
let g:unite_enable_start_insert=1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

 " ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

"""""""""""""""""""""""""""""""
"" unite.vim {{{
"The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
  
" unite.vim keymap
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]p :<C-u>Unite<Space>file_point<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory/new<CR>
nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>
"" }}}

"" grep検索
"nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
"
"" カーソル位置の単語をgrep検索
"nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"
"" grep検索結果の再呼出
"nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
"
"" unite grep に ag(The Silver Searcher) を使う
"if executable('ag')
"	let g:unite_source_grep_command = 'ag'
"	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"	let g:unite_source_grep_recursive_opt = ''
"endif

""""""""""""""""""""""""""""""
" indentLine の設定
""""""""""""""""""""""""""""""
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '¦' "use ¦, ┆ or │

""""""""""""""""""""""""""""""
" QuickRun の設定(Markdown用)
" 参考: http://qiita.com/us10096698/items/1ac05c5c9543d2f79fa3
" .md ファイルがシンタックスハイライト有効に
" \r で実行 
""""""""""""""""""""""""""""""
  let g:quickrun_config = {}
  let g:quickrun_config['markdown'] = {
        \   'outputter': 'browser'
              \ }

""""""""""""""""""""""""""""""
" thinca/vim-ref の設定
""""""""""""""""""""""""""""""
"lynx.cfg の場所

"Homebrew でlynx をインストールした場合
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg

"MacPorts で lynx をインストールした場合
"/opt/local/etc/lynx.cfg

" :Ref man ls
" :Ref phpmanual echo

""" ref.vim
"Ref webdictでalcを使う設定
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

cnoremap aa Ref webdict alc<Space>

""""""""""""""""""""""""""""""
" VimShell の設定
" Shougo/vimproc のインストールが必要
""""""""""""""""""""""""""""""
"NeoBundle 'Shougo/vimproc', {
"\ 'build': {
"\ 'windows': 'make -f make_mingw32.mak',
"\ 'cygwin': 'make -f make_cygwin.mak',
"\ 'mac': 'make -f make_mac.mak',
"\ 'unix': 'make -f make_unix.mak',
"\ }
"\}

""""""""""""""""""""""""""""""
" Dash.app 連携
""""""""""""""""""""""""""""""
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>
"au FileType nim  nmap K :DashNim<CR>\|:redraw!<CR>




""""""""""""""""""""""""""""""
" filetypeの自動検出(最後の方に書いた方がいいらしい)
filetype on




