" vim-sunipmate load snippets files named *.snippets in runtimepath dir
" so add my own snippets dir into runtimepath
set runtimepath+=/.vim/snippets

" open files
nmap <Leader>sni :e ~/dotfiles/.vim/snippets
" runtime! vimrc.d/snippets/*.snippets

" for SnipMate
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php'

" PHP file
au BufRead *.php set ft=php.html.bootstrap.laravel.cdn.javascript.vue
au BufNewFile *.php set ft=php.html.bootstrap.laravel.cdn.javascript.vue

" HTML file
au BufRead *.html set ft=html.bootstrap.cdn.javascript.vue
au BufNewFile *.html set ft=html.bootstrap.cdn.javascript.vue

" vue file
au BufRead *.vue set ft=html.bootstrap.cdn.javascript.vue
au BufNewFile *.vue set ft=html.bootstrap.cdn.javascript.vue
