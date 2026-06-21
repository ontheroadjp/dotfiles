" ----------------------------------------------------
" vim-plug
" ----------------------------------------------------
" Plugin Install: :PlugInstall
" Plugin Uninstall: :PlugClean
" Show Plugin State: PlugStatus
" ----------------------------------------------------
" mode0: SuperTab + SnipMate
" mode1: asyncomplete + vim-vsnip
let plugin_env = { 'mode': 0 }

" ----------------------------------------------------
" check the specified plugin is installed
" ----------------------------------------------------
" function! IsPlugged(name) abort
"     if exists('g:plugs')
"             \ && has_key(g:plugs, a:name)
"             \ && isdirectory(g:plugs[a:name].dir)
"         return 1
"     endif
"     return 0
" endfunction

" ----------------------------------------------------
" Register plugins
" ----------------------------------------------------
call plug#begin()
" unite
" Plug 'Shougo/unite.vim', { 'on': [] }
" Plug 'Shougo/neomru.vim', { 'on': [] }
" Plug 'Shougo/vimproc.vim', {'do' : 'make', 'on': [] }

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': [] }
Plug 'lambdalisue/mr.vim', { 'on': [] }

" Filer
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle'] }

" LSP
" Plug 'prabirshrestha/vim-lsp'	                        " LSP
" Plug 'mattn/vim-lsp-settings'	                        " LSP
" Plug 'prabirshrestha/asyncomplete-lsp.vim'	        " LSP/Completion
" Plug 'vim-scripts/AutoComplPop', { 'on': [] }	        " Completion

" Snippet
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'vue', 'ejs']}

" Editing
Plug 'airblade/vim-gitgutter', { 'on': [] }
Plug 'Yggdroot/indentLine', { 'on': [] }
Plug 'tpope/vim-surround', { 'on': [] }
Plug 'ontheroadjp/vim-editing', { 'on': [] }
Plug 'ontheroadjp/vim-commentout', { 'on': [] }
Plug 'ontheroadjp/vim-brackets', { 'on': [] }
Plug 'ontheroadjp/vim-deepl-translate', { 'on': [] }
Plug 'ontheroadjp/core-toolkit-for-gnome', {
    \ 'dir': '~/repo/github.com/ontheroadjp/core-toolkit-for-gnome',
    \ 'rtp': 'scripts/vim-switch-us-input'
    \ }

" Plug 'ontheroadjp/vim-editing', { 'dir': '~/dev/src/github.com/ontheroadjp/vim-editing', 'on': [] }
" Plug 'ontheroadjp/vim-commentout', { 'dir': '~/dev/src/github.com/ontheroadjp/vim-commentout', 'on': [] }
" Plug 'ontheroadjp/vim-brackets', { 'dir': '~/dev/src/github.com/ontheroadjp/vim-brackets' }
" Plug 'ontheroadjp/vim-deepl-translate', { 'dir': '~/dev/src/github.com/ontheroadjp/vim-deepl-translate' }

" GitHub
Plug 'ontheroadjp/vim-gh', { 'on': [] }
" Plug 'ontheroadjp/vim-gh', { 'dir': '~/dev/src/github.com/ontheroadjp/vim-gh' }

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

" ----------------------------------------------------
"  Load settings
" ----------------------------------------------------
function! plugin_env.lazy_load_plugs_settings(timer) abort
    " so ${VIM_HOME}/.vim/vimrc.d/plugins/unite.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/nerdtree.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-gitgutter.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-emmet.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/surround.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/indentLine.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-commentout.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-brackets.vim
    so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-deepl-translate.vim
    if self.mode == 0
        so ${VIM_HOME}/.vim/vimrc.d/plugins/supertab.vim
        so ${VIM_HOME}/.vim/vimrc.d/plugins/snipmate.vim
    elseif self.mode == 1
        so ${VIM_HOME}/.vim/vimrc.d/plugins/asyncomplete.vim
        so ${VIM_HOME}/.vim/vimrc.d/plugins/vim-vsnip.vim
    endif
    " filer
    so $VIM_HOME/.vim/vimrc.d/plugins/fzf.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/tagbar.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/taglist.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/srcexplorer.vim
    " lsp
    " so $VIM_HOME/.vim/vimrc.d/plugins/vim-lsp.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/vim-lsp-settings.vim
    " moving cursor
    " so $VIM_HOME/.vim/vimrc.d/plugins/vim-easymotion.vim
    " completion
    " so $VIM_HOME/.vim/vimrc.d/plugins/autocomplpop.vim
    " reference
    " so $VIM_HOME/.vim/vimrc.d/plugins/vim-ref.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/dash.vim
    " utilities
    " so $VIM_HOME/.vim/vimrc.d/plugins/quickrun.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/qfixhome.vim
    " so $VIM_HOME/.vim/vimrc.d/plugins/vdebug.vim
    augroup PHP
        autocmd!
        autocmd BufNewFile,BufRead *.php
            \ so $VIM_HOME/.vim/vimrc.d/plugins/php.vim
        autocmd BufNewFile,BufRead *.php
            \ so $VIM_HOME/.vim/vimrc.d/plugins/vim-php-namespace.vim
        autocmd BufNewFile,BufRead *.php
            \ so $VIM_HOME/.vim/vimrc.d/plugins/php-getter-setter.vim
        autocmd BufNewFile,BufRead *.php
            \ so $VIM_HOME/.vim/vimrc.d/plugins/vim-php-cs-fixer.vim
        autocmd BufNewFile,BufRead *.php
            \ so $VIM_HOME/.vim/vimrc.d/plugins/pdv-phpdocumentor-for-vim.vim
    augroup END
endfunction
call timer_start(100, plugin_env.lazy_load_plugs_settings)

" ----------------------------------------------------
"  Plugins Load
" ----------------------------------------------------
function! plugin_env.lazy_load_plugs(timer) abort
    call plug#load(
        \ 'fzf.vim',
        \ 'mr.vim',
        \ 'nerdtree',
        \ 'vim-snippets',
        \ 'vim-gitgutter',
        \ 'indentLine',
        \ 'vim-surround',
        \ 'vim-editing',
        \ 'vim-commentout',
        \ 'vim-brackets',
        \ 'vim-deepl-translate',
        \ 'vim-gh',
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
call timer_start(200, plugin_env.lazy_load_plugs)

