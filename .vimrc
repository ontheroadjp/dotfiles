"================================================================ Quickfix
" open vimgrep result in quickfix
autocmd QuickfixCmdPost *grep* cwindow

" Quickfix
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

"nmap <Leader>s :!open -a Safari<CR>
"nmap <Leader>c :!open -a Google\ Chrome<CR>
"nmap <Leader>md :!open -a Typora %<CR>

"================================================================ main
" <Leader> = \ (default)
nmap <Leader>vv :source ~/.vimrc<CR>

"================================================================ system
" Clipboard
set clipboard+=unnamed
"set clipboard^=unnamed  # if doesn't work above, use this

"================================================================ visuals
"color schema
so ${HOME}/dotfiles/.vim/vimrc_includs/color-schema.vim

" line number
au VimEnter * hi LineNr guifg=Blue guibg=DarkGray gui=none ctermfg=gray ctermbg=none cterm=none
nmap <C-N><C-N> :set invnumber<CR>

"vim status-line
"so ${HOME}/dotfiles/.vim/vimrc_includs/vim-status-line.vim

" 0: none
" 1: show when more than two windows
" 2:always show the status-line
set laststatus=0

" status-line color
au InsertEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=Black ctermbg=Blue cterm=none
au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=White  cterm=none
au VimEnter * hi StatusLineNC guifg=Blue guibg=DarkYellow gui=none ctermfg=DarkGray ctermbg=Green cterm=none

"set statusline=%F       " show filename
"set statusline+=%m      " show edit status
"set statusline+=%r      " show read only or not
"set statusline+=%h      " show [HELP] if Help page
"set statusline+=%w      " show [Preview] if Preview window
"set statusline+=%=      " below settings is shown on right side
"set statusline+=[ENC=%{&fileencoding}]  " file encoding
"set statusline+=[LOW=%l/%L]             " current row number/total row number

" window split bar
au VimEnter * hi VertSplit guifg=Blue guibg=DarkGray gui=none ctermfg=DarkGray ctermbg=DarkGray cterm=none

"================================================================ General settings
"set encoding=utf-8                              " set charactor code
set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set number                                       " show line number
set nowrap                                       " automatic wordwrap
set backspace=indent,eol,start                   " it can delete newline character be BackSpace key
"set cursorline                                   " show cursor line
set linespace=4

"--------------------------------------------------------------- Buff file/Swap file
"set backup                                      " enable swap file
"set backupdir=~/.vim/backup                     " set backup file directory
set nobackup                                     " disable backup file

"set swapfile                                    " enable swap file
"set directory=~/.vim/swap                       " set swap file directory
set noswapfile                                   " disable swap file

"--------------------------------------------------------------- Lint
cnoremap eslint !clear && node_modules/eslint/bin/eslint.js %<CR>
autocmd BufWritePre * :%s/\s\+$//ge              " remove trailing whitespace when saved

"--------------------------------------------------------------- File/Directory
" File/Directory info
nnoremap <C-S><C-S> :set filetype=bash<CR>
nnoremap ,ft :set filetype?<CR>
nnoremap ,fp :echo expand("%:p")<CR>
nnoremap ,fe :set enc?<CR>
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>
nnoremap ,ww :cd ~/WORKSPACE<CR>:pwd<CR>
nnoremap ,dd :pwd<CR>

" %% to expand current directory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h/').'/' : '%%'

" Save as root user
cabbr w!! w !sudo tee > /dev/null %

" New File Template
autocmd BufNewFile *.vue 0r $HOME/dotfiles/.vim/templates/vue.tpl
autocmd BufNewFile *.{sh,bash,fnc} 0r $HOME/dotfiles/.vim/templates/sh.tpl
autocmd BufNewFile *.{py} 0r $HOME/dotfiles/.vim/templates/python.tpl
autocmd BufNewFile *.{bats} 0r $HOME/dotfiles/.vim/templates/bats.tpl

" Filetype
autocmd BufNewFile,BufRead *.{html,htm,ejs*} set filetype=html
autocmd BufNewFile,BufRead *.{vue} set filetype=javascript
autocmd BufNewFile,BufRead *.{profile,fnc,bats} set filetype=bash
autocmd BufNewFile,BufRead *.{py} set filetype=python

"--------------------------------------------------------------- Buffer
nnoremap <silent> bl :buffers<CR>
nnoremap <silent> b[ :bprevious<CR>
nnoremap <silent> b] :bnext<CR>
"nnoremap <silent> B[ :bfirst<CR>
"nnoremap <silent> B] :blast<CR>

"--------------------------------------------------------------- Indent
set expandtab                  " replace tab to space
set tabstop=4                  " indent width
set shiftwidth=4               " auto indent width
set softtabstop=4              " moving width of the consecutive white space
set autoindent                 " to continue indent width in new line
set smartindent                " to determining indent width automatically in new line

"autocmd BufNewFile,BufRead *.vue tabstop=0 softtabstop=0 shiftwidth=0

"--------------------------------------------------------------- Cursor settings
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"--------------------------------------------------------------- Search
set hlsearch                    " highlight search word
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"set ignorecase                 " search regardress capital note or small note if search word is small note (noignorecase)
set smartcase                  " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                  " to enable incremental search
"nnoremap n nzz                 "move center of display when search (n)
"nnoremap N Nzz                 "move center of display when search (N)
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

"================================================================== Key bindings
" JJ as <esc>
inoremap <silent> jj <esc>

" <Leader><Leader> to <esc>
"vnoremap <leader><leader> <esc>

" changing <Leader>
"let mapleader = "\<Space>"

"" Go into visual mode
"nnoremap ,, <C-v>

" Redo
nnoremap <S-u> <C-r>

"--------------------------------------------------------------- moving cursor
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

" move cursor in insert mode
imap <C-k> <Up>
imap <C-j> <Down>
imap <C-h> <Left>
imap <C-l> <Right>

" insert brank line to under cursor
nnoremap 00 :<C-u>call append(expand('.'), '')<CR>j

" insert two brank line and to be inline mode
nnoremap 0i :<C-u>call append(expand('.'), '')<CR>o

"--------------------------------------------------------------- Jump to
" motion prefix ` to <space>
nnoremap <Space> `

" Jump list (reverse)
nnoremap <Space>o <C-o>zz

" Jump list (forword)
nnoremap <Space>i <C-i>zz

"Jump to definition source
"nnoremap <Space>@ g<C-]>

" Jump to brackets to be paired
nnoremap <Space>[ %
nnoremap <Space>] %

" Jump to top/middle/bottom line
"nnoremap <S-k> H
"nnoremap <S-m> M
"nnoremap <S-j> L " the same as default(connect line)

" Jump to begining of the line
nnoremap <S-h> ^
vnoremap <S-h> 100^

" Jump to end of the line
nnoremap <S-l> $
vnoremap <S-l> $

"" Jump to paragraph (reverse)
"nnoremap <S-k> {
"vnoremap <S-k> {

"" Jump to paragraph (forword)
"nnoremap <S-j> }
"vnoremap <S-j> }
" list all of them if multiple candidate of the distination when it tags jump
"nnoremap <C-]> g<C-]>
"------------------------------------------------------------------------ folding

set foldmethod=indent    "Folding range
"set foldlevel=0          "Default level of folding when a file is opened
"" set foldcolumn=3       "Add an area to the left edge to show the folded state

"" Region of cursor
"" zc  -- Close one fold under the cursor
"" zo  -- Open one fold under the cursor
"" zO  -- Open all folds under the cursor recursively
"nnoremap <C-h> zc " close
"nnoremap <C-l> zO " open

"" Whole file
"" zm -- Fold more
"" zM -- Close all folds
"" zr -- Reduce folding
"" zR -- Open all folds
"" zA -- Toggle
"nnoremap <C-> zM " close
"nnoremap <C-k> zR " open
nnoremap <C-k> zA

" Move
"nnoremap <C-k> zk " move to upper fold
"nnoremap <C-j> zj " move to down fold

"------------------------------------------------------------------------ yank & put
nnoremap p gp
nnoremap P gP
nnoremap gp p
nnoremap gP P

" past in normalmode
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"
    if !exists('*XTermPasteBegin')
        function XTermPasteBegin(ret)
            set paste
            return a:ret
        endfunction
    endif

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

"------------------------------------------------------------------------ Window
nnoremap -- :split<CR>                  " horizontal split
nnoremap \\ :rightbelow vsp<CR>         " virtical split
"nnoremap \2 :close<CR>                 " close window
"nnoremap \h <C-w>h                     " move to left window
"nnoremap \j <C-w>j                     " move to bottom window
"nnoremap \k <C-w>k                     " move to above window
"nnoremap \l <C-w>l                     " move to right window
"nnoremap \q <c-w><c-w>                 " move between window
"nnoremap TT <C-w>T

"-------------------------------------------------------------------- Terminal
"nnoremap <f3> :term source ~/.zprofile<CR>
"nnoremap <f6> :vert term ++close git log<CR>

"------------------------------------------------------------------------ Tab
"nnoremap <silent> tn :tabnew<CR>        " open new tab
"nnoremap <silent> <Tab> :tabn<CR>       " change to next tab
"nnoremap <silent> <S-Tab> :tabp<CR>     " change to previous tab
"nnoremap <silent> t] :tabmove +<CR>     " move tab to right
"nnoremap <silent> t[ :tabmove -<CR>     " move tab to left

"------------------------------------------------------------------------
"brackets
"inoremap {<Enter> {}<Left><CR><ESC><S-o>
"inoremap [<Enter> []<Left><CR><ESC><S-o>
"inoremap (<Enter> ()<Left><CR><ESC><S-o>
"inoremap ({<Enter> ({})<Left><Left><CR><ESC><S-o>
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap < <><LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>

"--------------------------------------------------- PHP settings (note ":help" in vim)
let php_sql_query = 1                            " PHP settings
let php_baselib = 1                              " PHP settings
let php_htmlInStrings = 1                        " PHP settings
let php_noShortTags = 1                          " PHP settings
let php_parent_error_close = 1                   " PHP settings
let g:sql_type_default='mysql'                   " DB settings

nnoremap ,= vap=vapvv

"------------------------------------------------------------------ Load dictionary
"autocmd FileType php,ctp :set dictionary=~/.source ~/.vim/dict/php.dict
autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
autocmd FileType php,ctp :set complete+=k/~/.vim/dict/php.dict

"------------------------------------------------------------------ Command alias
cnoremap %vv :source ~/.vimrc<CR>

"------------------------------------------------------------------ Plug-ins

" Plug-in installation
so ${HOME}/dotfiles/.vim/vimrc_includs/plugins.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_dirs.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_completion.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_others.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_ref.vim

" directory browser
so ${HOME}/dotfiles/.vim/vimrc_includs/unite.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/nerdtree.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/tagbar.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/taglist.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/srcexplorer.vim

" moving cursor
"so ${HOME}/dotfiles/.vim/vimrc_includs/vim-easymotion.vim

" completion
"so ${HOME}/dotfiles/.vim/vimrc_includs/neocomplete.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/neocomplete-php.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/supertab.vim

" snippets
so ${HOME}/dotfiles/.vim/vimrc_includs/neosnippet.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/snipmate.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/vim-emmet.vim

" input
so ${HOME}/dotfiles/.vim/vimrc_includs/surround.vim

" reference
so ${HOME}/dotfiles/.vim/vimrc_includs/vim-ref.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/dash.vim

" utilities
so ${HOME}/dotfiles/.vim/vimrc_includs/ag.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/quickrun.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/qfixhome.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/vdebug.vim

" PHP
so ${HOME}/dotfiles/.vim/vimrc_includs/php.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/vim-php-namespace.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/php-getter-setter.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/vim-php-cs-fixer.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/pdv-phpdocumentor-for-vim.vim

"----------------------------------------------------------------------- "Colors
" tab bar
:hi TabLineSel ctermfg=White ctermbg=Blue   " current tab
:hi TabLine ctermfg=White ctermbg=None      " tab
:hi TabLineFill ctermfg=White ctermbg=None  " tabbar

" match brackets
hi MatchParen ctermfg=LightGreen ctermbg=blue

" search highlight
hi Search ctermbg=Blue ctermfg=White

" folding
"hi Folded ctermbg=Grey
hi Folded ctermbg=000

filetype on
