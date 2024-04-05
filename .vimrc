map <F5> :wall!<CR>:!glow ~/memo<CR><CR>
"================================================================ Quickfix
" open vimgrep result in quickfix
autocmd QuickfixCmdPost *grep* cwindow

" Quickfix
"nnoremap fo :copen<CR>              " open quickfix window
"nnoremap fo :ccl<CR>                " close quickfix window
nnoremap [q :cprevious<CR>          " move to previous item
nnoremap ]q :cnext<CR>              " move to next item
nnoremap [Q :<C-u>cfirst<CR>        " move to first item
nnoremap ]Q :<C-u>clast<CR>         " move to last item

" use ripgrep if installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" open quickfix window for :grep
au QuickfixCmdPost make,grep,grepadd,vimgrep copen


"nmap <Leader>s :!open -a Safari<CR>
"nmap <Leader>c :!open -a Google\ Chrome<CR>
"nmap <Leader>md :!open -a Typora %<CR>

"================================================================ system
" Clipboard
set clipboard+=unnamed
"set clipboard^=unnamed  " if doesn't work above, use this

"================================================================ visuals
"color schema
so ${HOME}/dotfiles/.vim/vimrc_includs/color-schema.vim

" line number
set number                                       " show line number
au VimEnter * hi LineNr guifg=Blue guibg=DarkGray gui=none ctermfg=gray ctermbg=none cterm=none
nmap <C-N><C-N> :set invnumber<CR> " toggle show/hide line number

" Status bar
" 0: none
" 1: show when more than two windows
" 2:always show the status-line
set laststatus=0
"so ${HOME}/dotfiles/.vim/vimrc_includs/vim-status-line.vim

" window virtical split bar
au VimEnter * hi VertSplit guifg=Blue guibg=DarkGray gui=none ctermfg=Black ctermbg=Black cterm=none
set fillchars+=vert::

" tab bar
:hi TabLineSel ctermfg=White ctermbg=Blue   " current tab
:hi TabLine ctermfg=White ctermbg=None      " tab
:hi TabLineFill ctermfg=White ctermbg=None  " tabbar

" match brackets
hi MatchParen ctermfg=LightGreen ctermbg=blue

" search highlight
au VimEnter * hi Search guifg=Blue guibg=DarkGray gui=none ctermfg=White ctermbg=Blue cterm=none

" folding
au VimEnter * hi Folded guifg=Blue guibg=DarkGray gui=none ctermfg=Black ctermbg=Black cterm=none
set fillchars=fold:.

" quickfix
au QuickfixCmdPost * hi QuickFixLine ctermbg=Yellow guibg=Yellow

"================================================================ General settings
"set encoding=utf-8                              " set charactor code
set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set nowrap                                       " automatic wordwrap
set backspace=indent,eol,start                   " it can delete newline character be BackSpace key
"set cursorline                                   " show cursor line
set linespace=4

"--------------------------------------------------------------- Indent
set expandtab                  " replace tab to space
set tabstop=4                  " indent width
set shiftwidth=4               " auto indent width
set softtabstop=4              " moving width of the consecutive white space
set autoindent                 " to continue indent width in new line
set smartindent                " to determining indent width automatically in new line

"--------------------------------------------------------------- command
" Save as root user
cabbr w!! w !sudo tee > /dev/null %

" remove trailing whitespace when saved
autocmd BufWritePre * :%s/\s\+$//ge

" Bulk insertion at the beginning and end of a sentence with visual mode
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
" Enable 'I' and 'A' in visual line mode
function! s:force_blockwise_visual(next_key)
    if mode() ==# 'v'
        return "\<C-v>" . a:next_key
    elseif mode() ==# 'V'
        return "\<C-v>0o$" . a:next_key
    else  " mode() ==# "\<C-v>"
        return a:next_key
    endif
endfunction

"--------------------------------------------------------------- Buff file/Swap file
"set backup                                      " enable swap file
"set backupdir=~/.vim/backup                     " set backup file directory
set nobackup                                     " disable backup file

"set swapfile                                    " enable swap file
"set directory=~/.vim/swap                       " set swap file directory
set noswapfile                                   " disable swap file

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
cnoremap <expr> %$ getcmdtype() == ':' ? expand('%:p/') : '%$'

" File Template
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
"nnoremap <silent> bl :buffers<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
"nnoremap <silent> [B :bfirst<CR>
"nnoremap <silent> ]B :blast<CR>

"--------------------------------------------------------------- Cursor settings
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"--------------------------------------------------------------- Search
set hlsearch                    " highlight search word
"nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"set ignorecase                 " search regardress capital note or small note if search word is small note (noignorecase)
set smartcase                  " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                  " to enable incremental search
"nnoremap n nzz                 " move center of display when search (n)
"nnoremap N Nzz                 " move center of display when search (N)

" highlight a word under the cursor
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

"================================================================== Key bindings
" <Leader> = \ (default)

" JJ as <esc>
inoremap <silent> jj <esc>

" change insert-normal mode
inoremap <C-n> <C-o>

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

" add a blank line under the cursor line
imap <C-CR> <End><CR>
nnoremap <C-CR> mzo<ESC>`z

" add a blank line over the cursor line
imap <C-S-CR> <Home><CR><Up>
nnoremap <C-S-CR> mzO<ESC>`z

" These are setted in iTerm2 preferences at profile->keys
" They are important for pressing Ctrl + Shift key-bindings
" vim couldn't catch Ctrl + Shift same time
" So, iTerms send specific charactor when press Ctrl + Shift
map ✠ <C-CR>
imap ✠ <C-CR>
map ✢ <C-S-CR>
imap ✢ <C-S-CR>

" Move a line under the cursor
nnoremap <C-S-Up> "zdd<Up>"zP
noremap <C-S-Down> "zdd"zp

" Move lines under the cursor
vnoremap <C-S-Up> "zx<Up>"zP`[V`]
vnoremap <C-S-Down> "zx"zp`[V`]

"--------------------------------------------------------------- Scroll
"nnoremap <C-k> zzHzz
"nnoremap <C-j> zzLzz
nnoremap <C-k> Hzz
nnoremap <C-j> Lzz

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
nnoremap <C-h> ^
vnoremap <C-h> 100^

" Jump to end of the line
nnoremap <C-l> $
vnoremap <C-l> $

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
set fillchars=fold:.

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
nnoremap <C-i> zA

" Move
"nnoremap <C-k> 10k " move to up 10 lines
"nnoremap <C-j> 10j " move to down 10 lines
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

"------------------------------------------------------------------ Plug-ins

" Plug-in installation
so ${HOME}/dotfiles/.vim/vimrc_includs/plugins.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_dirs.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_completion.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_others.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/plugins_ref.vim

" directory browser
so ${HOME}/dotfiles/.vim/vimrc_includs/unite.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/nerdtree.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/tagbar.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/taglist.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/srcexplorer.vim
so ${HOME}/dotfiles/.vim/vimrc_includs/fzf.vim

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
"so ${HOME}/dotfiles/.vim/vimrc_includs/vim-ref.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/dash.vim

" utilities
so ${HOME}/dotfiles/.vim/vimrc_includs/ag.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/quickrun.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/qfixhome.vim
"so ${HOME}/dotfiles/.vim/vimrc_includs/vdebug.vim

"------------------------------------------------------------------ PHP
" dictionary
autocmd FileType php,ctp :set dictionary=~/.source ~/.vim/dict/php.dict
autocmd FileType php,ctp :set dictionary=~/.vim/dict/php.dict
autocmd FileType php,ctp :set complete+=k/~/.vim/dict/php.dict

" tools
autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc_includs/php.vim
autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc_includs/vim-php-namespace.vim
autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc_includs/php-getter-setter.vim
autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc_includs/vim-php-cs-fixer.vim
autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc_includs/pdv-phpdocumentor-for-vim.vim

"------------------------------------------------------------------ Javascript
" load ESLint
au Filetype javascript cnoremap eslint !clear && node_modules/eslint/bin/eslint.js %<CR>

" for vue
"autocmd BufNewFile,BufRead *.vue tabstop=0 softtabstop=0 shiftwidth=0


filetype on
