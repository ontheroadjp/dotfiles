" ----------------------------------------------------
" vim-plug
" ----------------------------------------------------
" Plugin Install: :PlugInstall
" Plugin Uninstall: :PlugClean
" Show Plugin State: PlugState
" ----------------------------------------------------
" mode0: SuperTab + SnipMate
" mode1: asyncomplete + vim-vsnip
let plugin_env = { 'mode': 0 }

" check the specified plugin is installed
function! IsPlugged(name) abort
    if exists('g:plugs')
            \ && has_key(g:plugs, a:name)
            \ && isdirectory(g:plugs[a:name].dir)
        return 1
    endif
    return 0
endfunction

call plug#begin()
" Core
Plug 'Shougo/unite.vim', { 'on': [] }
Plug 'Shougo/neomru.vim', { 'on': [] }
Plug 'Shougo/vimproc.vim', {'do' : 'make', 'on': [] }
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle'] }

" Snippet
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'vue', 'ejs']}

" Editing
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'tpope/vim-surround', { 'on': [] }
Plug 'Yggdroot/indentLine', { 'on': [] }
Plug 'ontheroadjp/vim-commentout', { 'on': [] }
Plug 'ontheroadjp/vim-brackets', { 'on': [] }

if plugin_env.mode == 0
    Plug 'ervandew/supertab', { 'on': [] }
    Plug 'garbas/vim-snipmate', { 'on': [] }
    Plug 'MarcWeber/vim-addon-mw-utils', { 'on': [] }
    Plug 'tomtom/tlib_vim', { 'on': [] }
elseif plugin_env.mode == 1
    Plug 'prabirshrestha/asyncomplete.vim', { 'on': [] }
    Plug 'prabirshrestha/asyncomplete-buffer.vim', { 'on': [] }
    Plug 'prabirshrestha/asyncomplete-file.vim', { 'on': [] }
    Plug 'yami-beta/asyncomplete-omni.vim', { 'on': [] }
    Plug 'hrsh7th/vim-vsnip', { 'on': [] }
    Plug 'hrsh7th/vim-vsnip-integ', { 'on': [] }
endif
call plug#end()

" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }	" Filter
" Plug 'junegunn/fzf.vim'	                            " Filter
" Plug '/usr/local/opt/fzf'	                            " Filter
" Plug 'lambdalisue/mr.vim'	                            " Filter
" Plug 'prabirshrestha/vim-lsp'	                        " LSP
" Plug 'mattn/vim-lsp-settings'	                        " LSP
" Plug 'prabirshrestha/asyncomplete-lsp.vim'	        " LSP/Completion
" Plug 'vim-scripts/AutoComplPop', { 'on': [] }	        " Completion

" ----------------------------------------------------
"  Plugins Load
" ----------------------------------------------------
function! plugin_env.lazy_load_plugs(timer) abort
    call plug#load(
        \ 'unite.vim',
        \ 'neomru.vim',
        \ 'vimproc.vim',
        \ 'nerdtree',
        \ 'vim-gitgutter',
        \ 'vim-snippets',
        \ 'vim-surround',
        \ 'indentLine',
        \ 'vim-commentout',
        \ 'vim-brackets',
        \ )
    if self.mode == 0
        call plug#load(
            \ 'supertab',
            \ 'vim-addon-mw-utils',
            \ 'vim-snipmate',
            \ 'tlib_vim',
            \ )
    elseif self.mode == 1
        call plug#load(
            \ 'asyncomplete.vim',
            \ 'asyncomplete-buffer.vim',
            \ 'asyncomplete-file.vim',
            \ 'asyncomplete-omni.vim',
            \ 'vim-vsnip',
            \ 'vim-vsnip-integ',
            \ )
    endif
endfunction
call timer_start(20, plugin_env.lazy_load_plugs)

" ----------------------------------------------------
"  Load settings
" ----------------------------------------------------
function! plugin_env.lazy_load_plugs_settings(timer) abort
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/unite.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/nerdtree.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-gitgutter.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-emmet.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/surround.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/indentLine.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-commentout.vim
    if self.mode == 0
        so ${HOME}/dotfiles/.vim/vimrc.d/plugins/supertab.vim
        so ${HOME}/dotfiles/.vim/vimrc.d/plugins/snipmate.vim
    elseif self.mode == 1
        so ${HOME}/dotfiles/.vim/vimrc.d/plugins/asyncomplete.vim
        so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-vsnip.vim
    endif
    " filer
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/fzf.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/tagbar.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/taglist.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/srcexplorer.vim
    " lsp
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-lsp.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-lsp-settings.vim
    " moving cursor
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-easymotion.vim
    " completion
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/autocomplpop.vim
    " reference
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-ref.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/dash.vim
    " utilities
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/quickrun.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/qfixhome.vim
    " so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vdebug.vim
    augroup PHP
        autocmd!
        autocmd BufNewFile,BufRead *.php
            \ so ${HOME}/dotfiles/.vim/vimrc.d/plugins/php.vim
        autocmd BufNewFile,BufRead *.php
            \ so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-php-namespace.vim
        autocmd BufNewFile,BufRead *.php
            \ so ${HOME}/dotfiles/.vim/vimrc.d/plugins/php-getter-setter.vim
        autocmd BufNewFile,BufRead *.php
            \ so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-php-cs-fixer.vim
        autocmd BufNewFile,BufRead *.php
            \ so ${HOME}/dotfiles/.vim/vimrc.d/plugins/pdv-phpdocumentor-for-vim.vim
    augroup END
endfunction
call timer_start(30, plugin_env.lazy_load_plugs_settings)

