"---------------------------------------------------------------------------
" settings for Unit.vim
" note: http://blog.remora.cx/2010/12/vim-ref-with-unite.html
"---------------------------------------------------------------------------
"if ! empty(neobundle#get("unite"))

" start in inline mode
let g:unite_enable_start_insert=1

" regardless capital letter or small letter
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" twice "ESC" to close
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" twice "f" to close
au FileType unite nnoremap <silent> <buffer> jj :q<CR>
au FileType unite inoremap <silent> <buffer> jj <ESC>:q<CR>

" twice "," to close
au FileType unite nnoremap <silent> <buffer> ,, :q<CR>
au FileType unite inoremap <silent> <buffer> ,, <ESC>:q<CR>

" open in horizontal window
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" open in virtical window
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

" ----------------------------
"" unite.vim {{{
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    ,f [unite]

" unite.vim keymap
nnoremap <silent> [unite]f :<C-u>Unite<Space>file_rec<CR>
nnoremap <silent> <c-p> :<C-u>Unite<Space>file_rec<CR>

nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> <c-e> :<C-u>Unite<Space>file_mru<CR>

"nnoremap [unite]u  :<C-u>Unite -no-split<Space>
"nnoremap <silent> [unite]c :<C-u>Unite<Space>file<CR>
"nnoremap <silent> [unite]g :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR>
"nnoremap <silent> [unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
"nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"nnoremap <silent> [unite]p :<C-u>Unite<Space>file_point<CR>
"jnoremap <silent> [unite]y :<C-u>Unite<Space>register<CR>
"nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"nnoremap <silent> [unite]d :<C-u>Unite<Space>directory/new<CR>
"nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>outline<CR>
"nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
"nnoremap <silent> <Leader><Leader> :UniteResume<CR>

"" }}}

"endif

