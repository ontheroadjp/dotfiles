"---------------------------------------------------------------------------
" unite.vim
"---------------------------------------------------------------------------
" start in inline mode
let g:unite_enable_start_insert=1

" regardless capital letter or small letter
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" twice "ESC" to close
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" twice "j" to close
au FileType unite nnoremap <silent> <buffer> jj :q<CR>
au FileType unite inoremap <silent> <buffer> jj <ESC>:q<CR>

" "jk" to close
au FileType unite nnoremap <silent> <buffer> jk :q<CR>
au FileType unite inoremap <silent> <buffer> jk <ESC>:q<CR>

" "kj" to close
au FileType unite nnoremap <silent> <buffer> kj :q<CR>
au FileType unite inoremap <silent> <buffer> kj <ESC>:q<CR>

" twice "," to close
au FileType unite nnoremap <silent> <buffer> ,, :q<CR>
au FileType unite inoremap <silent> <buffer> ,, <ESC>:q<CR>

" open in horizontal window
au FileType unite nnoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-h> unite#do_action('split')

" open in virtical window
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')

" Ignore files/dirs inside of .gitignore and .git/
" function! s:unite_gitignore_source()
"     let sources = []
"     if filereadable('./.gitignore')
"         for file in readfile('./.gitignore')
"           " コメント行と空行は追加しない
"             if file !~ "^#\\|^\s\*$"
"                 call add(sources, file)
"             endif
"         endfor
"     endif
"     if isdirectory('./.git')
"         call add(sources, '.git')
"     endif
"     call add(sources, '.git')
"     call add(sources, 'node_modules')
"     call add(sources, 'venv')
"     call add(sources, '.pytest_cache')
"     call add(sources, '.ruff_cache')
"     call add(sources, '*.cache')
"     call add(sources, 'Dropbox')
"     call add(sources, '.egg-info')
"     let pattern = escape(join(sources, '|'), './|')
"     call unite#custom#source('file_rec,file_rec/async', 'ignore_pattern', pattern)
"     call unite#custom#source('grep', 'ignore_pattern', pattern)
" endfunction
" call s:unite_gitignore_source()

" ----------------------------
" The prefix key.
nnoremap    [unite]   <Nop>
nmap    ,f [unite]

" unite.vim keymap
nnoremap <silent> [unite]r :<C-u>Unite<Space>file_mru buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>

nnoremap <silent> [unite]w :<C-u>call unite#start([['file', '~/WORKSPACE']])<CR>
" nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search line -start-insert -no-quit<CR>
nnoremap <silent> [unite]/ :<C-u>Unite -buffer-name=search line -start-insert<CR>

"nnoremap [unite]u  :<C-u>Unite -no-split<Space>
"nnoremap <silent> [unite]g :<C-u>Unite<Space>grep:. -buffer-name=search-buffer<CR>
"nnoremap <silent> [unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"nnoremap <silent> [unite]c :<C-u>Unite<Space>file_rec<CR>
"nnoremap <silent> [unite]c :<C-u>Unite<Space>file_rec/asyn<CR>
"nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"nnoremap <silent> [unite]m :<C-u>Unite<Space>bookmark<CR>
"nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"nnoremap <silent> [unite]p :<C-u>Unite<Space>file_point<CR>
"noremap <silent> [unite]y :<C-u>Unite<Space>register<CR>
"nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"nnoremap <silent> [unite]d :<C-u>Unite<Space>directory/new<CR>
"nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>
" nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"nnoremap <silent> [unite]v :<C-u>UniteWithBufferDir file<CR>
"nnoremap <silent> <Leader><Leader> :UniteResume<CR>
"endif

