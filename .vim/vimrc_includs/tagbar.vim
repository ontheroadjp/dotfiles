"---------------------------------------------------------------------------
" settings for Tagbar
" note: http://rcmdnk.github.io/blog/2014/07/25/computer-vim/#tagbar-srcexpl-nerdtree
"---------------------------------------------------------------------------
if ! empty(neobundle#get("tagbar"))
" Width (default 40)
let g:tagbar_width = 30
" Map for toggle
nn <silent> ,t :TagbarToggle<CR><C-w>l
endif
