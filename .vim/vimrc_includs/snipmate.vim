let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php'

" PHP file
au BufRead *.php set ft=php.html.bootstrap.laravel.cdn.javascript
au BufNewFile *.php set ft=php.html.bootstrap.laravel.cdn.javascript

" HTML file
au BufRead *.html set ft=html.bootstrap.cdn.javascript.vue
au BufNewFile *.html set ft=html.bootstrap.cdn.javascript.vue
