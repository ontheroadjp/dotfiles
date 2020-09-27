"-------------------------
" General
"-------------------------
set t_Co=256
set t_Sf=[3%dm
set t_Sb=[4%dm

" Background color shuld be the same color as Terminal
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

" Color schema
"-------------------------
"colorscheme Tomorrow-Night-Eighties            " soft colors
"colorscheme desert
"colorscheme koehler
"colorscheme solarized
"colorscheme base16-eighties
colorscheme base16-ocean
"if has('unix')
"    colorscheme base16-ocean
"endif
"colorscheme hybrid                             " black background
"colorscheme lucius                             " soft colors
"colorscheme iceberg
"colorscheme simple-dark
"colorscheme dogrun

" ------------------------- temp ---------------------
"let g:base16_shell_path = expand('~/.config/base16-shell/')
"let base16colorspace="256"
"set background=dark

"hi MatchParen ctermfg=LightGreen ctermbg=blue
"hi MatchParen cterm=none ctermbg=green ctermfg=blue
"hi MatchParen cterm=bold ctermbg=none ctermfg=Magenta
"set noshowmatch
"let loaded_matchparen = 2
"
"set showmatch
"set matchtime=1
"set matchpairs& matchpairs+=<:>
" ------------------------- temp ---------------------

