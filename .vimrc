
set number

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

"-------------------------
" DB 設定
"-------------------------

let g:sql_type_default='mysql'


"-------------------------
" NeoVundle の設定
"-------------------------

"set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shogovimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shogo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'

filetype plugin indent on
filetype indent on
syntax on

# $NeoBundleInstall でインストール
# プラグイン削除する場合は、.vimrc から NeoBundle を削除して、
# $NeoBundleClean でできる




