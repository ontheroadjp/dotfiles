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
"NeoBundle 'Shougo/vimproc', {
"\ 'build' : {
"\     'windows' : 'make -f make_mingw32.mak',
"\     'cygwin' : 'make -f make_cygwin.mak',
"\     'mac' : 'make -f make_mac.mak',
"\     'unix' : 'make -f make_unix.mak',
"\    }
"\ }
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
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
"NeoBundle 'violetyk/neocomplete-php.vim'        " adding explanation in PHP auto complition
NeoBundle 'joonty/vdebug'	    		        " xdebug client
NeoBundle 'PDV--phpDocumentor-for-Vim'          " ease to insert Doc comments
"NeoBundle 'm2mdas/phpcomplete-extended'        " auto complition for PHP
"NeoBundle 'm2mdas/phpcomplete-extended-laravel' "auto complition for Laravel
NeoBundle 'arnaud-lb/vim-php-namespace'         "auto adding use statement
NeoBundle 'docteurklein/php-getter-setter.vim'  "auto adding getter/setter 

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