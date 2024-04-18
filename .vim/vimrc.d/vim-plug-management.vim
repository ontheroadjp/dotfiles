" Plugin Install: :PlugInstall
" Plugin Uninstall: :PlugClean
" Show Plugin State: PlugState

call plug#begin()
" Plug 'https://github.com/Shougo/unite.vim.git'
" Plug 'https://github.com/Shougo/neomru.vim'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'lambdalisue/mr.vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
" Plug 'msanders/snipmate.vim'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'vue', 'ejs']}
Plug 'ontheroadjp/dirmarks'
Plug 'ontheroadjp/vim-commentout'
Plug 'ontheroadjp/vim-brackets'
call plug#end()

" ----------------------------------------------------
"  Load settings
" ----------------------------------------------------
" so ${HOME}/dotfiles/.vim/vimrc.d/plugins/unite.vim
so ${HOME}/dotfiles/.vim/vimrc.d/plugins/fzf.vim

function s:lazy_load_plugs_settings(timer)
    " IDE
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/nerdtree.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/tagbar.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/taglist.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/srcexplorer.vim

    " moving cursor
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-easymotion.vim

    " completion
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/supertab.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/neocomplete.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/neocomplete-php.vim

    " snippets
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/snipmate.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/neosnippet.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-emmet.vim

    " editing
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/surround.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-commentout.vim

    " reference
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-ref.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/dash.vim

    " utilities
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/quickrun.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/qfixhome.vim
    "so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vdebug.vim
    augroup PHP
        autocmd!
        autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc.d/plugins/php.vim
        autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-php-namespace.vim
        autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc.d/plugins/php-getter-setter.vim
        autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-php-cs-fixer.vim
        autocmd BufNewFile,BufRead *.php so ${HOME}/dotfiles/.vim/vimrc.d/plugins/pdv-phpdocumentor-for-vim.vim
    augroup END
endfunction
call timer_start(20, function('s:lazy_load_plugs_settings'))

