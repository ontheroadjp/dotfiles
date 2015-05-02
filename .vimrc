
"-------------------------
"基本
"-------------------------
set number

inoremap <silent> jj <esc>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

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
set backup
"set nobackup
set backupdir=~/.vim/backup

"-------------------------
"スワップ
"-------------------------
set swapfile
"set noswapfile
set directory=~/.vim/swap

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
"-------------------------

set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
		NeoBundleFetch 'Shougo/neobundle.vim'
	call neobundle#end()
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'scrooloose/syntastic'


filetype plugin indent on
filetype indent on
syntax on

" プラグインのインストール .vimrc に記述のち、:$NeoBundleInstall を実行
" プラグインのアンインストール .vimrc の記述を削除したのち、:NeoBundleClean を実行

"PHP マニュアルの閲覧
NeoBundle 'thinca/vim-ref'

let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'

"lynx.cfg の場所
"
""Homebrew でlynx をインストールした場合
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg
"
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

""""""""""""""""""""""""""""""""


"ファイルオープンを便利に
NeoBundle 'Shougo/unite.vim'

"Unite.vimで最近使ったファイルを表示できるようにする
NeoBundle 'Shougo/neomru.vim'
"
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
"" 入力モードで開始する
let g:unite_enable_start_insert=1

"" ウィンドウを分割して開く
"au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')

"" ウィンドウを縦に分割して開く

"""""""""""""""""""""""""""""""
"" unite.vim {{{
"The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Leader>f [unite]
  
" unite.vim keymap
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>

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




