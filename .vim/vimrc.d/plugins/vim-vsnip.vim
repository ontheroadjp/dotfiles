" -------------------------------------------
" vim-vsnip
" -------------------------------------------
let g:vsnip_snippet_dirs = [
    \ '~/dotfiles/.vim/snippets',
    \ '~/dotfiles/.vim/plugged/vim-snippets/snippets',
    \ ]

imap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)'
        \ : vsnip#expandable() ? '<Plug>(vsnip-expand)'
        \ : pumvisible() ? '<C-n>' : '<Tab>'

" imap <expr> <Space> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<Space>'

