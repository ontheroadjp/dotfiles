"--------------------------------------------------------------------------------
" vim status-line
"--------------------------------------------------------------------------------
set laststatus=2
set statusline=%<     " line break point when line is too long
set statusline+=[%n]  " buffer number
set statusline+=%m    " %m editing flag
set statusline+=%r    " %r readonly flag
set statusline+=%h    " %h help buffer flag
set statusline+=%w    " %w preview window flat
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " show fenc and ff
set statusline+=%y    " show file type in buffer
set statusline+=\     " white space
if winwidth(0) >= 130
	set statusline+=%F    " show full path of the file in current buffer
else
	set statusline+=%t    " show only file name
endif
set statusline+=%=    " separate charactor for left block and right block
set statusline+=%{fugitive#statusline()}  " show Git branch name (must be tpope/fugitive plug-in)
set statusline+=\ \   " white space twice
set statusline+=%1l   " show line number at the cursor
set statusline+=/
set statusline+=%L    " show total line number
set statusline+=,
set statusline+=%c    " show column number at a cursor
set statusline+=%V    " show column number of the monitor at a cursor
set statusline+=\ \   " white space twice
set statusline+=%P    " show cursor position as % of the file

" change color of the status line
au InsertEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=white cterm=none
