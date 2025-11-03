" type 0: Always on the left
" type 1: VSCode style
" type 2: Begining of each line
let g:commentout_type = 1

nnoremap <silent> # <Plug>(commentout-toggle)
vnoremap <silent> # <Plug>(commentout-toggle)
nnoremap <silent> <C-\> <Plug>(commentout-dup)
vnoremap <silent> <C-\> <Plug>(commentout-dup)

