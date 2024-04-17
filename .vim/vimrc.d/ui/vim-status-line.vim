"--------------------------------------------------------------------------------
" vim status-line
"--------------------------------------------------------------------------------
" color
au InsertEnter * hi StatusLine guifg=Blue guibg=DarkYellow gui=none ctermfg=Red ctermbg=blue cterm=none
au InsertLeave * hi StatusLine guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=blue  cterm=none
au VimEnter * hi StatusLineNC guifg=Blue guibg=DarkYellow gui=none ctermfg=Green ctermbg=blue cterm=none

" format (light weight)
set statusline=%{fugitive#statusline()}    " show git branch name
set statusline+=[%F]                       " show filename
set statusline+=%m                         " show edit status
set statusline+=%r                         " show read only or not
set statusline+=%h                         " show [HELP] if Help page
set statusline+=%w                         " show [Preview] if Preview window
set statusline+=%=                         " below settings is shown on right side
set statusline+=[%{&fileencoding}]         " file encoding
set statusline+=[%l/%L]                    " current row number/total row number

