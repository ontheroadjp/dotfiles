" Plugin Install: :PlugInstall
" Plugin Uninstall: :PlugClean
" Show Plugin State: PlugState

call plug#begin()
Plug '/usr/local/opt/fzf'
Plug 'lambdalisue/mr.vim'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript', 'vue', 'ejs']}
Plug 'ontheroadjp/dirmarks'
Plug 'ontheroadjp/vim-commentout'
Plug 'ontheroadjp/vim-brackets'
call plug#end()

" ----------------------------------------------------
"  Load settings
" ----------------------------------------------------
so ${HOME}/dotfiles/.vim/vimrc.d/plugins/fzf.vim

function s:lazy_load_plugs_settings(timer)
    " completion
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/supertab.vim

    " snippets
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/snipmate.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-emmet.vim

    " editing
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/surround.vim
    so ${HOME}/dotfiles/.vim/vimrc.d/plugins/vim-commentout.vim

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

