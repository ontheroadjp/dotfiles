" -------------------------------------------
" SnipMate
" -------------------------------------------
" vim-snipmate load snippets files named *.snippets in runtimepath dir
" so add my own snippets dir into runtimepath
set runtimepath+=~/.vim/snippets

" Popup window
" let g:snipMate.description_in_completion = 1
inoremap <C-u> <Plug>snipMateShow

" This is very important mapping below.
" But in case of using the ontheroad/vim-bracket plugin-in,
" you don't need this because the plug-in has this function.

" inoremap <expr> <CR> pumvisible()
"     \ ? "<Esc>a<C-R>=snipMate#TriggerSnippet()<CR>"
"     \ : "\<CR>"

" open snipet files
nmap <Leader>snip :e ~/dotfiles/.vim/snippets/

" for SnipMate
" let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
" let g:snipMate.scope_aliases = {}
" let g:snipMate.scope_aliases['php'] = 'php'

