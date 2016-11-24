let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php'

" PHP file
au BufRead *.php set ft=php.html.bootstrap.cdn
au BufNewFile *.php set ft=php.html.bootstrap.cdn

" HTML file
au BufRead *.html set ft=html.bootstrap.cdn
au BufNewFile *.html set ft=html.bootstrap.cdn
