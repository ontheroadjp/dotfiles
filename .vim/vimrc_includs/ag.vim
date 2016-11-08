"---------------------------------------------------------------------------
" settings for rking/ag(grep → ag)
"---------------------------------------------------------------------------
"for Unite grep
"---------------------------------------------------------------------------
" grep search
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" grep search at cursor
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" show result for grep search again
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

" useing ag(The Silver Searcher) in unite grep
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif
