"--------------------------------------------------------------------------------
" vim status-line
"--------------------------------------------------------------------------------
" 0:black	       1:red	         2:green	     3:yellow	     4:blue
" 5:pink	       6:cyan	         7:light-gray	 8:gray	         9:light-red
"10:light-green   11:light-yellow	12:light-blue	13:light-pink	14: light-cyan
"15: white
augroup status_line
    au InsertEnter * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=white ctermbg=030  cterm=none
    au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=cyan ctermbg=066  cterm=none
    au WinEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=cyan ctermbg=066 cterm=none
    au WinLeave * hi StatusLineNC guifg=Blue guibg=DarkYellow gui=none ctermfg=cyan ctermbg=240 cterm=none
    au VimEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=cyan ctermbg=240 cterm=none
augroup END

nnoremap <C-g><C-g> :call ToggleStatusLine()<CR>
function! ToggleStatusLine() abort
    if &ls
        set laststatus=0
    else
        set laststatus=2
    endif
endfunction

" <LEFT SIDE>
" set statusline=%{fugitive#statusline()}    " show git branch name
set statusline+=[%n]                       " buffer number
set statusline+=\                       " white space
if winwidth(0) >= 88
    set statusline+=%F    " show full path of the file in current buffer
else
    set statusline+=%t    " show only file name
endif
set statusline+=%m                         " editing flag
set statusline+=%r                         " show read only or not
set statusline+=%h                         " show [HELP] if Help page
set statusline+=%w                         " show [Preview] if Preview window

" <RIGHT SIDE>
set statusline+=%=	                    " below settings is shown on right side
set statusline+=[%c:%l/%L]	            " current row number/total row number
set statusline+=[%{&fileencoding}]	    " file encoding
set statusline+=%y	                    " show file type in buffer

" PARTS
"set statusline=%<     " line break point when line is too long
"set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " show fenc and ff
"set statusline+=%y    " show file type in buffer
"set statusline+=\     " white space
"if winwidth(0) >= 130
"	set statusline+=%F    " show full path of the file in current buffer
"else
"	set statusline+=%t    " show only file name
"endif
"set statusline+=%=    " separate charactor for left block and right block
"set statusline+=%{fugitive#statusline()}  " show Git branch name (must be tpope/fugitive plug-in)
"set statusline+=\ \   " white space twice
"set statusline+=%1l   " show line number at the cursor
"set statusline+=/
"set statusline+=%L    " show total line number
"set statusline+=,
"set statusline+=%V    " show column number of the monitor at a cursor
"set statusline+=%P    " show cursor position as % of the file
"set statusline+=%c    " show column number at a cursor
