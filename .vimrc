
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

" 文字コード
"set encoding=utf-8
set encoding=utf-8 nobomb
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac

" 行番号表示
set number

" 折り返しなし
set nowrap

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

"タブ入力を複数の空白文字に置き換える
"set expandtab

"画面上でタブ文字が占める幅
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
" キーバインド key bind
"-------------------------

" ウインドウ間の移動（Karabiner でさらに再設定）
nnoremap <c-w> <c-w><c-w>

" モーション移動のコマンド ` を <Space> で置き換え
nnoremap <Space> `
nnoremap <Space><Space> ``

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

"空行の挿入
nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j

"定義元へのジャンプ
nnoremap <Space>] <c-]>

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
	NeoBundle 'Shougo/vimproc', {
				\ 'build' : {
				\     'windows' : 'make -f make_mingw32.mak',
				\     'cygwin' : 'make -f make_cygwin.mak',
				\     'mac' : 'make -f make_mac.mak',
				\     'unix' : 'make -f make_unix.mak',
				\    },
				\ }
	NeoBundleFetch 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/unite.vim'		"ファイルオープンを便利に
	NeoBundle 'Shougo/neomru.vim'		"最近使ったファイルを表示できるようにする
	NeoBundle 'Shougo/unite-outline'		"最近使ったファイルを表示できるようにする
	NeoBundle 'scrooloose/nerdtree' 	"NERDTree 表示
	if has('lua')
	  NeoBundleLazy 'Shougo/neocomplete.vim', {
	      \ 'depends' : 'Shougo/vimproc',
	      \ 'autoload' : { 'insert' : 1,}
	      \ }
	endif
	NeoBundle 'violetyk/neocomplete-php.vim'
	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'Shougo/neosnippet-snippets'
	NeoBundle 'thinca/vim-ref'			"PHP マニュアルの閲覧
	NeoBundle 'rking/ag.vim'			"grep に ag 使う
	NeoBundle 'tpope/vim-markdown'		"Markdown 用
	NeoBundle 'tyru/open-browser.vim'	"ブラウザプレビュー
	NeoBundle 'thinca/vim-quickrun'		"コード片の実行
	NeoBundle 'tpope/vim-fugitive'		"git コマンド使えるようにする
	NeoBundle 'tsukkee/unite-tag.vim'	"メソッド/変数の一覧表示
	
	" Tagbar
	" http://rcmdnk.github.io/blog/2014/07/25/computer-vim/#tagbar-srcexpl-nerdtree
	NeoBundleLazy "majutsushi/tagbar", {
	      \ "autoload": { "commands": ["TagbarToggle"] }}
	if ! empty(neobundle#get("tagbar"))
		" Width (default 40)
		let g:tagbar_width = 20
		" Map for toggle
		nn <silent> <leader>t :TagbarToggle<CR>
	endif

	"SrcExpl
	NeoBundleLazy "wesleyche/SrcExpl", {
	      \ "autoload" : { "commands": ["SrcExplToggle"]}}
	if ! empty(neobundle#get("SrcExpl"))
	
		" Set refresh time in ms
	 	"let g:SrcExpl_RefreshTime = 1000 "1秒
	 	let g:SrcExpl_RefreshTime = 10 "1秒
		
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
	"NeoBundle 'm2mdas/phpcomplete-extended'
	"NeoBundle 'm2mdas/phpcomplete-extended-laravel'
	"NeoBundle 'chriskempson/base16-vim'
	"NeoBundle 'Shougo/neocomplcache'
	"NeoBundle 'Shougo/neosnippet'
	"NeoBundle 'jpalardy/vim-slime'
	"NeoBundle 'scrooloose/syntastic'
	call neobundle#end()
endif

filetype plugin indent on
filetype indent on
syntax on

""""""""""""""""""""""""""""""
" neocomplete の設定
""""""""""""""""""""""""""""""

" 色の設定
hi Pmenu ctermbg=4
hi PmenuSel ctermbg=1
hi PMenuSbar ctermbg=4

let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1

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

""""""""""""""""""""""""""""""
" neocomplete-php の設定
""""""""""""""""""""""""""""""

let g:neocomplete_php_locale = 'ja'

""""""""""""""""""""""""""""""
" NERDTree の設定
""""""""""""""""""""""""""""""

" ツリー開閉のキーバインド
nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>

" デフォルトでツリーを表示
"autocmd VimEnter * execute 'NERDTree'

" デフォルトでブックマークを表示
let g:NERDTreeShowBookmarks=1

" 隠しファイルをデフォルトで表示させる
" let NERDTreeShowHidden = 1

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
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('php', 'green', 'none', '#ff00ff', '#151515')

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

" ----------------------------
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
nnoremap <silent> [unite]y :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory/new<CR>
nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> ,vr :UniteResume<CR>
"" }}}

"" grep検索
"nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

"" カーソル位置の単語をgrep検索
"nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

"" grep検索結果の再呼出
"nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

"" unite grep に ag(The Silver Searcher) を使う
"if executable('ag')
"	let g:unite_source_grep_command = 'ag'
"	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"	let g:unite_source_grep_recursive_opt = ''
"endif


"""""""""""""""""""""""""""""""
"" taglist の設定
"""""""""""""""""""""""""""""""
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
"nnoremap <C-]> g<C-]>
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
"テキストブラウザ（lynx）使う

"lynx.cfg の場所(Homebrew でlynx をインストールした場合)
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg

"lynx.cfg の場所(HMacPorts で lynx をインストールした場合)
"/opt/local/etc/lynx.cfg

" 使い方
" :dic 検索ワード(ex. :dic happy)
" :phpm 検索ワード(ex. :phpm echo)
" :Ref man 検索ワード(ex. Ref man ls)
""""""""""""""""""""""""""""""

" ----------------------------
" PHP Manual の設定
" ----------------------------
let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'


" ----------------------------
" webdictでalcを使う設定
" ----------------------------
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


""""""""""""""""""""""""""""""
" Dash.app 連携
""""""""""""""""""""""""""""""
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>
"au FileType nim  nmap K :DashNim<CR>\|:redraw!<CR>


" NeoBundle 関連はここまで
"-------------------------

" filetypeの自動検出(最後の方に書いた方がいいらしい)
filetype on


