
cnoremap vim source ~/.vimrc

"-------------------------
" Color schema
"-------------------------
colorscheme desert
"colorscheme solarized

"colorscheme hybrid                                             " black background

"colorscheme lucius                                             " soft colors
"set background=dark

"colorscheme Tomorrow-Night-Eighties                            " soft colors

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

"-------------------------------------------------------------------------------- vim status-line
set laststatus=2
set statusline=%<     " line break point when line is too long
set statusline+=[%n]  " buffer number
set statusline+=%m    " %m editing flag
set statusline+=%r    " %r readonly flag
set statusline+=%h    " %h help buffer flag
set statusline+=%w    " %w preview window flat
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " show fenc and ff
set statusline+=%y    " show file type in buffer
set statusline+=\     " white space
if winwidth(0) >= 130
	set statusline+=%F    " show full path of the file in current buffer
else
	set statusline+=%t    " show only file name
endif
set statusline+=%=    " separate charactor for left block and right block
set statusline+=%{fugitive#statusline()}  " show Git branch name (must be tpope/fugitive plug-in)
set statusline+=\ \   " white space twice
set statusline+=%1l   " show line number at the cursor
set statusline+=/
set statusline+=%L    " show total line number
set statusline+=,
set statusline+=%c    " show column number at a cursor
set statusline+=%V    " show column number of the monitor at a cursor
set statusline+=\ \   " white space twice
set statusline+=%P    " show cursor position as % of the file

" change color of the status line
au InsertEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=white cterm=none

"-------------------------------------------------------------------------------- General settings
"set encoding=utf-8                              " set charactor code
set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set number                                       " show line number
set nowrap                                       " automatic wordwrap
set backspace=2                                  " it can delete newline character be BackSpace key
inoremap <silent> jj <esc>                       " 'jj' for 'ESC'
vnoremap <leader><leader> <esc>                  " '<leader><leader>' for ESC
"let mapleader = "\<Space>"                      " changing <Leader>
"noremap <leader><leader> :up<CR>                " to save file if changed
nnoremap ,, <C-v>
cabbr w!! w !sudo tee > /dev/null %              " w!! to save as root user

"------------------------------------------------------------------------------- Search
set ignorecase                                   " search regardress capital note or small note if search word is small note (noignorecase)
set smartcase                                    " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                                    " to enable incremental search
nnoremap n nzz                                   " show in middle of the monitor when moving n
nnoremap N Nzz                                   " show in middle of the monitor when moving N

"-------------------------------------------------------- PHP settings (note ":help" in vim)
let php_sql_query = 1                            " PHP settings
let php_baselib = 1                              " PHP settings
let php_htmlInStrings = 1                        " PHP settings
let php_noShortTags = 1                          " PHP settings
let php_parent_error_close = 1                   " PHP settings
let g:sql_type_default='mysql'                   " DB settings

"-------------------------------------------------------------------------------  Backup file
"set backup                                      " enable swap file
"set backupdir=~/.vim/backup                     " set backup file directory
set nobackup                                     " disable backup file

"-------------------------------------------------------------------------------  Swap file
"set swapfile                                    " enable swap file
"set directory=~/.vim/swap                       " set swap file directory
set noswapfile                                   " disable swap file

"------------------------------------------------------------------------------- Tab and Indent
set expandtab                                    " replace tab to space
set tabstop=4                                    " indent width
set shiftwidth=4                                 " auto indent width
set softtabstop=4                                " moving width of the consecutive white space
set autoindent                                   " to continue indent width in new line
set smartindent                                  " to determining indent width automatically in new line

"------------------------------------------------------------------------------- yank & put
nnoremap p gp                                    " move cursor position to under line after yank
nnoremap P gP                                    " move cursor position to under line after yank
nnoremap gp p                                    " move cursor position to under line after yank
nnoremap gP P                                    " move cursor position to under line after yank

"------------------------------------------------------------------------ automatic adding quote
"imap { {}<LEFT>                                 " automatic adding quote
"imap [ []<LEFT>                                 " automatic adding quote
"imap ( ()<LEFT>                                 " automatic adding quote

"------------------------------------------------------------------------------- window
nnoremap \- :<C-u>sp<CR><C-w>j                   " horizon split
nnoremap \\ :<C-u>vs<CR><C-w>l                   " virtical split
nnoremap \h <C-w>h                               " move to left window
nnoremap \j <C-w>j                               " move to bottom window
nnoremap \k <C-w>k                               " move to above window
nnoremap \l <C-w>l                               " move to right window
nnoremap \o <c-w><c-w>                           " move between window

"------------------------------------------------------------------------------- change directory
nnoremap <Space> `                               " motion prefix ` to <space>
nnoremap <Space>o <c-o>zz                        " Jump list (reverse)
nnoremap <Space>i <c-i>zz                        " Jump list (forwaord)
nnoremap <Space>] g<c-]>                         " jump to definition source
nnoremap <Space>[ %                              " jump to brackets to be paired
"nnoremap {count}<Space> {count}G                " jump to line you designate
nnoremap <Space>h ^                              " move to beginning of line
nnoremap <Space>l $                              " move to endding of line
vnoremap <Space>h ^                              " move to beginning of line
vnoremap <Space>l $                              " move to endding of line

"------------------------------------------------------------------------------- Cursor move
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

nnoremap 0 :<C-u>call append(expand('.'), '')<Cr>j  " insert brank line

"---------------------------------------------------------------------------
" settings for NeoBundle
" plug-in install   : add to .vimrc and exec :NeoBundleInstall in vim
" Plug-in uninstall : remove from .vimrc and exec :NeoBundleClean in vim
"---------------------------------------------------------------------------

set nocompatible
filetype off

if has('vim_starting')
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neobundle.vim'

"-------------------------
" async execution for core script
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
NeoBundle 'Shougo/unite.vim'    	        	" Adding Unite to easy to open files
NeoBundle 'Shougo/neomru.vim'   	        	" Unite: using MRU in Unite
NeoBundle 'Shougo/unite-outline'	        	" Unite: show functions/variables
NeoBundle 'tsukkee/unite-tag'                  	" Unite: using ctags in Unite
NeoBundle 'scrooloose/nerdtree'               	" Adding NERDTree to view file tree

NeoBundle 'majutsushi/tagbar'                   " Adding Tagbar
"NeoBundleLazy 'majutsushi/tagbar',         {   " Adding Tagbar
"    \ 'autoload': { 'commands': ['TagbarToggle'] }
"    \ }

NeoBundle 'wesleyche/SrcExpl'                   " show file at cursor in new window
"NeoBundleLazy 'wesleyche/SrcExpl', {           " show file at cursor in new window
"    \ 'autoload' : { 'commands': ['SrcExplToggle'] }
"    \ }

"NeoBundle 'tpope/vim-vinegar'

"-------------------------
" for Development
"-------------------------
NeoBundle 'thinca/vim-quickrun'	            	" execute code sunipet
NeoBundle 'Shougo/neosnippet'                   " code snipet
NeoBundle 'Shougo/neosnippet-snippets'          " a collection of the code anipet
NeoBundle 'Shougo/neocomplete.vim'              " auto complition
"if has('lua')					            	" auto complition
"  NeoBundleLazy 'Shougo/neocomplete.vim', {
"      \ 'depends' : 'Shougo/vimproc',
"      \ 'autoload' : { 'insert' : 1,}
"      \ }
"else
"    NeoBundleLazy 'Shougo/neocomplcache'
"        let g:nocomplcache_enable_at_startup = 1
"        let g:neocomplcache_enable_ignore_case = 1
"        let g:neocomplcache_enble_smart_case = 1
"endif

"-------------------------
" for Git
"-------------------------
NeoBundle 'tpope/vim-fugitive'

"-------------------------
" for PHP
"-------------------------
NeoBundle 'violetyk/neocomplete-php.vim'        " adding explanation in PHP auto complition
NeoBundle 'joonty/vdebug'	    		        " xdebug client
NeoBundle 'PDV--phpDocumentor-for-Vim'          " ease to insert Doc comments
"NeoBundle 'm2mdas/phpcomplete-extended'        " auto complition for PHP
"NeoBundle 'm2mdas/phpcomplete-extended-laravel' "auto complition for Laravel

"-------------------------
" Utilities
"-------------------------
NeoBundle 'rking/ag.vim'                        " using ag in grep
NeoBundle 'thinca/vim-ref'                      " search dictionary (PHP mnual/English dictionary)
NeoBundle 'fuenor/qfixhowm'                     " ease to create memo

"-------------------------
" minor leage
"-------------------------
"NeoBundle 'tpope/vim-markdown'                 " for Markdown
"NeoBundle 'tyru/open-browser.vim'              " browser preview

"NeoBundle 'chriskempson/base16-vim'            " color schema
"NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'scrooloose/syntastic'               " syntax check

call neobundle#end()
endif

filetype plugin indent on
filetype indent on
syntax on

"---------------------------------------------------------------------------
" settings for Sorce Explorer
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
" note: https://sites.google.com/site/fudist/Home/qfixhowm/quick-start)
"---------------------------------------------------------------------------
"Usage:
"g,c        : create new memo
"g,<Space>  : create new memo (in the same file)
"g,j        : create new memo (related in opning buffer)
"g,m        : show memo list
"g,g        : search memo
"g,u        : quick memo
"<C-w>,     : open/close Quickfix window
"---------------------------------------------------------------------------

" key-bindings for QFixHowm
let QFixHowm_Key = 'g'

" a place of the save files
let howm_dir = '~/Dropbox/memo'

" save file name
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'

" file encording
let howm_fileencoding = 'utf-8'

" line feed code
let howm_fileformat = 'unix'

" mark of a title
let QFixHowm_Title = '#'

" initializig dictionary for a regular expression of the title line
let QFixMRU_Title = {}

" regular expression for regarding title line in MRU 
" (designation by a regular expression of the Vim)
let QFixMRU_Title['mkd'] = '^###[^#]'

" regular expression for regarding title line in grep 
" (!: needing to change depends on type of grep)
let QFixMRU_Title['mkd_regxp'] = '^###[^#]'

let QFixHowm_DiaryFile = 'diary/%Y/%m/%Y-%m-%d-000000.howm'


"---------------------------------------------------------------------------
" settings for PDV-phpDocumentor for Vim
" http://www.phpdoc.org/
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("PDV--phpDocumentor-for-Vim"))

nnoremap <Leader>d :call PhpDocSingle()<CR>

"endif

"---------------------------------------------------------------------------
" settings for neocomplete
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("neocomplete"))

" color table
" 1: red
" 2: green
" 3: yellow
" 4: blue
" 5: red
" 6: cyan
" 7: white
" 8: black
" 9: black

hi Pmenu ctermbg=7      "background color
hi PmenuSel ctermbg=6   "selected color
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

"endif

"---------------------------------------------------------------------------
" settings for neocomplete-php
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("neocomplete-php"))
    let g:neocomplete_php_locale = 'ja'
"endif


"---------------------------------------------------------------------------
" settings for neosnippet
"---------------------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"---------------------------------------------------------------------------
" settings for Unit.vim
" note: http://blog.remora.cx/2010/12/vim-ref-with-unite.html
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("unite"))

" start in inline mode
let g:unite_enable_start_insert=1

" regardless capital letter or small letter
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" twice "ESC" to close
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

au FileType unite nnoremap <silent> <buffer> ff :q<CR>
au FileType unite inoremap <silent> <buffer> ff <ESC>:q<CR>

" twice "," to close
au FileType unite nnoremap <silent> <buffer> ,, :q<CR>
au FileType unite inoremap <silent> <buffer> ,, <ESC>:q<CR>

" open in horizontal window
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" open in virtical window
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

" ----------------------------
"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
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
"nnoremap <silent> <Leader><Leader> :UniteResume<CR>
"" }}}

nmap <C-r> ,fr
nmap <C-f> ,ff

"endif

"---------------------------------------------------------------------------
" settings for NERDTree
" note: https://github.com/oouchida/vimrc/blob/master/vim_conf/nerd_tree.vim
"---------------------------------------------------------------------------
if ! empty(neobundle#get("nerdtree"))

" Key-bindings: NERDTree open/close
"nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap ,e :NERDTreeToggle<CR>
"nmap <C-e> <Leader>e

" show Tree in default
"autocmd VimEnter * execute 'NERDTree'

" set a place of the Tree in left or right
"let g:NERDTreeWinPos="left"

" set tree width (default: 31)
"let g:NERDTreeWinSize=45

" show line number in NERDTree
let g:NERDTreeShowLineNumbers=1

" show bookmarks in default
let g:NERDTreeShowBookmarks=1

" set bookmark file name - default: $HOME/.NERDTreeBookmarks
"let g:NERDTreeBookmarksFile=

"set exclude files - default ['\~$']
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

" show hidden files
" let NERDTreeShowHidden = 1

" close Tree window automatically when file is opened
let g:NERDTreeQuitOnOpen=1

" close NERDTree when all buffers is closed.
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" change current directory when moving in NERDTree
"default (0) -  0:don't change, 1:can be changed, 2:auto change
let g:NERDTreeChDirMode=2

" change color of the file extension
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

" colorize - default: (1) enable
""let g:NERDChristmasTree=1

"カーソル位置の自動調節を行うか - 初期値(1):自動調節
""let g:NERDTreeAutoCenter=1

"カーソルの自動調節位置設定 - 初期値(3)
""let g:NERDTreeAutoCenterThreshold

" auto file sorting - default: (0) disable
"let g:NERDTreeCaseSensitiveSort=1

" heiglighting cursor line - default: (1) enable
"let g:NERDTreeHighlightCursorline=1

"セカンドツリーを表示を有効に ":edit <ディレクトリ名> " - 初期値(1):有効
"let g:NERDTreeHijackNetrw=1

"mouse - default: 1
"1: open file/directory by double-click
"2: open file by single-click and open directory by double-click
"3: open file/directory bo single-click
let g:NERDTreeMouseMode=3

" show file name in tree - default: (1) show
"let g:NERDTreeShowFiles=1

"ソートを行う時の、表示順番設定 (正規表現で設定) - 初期値 ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
"let g:NERDTreeSortOrder=

" status format - default: %{b:NERDTreeRoot.path.strForOS(0)}
"let g:NERDTreeStatusline=

" show shortcut-key for bookmarks and help - default: (0) show
"let g:NERDTreeMinimalUI=0

"古い形式である|と+と~の記号だけでツリー表示 - 初期値(1):グラフィカルに表示する
"let g:NERDTreeDirArrows=0

endif

"---------------------------------------------------------------------------
" settings for Tagbar
" note: http://rcmdnk.github.io/blog/2014/07/25/computer-vim/#tagbar-srcexpl-nerdtree
"---------------------------------------------------------------------------
if ! empty(neobundle#get("tagbar"))
" Width (default 40)
let g:tagbar_width = 30
" Map for toggle
nn <silent> ,t :TagbarToggle<CR>
endif

"---------------------------------------------------------------------------
" settings for rking/ag(grep → ag)
"---------------------------------------------------------------------------

" grep search
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" grep search in cursor
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" show result for grep search again
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" useing ag(The Silver Searcher) in unite grep
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif


"---------------------------------------------------------------------------
" settings for taglist
"---------------------------------------------------------------------------

"a place of tags file
set tags=tags

"command path
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"

"show tags only editing file
"let Tlist_Show_One_File = 1 

"if taglist is last window, close vim
"let Tlist_Exit_OnlyWiindow = 1 

"If multi files exist, show list of the tags
"nnoremap <C-]> g<C-]>

" Key binding for tree open/close (rebindings by Karabiner) 
nnoremap <silent><C-l> :TlistToggle<CR>

"To open in new window
"map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"To open in horizontal split window
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

"To open in virtical split window
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>


"---------------------------------------------------------------------------
" settings for Vdebug
" <F5>: start debugger / move to next brake point
" <F2>: step-over
" <F3>: step-in
" <F4>: step-out
" <F6>: stop debugger
" <F7>: detouch debugger
" <F9>: exec to cursor line
" <F10>: set brake point
" <F11>: show context variables (e.g. after "eval")
" <F12>: evaluate variable value at cursor
" :Breakpoint <type> <args>: can be set several types of the brake point (see :help VdebugBreakpoints)
" :VdebugEval <code>: evaluate variable value in <code>
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
" settings for QuickRun (for Markdown)
" note: http://qiita.com/us10096698/items/1ac05c5c9543d2f79fa3
" enabling syntax-highlight in .md file
" 
" Usage:
" exec command: <leader>r 
"---------------------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\    'outputter': 'browser'
\}


"---------------------------------------------------------------------------
" settings for thinca/vim-ref
"---------------------------------------------------------------------------
" using text browser (lynx）
"
" Usage:
" :man search-word (ex. :man ls)
" :phpm search-word (ex. :phpm echo)
" :eng search-word (ex. :dic happy)
"---------------------------------------------------------------------------
"a place of lynx.cfg (in case of the installing lynx by Homebrew)
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg

"a place of lynx.cfg (in case of the installing lynx by MacPorts)
"/opt/local/etc/lynx.cfg

"---------------------------------------------------------------------------
" settigs for man
"---------------------------------------------------------------------------
cnoremap man man<Space>

"---------------------------------------------------------------------------
" settings for PHP Manual
"---------------------------------------------------------------------------
let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'
cnoremap phpm phpmanual<Space>

"---------------------------------------------------------------------------
" settings for using alc in the webdict
"---------------------------------------------------------------------------
let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
let g:ref_source_webdict_use_cache = 1
let g:ref_source_webdict_sites = {
\   'alc' : {
\       'url' : 'http://eow.alc.co.jp/%s/UTF-8/'
\   }
\}
function! g:ref_source_webdict_sites.alc.filter(output)
	return join(split(a:output, "\n")[29 :], "\n")
endfunction

cnoremap dic webdict alc<Space>


"---------------------------------------------------------------------------
" cooperate in Dash.app
"---------------------------------------------------------------------------
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>
"au FileType nim  nmap K :DashNim<CR>\|:redraw!<CR>


" the end of NeoBundle settings is here
"---------------------------------------------------------------------------

" autoload the filetype of the file (much better to place in the last of the file??)
filetype on

