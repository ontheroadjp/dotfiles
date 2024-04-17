"map <F5> :wall!<CR>:!glow ~/memo<CR><CR>

"================================================== Disable default plugins
" Fast Startup Settings!!
" Disable TOhtml.
let g:loaded_2html_plugin       = 1

" Disable archive file open and browse.
let g:loaded_gzip               = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1

" Disable vimball.
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1

" Disable netrw plugins.
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_netrwFileHandlers  = 1

" Disable `GetLatestVimScript`.
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1

" Disable other plugins
let g:loaded_man                = 1
let g:loaded_matchit            = 1
let g:loaded_matchparen         = 1
let g:loaded_shada_plugin       = 1
let g:loaded_spellfile_plugin   = 1
let g:loaded_tutor_mode_plugin  = 1
let g:did_install_default_menus = 1
let g:did_install_syntax_menu   = 1
let g:skip_loading_mswin        = 1
let g:did_indent_on             = 1
let g:did_load_ftplugin         = 1
let g:loaded_rrhelper           = 1

"================================================================ Quickfix
" open:copen, close:ccl
autocmd QuickfixCmdPost *grep* cwindow      " open vimgrep result in quickfix
au QuickfixCmdPost make,grep,grepadd,vimgrep copen  " open quickfix window for :grep
nnoremap <C-up> :copen<CR>                  " move to previous item
nnoremap <C-down> :ccl<CR>                  " move to previous item
nnoremap <up> :cprevious<CR>                " move to previous item
nnoremap <down> :cnext<CR>                  " move to next item

" use ripgrep if installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"================================================================ visuals
" Color schema
so ${HOME}/dotfiles/.vim/vimrc.d/ui/color-schema.vim

" Status bar
" 0: none
" 1: show when more than two windows
" 2:always show the status-line
set laststatus=0
so ${HOME}/dotfiles/.vim/vimrc.d/ui/vim-status-line.vim

"================================================================ General settings
set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set nowrap                                       " automatic wordwrap
set backspace=indent,eol,start                   " it can delete newline character be BackSpace key

"set cursorline                                   " show cursor line
set linespace=4

" Clipboard
set clipboard+=unnamed

"--------------------------------------------------------------- Line number
set number                                  " show line number
nmap <C-N><C-N> :set invnumber<CR>          " toggle show/hide line number
nmap <C-M><C-M> :setl rnu!<CR>              " toggle normal/relativenumber

"--------------------------------------------------------------- Indent
set expandtab                  " replace tab to space
set tabstop=4                  " indent width
set shiftwidth=4               " auto indent width
set softtabstop=4              " moving width of the consecutive white space
set autoindent                 " to continue indent width in new line
set smartindent                " to determining indent width automatically in new line

"--------------------------------------------------------- Backup/Swap file
set nobackup                                     " disable backup file
set noswapfile                                   " disable swap file

"--------------------------------------------------------------- Command
" Save as root user
cabbr w!! w !sudo tee > /dev/null %

" %% to expand current directory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h/').'/' : '%%'
cnoremap <expr> %$ getcmdtype() == ':' ? expand('%:p/') : '%$'

"=============================================================== Mode change
" JJ, jk, kj  as <esc>
"inoremap <silent> jj <esc>
inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" visual mode to normal mode
vnoremap n <C-c>

" change insert-normal mode
inoremap <C-n> <C-o>

" Redo
nnoremap <S-u> <C-r>

"------------------------------------------------------------- Window
nnoremap -- :split<CR>                  " horizontal split
nnoremap \\ :rightbelow vsp<CR>         " virtical split
set winheight=25

"--------------------------------------------------------------- Buffer
nnoremap <silent> yt :buffers<CR>
nnoremap <silent> yb :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"--------------------------------------------------------------- Moving cursor
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

" move cursor in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"--------------------------------------------------------------- Scroll
nnoremap <C-k> Hzz
nnoremap <C-j> Lzz

"--------------------------------------------------------------- Jump to
" motion prefix ` to <space>
nnoremap <Space> `
nnoremap <Space>o <C-o>zz                   " Jump list (reverse)
nnoremap <Space>i <C-i>zz                   " Jump list (forword)

" Jump to begining of the line
nnoremap <C-h> ^
vnoremap <C-h> ^o

" Jump to end of the line
nnoremap <C-l> $
vnoremap <C-l> $<left>

" Jump to paragraph (reverse)
nnoremap { {<down>
nnoremap } }<up>$
vnoremap { {<down>o
vnoremap } }<up>$

"--------------------------------------------------------------- Search
set hlsearch                    " highlight search word
set smartcase                   " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                   " to enable incremental search

" highlight a word under the cursor
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

"-------------------------------------------------------------- Folding
set foldmethod=indent    "Folding range
set fillchars=fold:.
nnoremap <C-i> zA

"----------------------------------------------------------- yank & put
nnoremap p gp
nnoremap P gP
nnoremap gp p
nnoremap gP P

"------------------------------------------------------------------- Plug-ins
so ${HOME}/dotfiles/.vim/vimrc.d/vim-plug-management.vim	    " vim-plug
function s:lazy_load(timer)
    runtime! vimrc.d/editing.vim
endfunction
call timer_start(20, function('s:lazy_load'))

"------------------------------------------- By filetype (note ":help" in vim)
autocmd BufNewFile,BufRead *.{html,htm,ejs*} set filetype=html
autocmd BufNewFile,BufRead *.{vue} set filetype=javascript
autocmd BufNewFile,BufRead *.{profile,fnc,bats} set filetype=sh

" File Template
autocmd BufNewFile *.vue 0r $HOME/dotfiles/.vim/templates/vue.tpl
autocmd BufNewFile *.{sh,bash,fnc} 0r $HOME/dotfiles/.vim/templates/sh.tpl
autocmd BufNewFile *.{py} 0r $HOME/dotfiles/.vim/templates/python.tpl
autocmd BufNewFile *.{bats} 0r $HOME/dotfiles/.vim/templates/bats.tpl
augroup PHP
    autocmd!
    autocmd BufRead,BufNewFile *.php let php_sql_query = 1            " PHP settings
    autocmd BufRead,BufNewFile *.php let php_baselib = 1              " PHP settings
    autocmd BufRead,BufNewFile *.php let php_htmlInStrings = 1        " PHP settings
    autocmd BufRead,BufNewFile *.php let php_noShortTags = 1          " PHP settings
    autocmd BufRead,BufNewFile *.php let php_parent_error_close = 1   " PHP settings
    autocmd BufRead,BufNewFile *.php let g:sql_type_default='mysql'   " DB settings
    " dictionary
    autocmd FileType php,ctp :set dictionary=~/.source ~/vim/dict/php.dict
    autocmd FileType php,ctp :set dictionary=~/vim/dict/php.dict
    autocmd FileType php,ctp :set complete+=k/~/vim/dict/php.dict
augroup END
augroup Javascript
    " load ESLint
    au Filetype javascript cnoremap eslint !clear && node_modules/eslint/bin/eslint.js %<CR>
    au BufNewFile,BufRead *.vue tabstop=0 softtabstop=0 shiftwidth=0
augroup END

filetype on

