" -------------------------------------------------
" asyncomplete.vim
" -------------------------------------------------
" 0:black	       1:red	         2:green	     3:yellow	     4:blue
" 5:pink	       6:cyan	         7:light-gray	 8:gray	         9:light-red
"10:light-green   11:light-yellow	12:light-blue	13:light-pink	14: light-cyan
"15: white

hi Pmenu ctermbg=7	        " background
hi PmenuSel ctermbg=5	    " selected
hi PmenuSbar ctermbg=4	    " scroll bar
hi PmenuThumb ctermfg=3	    " lever of the scroll bar

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" Source: Buffer
au User asyncomplete_setup call asyncomplete#register_source(
        \ asyncomplete#sources#buffer#get_source_options({
                \ 'name': 'buffer',
                \ 'allowlist': ['*'],
                \ 'blocklist': ['go'],
                \ 'completor': function('asyncomplete#sources#buffer#completor'),
                \ 'config': {
                \    'max_buffer_size': 5000000,
                \  },
                \ }))

" Source: File
au User asyncomplete_setup call asyncomplete#register_source(
        \ asyncomplete#sources#file#get_source_options({
                \ 'name': 'file',
                \ 'allowlist': ['*'],
                \ 'priority': 10,
                \ 'completor': function('asyncomplete#sources#file#completor')
                \ }))

" Source: Omni
au User asyncomplete_setup call asyncomplete#register_source(
        \ asyncomplete#sources#omni#get_source_options({
                \ 'name': 'omni',
                \ 'allowlist': ['*'],
                \ 'blocklist': ['c', 'cpp', 'html'],
                \ 'completor': function('asyncomplete#sources#omni#completor'),
                \ 'config': {
                \   'show_source_kind': 1,
                \ },
                \ }))
