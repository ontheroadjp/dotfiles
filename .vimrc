"map <F5> :wall!<CR>:!glow ~/memo<CR><CR>
nnoremap <C-s> :w<CR>

command Dic !dict <cword>

 " ================================================== Disable default plugins
 " Disable TOhtml.
" let g:loaded_2html_plugin       = 1
"
"  " Disable archive file open and brawse.
" let g:loaded_gzip               = 1
" let g:loaded_tar                = 1
" let g:loaded_tarPlugin          = 1
" let g:loaded_zip                = 1
" let g:loaded_zipPlugin          = 1
"
"  " Disable vimball.
" let g:loaded_vimball            = 1
" let g:loaded_vimballPlugin      = 1
"
"  " Disable netrw plugins.
" let g:loaded_netrw              = 1
" let g:loaded_netrwPlugin        = 1
" let g:loaded_netrwSettings      = 1
" let g:loaded_netrwFileHandlers  = 1
"
"  " Disable `GetLatestVimScript`.
" let g:loaded_getscript          = 1
" let g:loaded_getscriptPlugin    = 1
"
"  " Disable other plugins
" let g:loaded_man                = 1
" let g:loaded_matchit            = 1
" " let g:loaded_matchparen         = 1
" let g:loaded_shada_plugin       = 1
" let g:loaded_spellfile_plugin   = 1
" let g:loaded_tutor_mode_plugin  = 1
" let g:did_install_default_menus = 1
" let g:did_install_syntax_menu   = 1
" let g:skip_loading_mswin        = 1
" let g:did_indent_on             = 1
" let g:did_load_ftplugin         = 1
" let g:loaded_rrhelper           = 1

augroup vim_start_end
    autocmd!
    " remove trailing whitespace when saved
    autocmd BufWritePre * :%s/\s\+$//ge
augroup END

"================================================================ Quickfix
" open:copen, close:ccl
au QuickfixCmdPost *grep* cwindow      " open vimgrep result in quickfix
au QuickfixCmdPost make,grep,grepadd,vimgrep copen  " open quickfix window for :grep
nnoremap <C-up> :copen<CR>                  " open quickfix window
nnoremap <C-y> :ccl<CR>                     " close quickfix window
" nnoremap <up> :cprevious<CR>                " move to previous item
" nnoremap <down> :cnext<CR>                  " move to next item
" nnoremap [Q :<C-u>cfirst<CR>               " move to first item
" nnoremap ]Q :<C-u>clast<CR>                " move to last item

" use ripgrep if installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"================================================================ visuals
" Color schema
so ${HOME}/dotfiles/.vim/vimrc.d/ui/color-schema.vim

" Cursor settings
" let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
" let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
" let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" Status bar
" 0: none
" 1: show when more than two windows
" 2:always show the status-line
set laststatus=2
so ${HOME}/dotfiles/.vim/vimrc.d/ui/vim-status-line.vim

"================================================================ General settings
set encoding=utf-8                              " set charactor code
" set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set nowrap                                       " automatic wordwrap
set backspace=indent,eol,start                   " it can delete newline character be BackSpace key

"set cursorline                                   " show cursor line
set linespace=4

" Clipboard
set clipboard+=unnamed
"set clipboard^=unnamed  " if doesn't work above, use this

" Undo
"if has('persistent_undo')
"  set undodir=~/.vim/undo
"  set undofile
"endif

"--------------------------------------------------------------- Line number
set number                                  " show line number
" set relativenumber                        " show relative line number
nnoremap <C-N><C-N> :set invnumber<CR>          " toggle show/hide line number
nnoremap <C-M><C-M> :setl rnu!<CR>              " toggle normal/relativenumber

"--------------------------------------------------------------- Indent
set expandtab                  " replace tab to space
set tabstop=4                  " indent width
set shiftwidth=4               " auto indent width
set softtabstop=4              " moving width of the consecutive white space
set autoindent                 " to continue indent width in new line
set smartindent                " to determining indent width automatically in new line
" let g:sh_indent_case_labels=1

"--------------------------------------------------------- Backup/Swap file
"set backup                                      " enable swap file
"set backupdir=~/.vim/backup                     " set backup file directory
set nobackup                                     " disable backup file

"set swapfile                                    " enable swap file
"set directory=~/.vim/swap                       " set swap file directory
set noswapfile                                   " disable swap file

"--------------------------------------------------------------- Command
" Save as root user
cabbr w!! w !sudo tee > /dev/null %

" %% to expand current directory in command mode
nmap %e :e %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h/').'/' : '%%'
cnoremap <expr> %$ getcmdtype() == ':' ? expand('%:p/') : '%$'

"------------------------------------------------------------ Terminal
"nnoremap <f3> :term source ~/.zprofile<CR>
"nnoremap <f6> :vert term ++close git log<CR>

"=============================================================== Mode change
" <Leader> = \ (default)
"let mapleader = "\<Space>"              " changing <Leader>

" JJ, jk, kj  as <esc>
"inoremap <silent> jj <esc>
inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" visual mode to normal mode
vnoremap n <C-c>

" change insert-normal mode
inoremap <C-n> <C-o>
inoremap <C-n> <C-o>

"------------------------------------------------------------- Window
nnoremap -- :split<CR>                  " horizontal split
nnoremap \\ :rightbelow vsp<CR>         " virtical split
set winheight=25
map ✩ <C-S-k-from-iterm2>
map ✡ <C-S-j-from-iterm2>
nnoremap <C-S-k-from-iterm2> <C-w>k
noremap <C-S-j-from-iterm2> <C-w>j

nnoremap <C-w><C-w> <C-w>o

"nnoremap \2 :close<CR>                 " close window
"nnoremap \h <C-w>h                     " move to left window
"nnoremap \j <C-w>j                     " move to bottom window
"nnoremap \k <C-w>k                     " move to above window
"nnoremap \l <C-w>l                     " move to right window
"nnoremap \q <c-w><c-w>                 " move between window
"nnoremap TT <C-w>T

"----------------------------------------------------------------- Tab
"nnoremap <silent> tn :tabnew<CR>        " open new tab
"nnoremap <silent> <Tab> :tabn<CR>       " change to next tab
"nnoremap <silent> <S-Tab> :tabp<CR>     " change to previous tab
"nnoremap <silent> t] :tabmove +<CR>     " move tab to right
"nnoremap <silent> t[ :tabmove -<CR>     " move tab to left

"--------------------------------------------------------------- Buffer
" nnoremap <silent> yt :buffers<CR>
" nnoremap <silent> yb :bprevious<CR>
" nnoremap <silent> ]b :bnext<CR>
" nnoremap <silent> [B :bfirst<CR>
" nnoremap <silent> ]B :blast<CR>

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

" inoremap <C-k> <Up>
" inoremap <C-j> <Down>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

inoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"--------------------------------------------------------------- Scroll

nnoremap <C-k> Hzz
nnoremap <C-j> Lzz

nnoremap <C-k> 5kzz
nnoremap <C-j> 5jzz

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
"set ignorecase                  " search regardress capital note or small note if search word is small note (noignorecase)
set smartcase                   " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                   " to enable incremental search
" nnoremap n nzz                 " move center of display when search (n)
" nnoremap N Nzz                 " move center of display when search (N)

" highlight a word under the cursor
" nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> <Space><Space> *N

set shortmess-=S
" nnoremap <expr> c/ _(":%s/<Cursor>//gn")
" function! s:move_cursor_pos_mapping(str, ...)
"     let left = get(a:, 1, "<Left>")
"     let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
"     return substitute(a:str, '<Cursor>', '', '') . lefts
" endfunction
"
" function! _(str)
"     return s:move_cursor_pos_mapping(a:str, "\<Left>")
" endfunction



"-------------------------------------------------------------- Folding
set foldmethod=indent       "Folding range
"set foldlevel=0            "Default level of folding when a file is opened
" set foldcolumn=1            "Add an area to the left edge to show the folded state
set fillchars=fold:.
set fillchars=foldopen:@
set fillchars=foldsep:.

"" Region of cursor
"" zO  -- Open all folds under the cursor recursively
"nnoremap <C-h> zc " close
"nnoremap <C-l> zO " open

"" Whole file
"" zm -- Fold more
"" zr -- Reduce folding
"nnoremap <C-> zM	    " close all folds
"nnoremap <C-k> zR	    " open all folds
nnoremap <C-i> zA	    " Toggle flds

"----------------------------------------------------------- yank & put
nnoremap p gp
nnoremap P gP
nnoremap gp p
nnoremap gP P

" " past in normalmode
" if &term =~ "xterm"
"     let &t_ti .= "\e[?2004h"
"     let &t_te .= "\e[?2004l"
"     let &pastetoggle = "\e[201~"
"     if !exists('*XTermPasteBegin')
"         function XTermPasteBegin(ret)
"             set paste
"             return a:ret
"         endfunction
"     endif
"     noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
"     inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
"     cnoremap <special> <Esc>[200~ <nop>
"     cnoremap <special> <Esc>[201~ <nop>
" endif

"------------------------------------------------------------------- Plugins
" so ${HOME}/dotfiles/.vim/vimrc.d/neobundle-management.vim	    "  NeoBundle
so ${HOME}/dotfiles/.vim/vimrc.d/vim-plug-management.vim	    " vim-plug
runtime! vimrc.d/editing.vim

"------------------------------------------- By filetype (note ":help" in vim)
autocmd BufNewFile,BufRead *.{html,htm,ejs*,js,vue} set filetype=html.javascript.vue
autocmd BufNewFile,BufRead *.{sh,profile,fnc,bats} set filetype=bash
autocmd BufNewFile,BufRead *.{zshrc,zprofile,zshenv,conf} set filetype=zsh

augroup shell
    autocmd!
    autocmd BufNewFile,BufRead *.{sh,bash,fnc} 0r $HOME/dotfiles/.vim/templates/sh.tpl
    autocmd BufNewFile,BufRead *.{bats} 0r $HOME/dotfiles/.vim/templates/bats.tpl
augroup END
augroup PHP
    autocmd!
    au BufNewFile,BufRead *.php set ft=php.html.bootstrap.laravel.cdn.javascript.vue
    au BufRead,BufNewFile *.php let php_sql_query = 1            " PHP settings
    au BufRead,BufNewFile *.php let php_baselib = 1              " PHP settings
    au BufRead,BufNewFile *.php let php_htmlInStrings = 1        " PHP settings
    au BufRead,BufNewFile *.php let php_noShortTags = 1          " PHP settings
    au BufRead,BufNewFile *.php let php_parent_error_close = 1   " PHP settings
    au BufRead,BufNewFile *.php let g:sql_type_default='mysql'   " DB settings
    " dictionary
    au FileType php,ctp :set dictionary=~/.source ~/vim/dict/php.dict
    au FileType php,ctp :set dictionary=~/vim/dict/php.dict
    au FileType php,ctp :set complete+=k/~/vim/dict/php.dict
augroup END
augroup Javascript
    autocmd!
    autocmd BufNewFile *.vue 0r $HOME/dotfiles/.vim/templates/vue.tpl
    " load ESLint
    au Filetype javascript cnoremap eslint !clear && node_modules/eslint/bin/eslint.js %<CR>
    au BufNewFile,BufRead *.vue tabstop=0 softtabstop=0 shiftwidth=0
augroup END
augroup Python
    autocmd!
    autocmd BufNewFile *.{py} 0r $HOME/dotfiles/.vim/templates/python.tpl
    " linter
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>li :call Run('ruff check')<CR>
    " test
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>te :call Run('pytest')<CR>
    " formatter
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>fo :call Run('isort --profile black','black')<CR>

    function! ExecShellCmd(command)
        let temp_file = tempname()
        execute 'silent! :!'.a:command.' > '.temp_file
        let output = join(readfile(temp_file), "\n")
        call delete(temp_file)
        return output
    endfunction

    function! Run(...) abort
        let result = ExecShellCmd('git status --short | wc -l')
        if trim(result) == 0
            let l:file = expand('%:p/')
            for n in a:000
                call setqflist([], ' ', {'lines' : systemlist(n.' '.l:file)})
            endfor
            copen
            normal! <CR>
            redraw!
        else
            redraw!
            echo '[abort] need git commit first'
        endif
    endfunction
augroup END

filetype on

