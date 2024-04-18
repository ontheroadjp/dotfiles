"-------------------------
" General
"-------------------------
set t_Co=256
" set t_Sf=[3%dm
" set t_Sb=[4%dm

" Background color shuld be the same color as Terminal
autocmd ColorScheme * highlight Normal ctermbg=none
autocmd ColorScheme * highlight LineNr ctermbg=none

"-------------------------
" Color scheme
"-------------------------
" colorscheme Tomorrow-Night-Eighties            " soft colors
" colorscheme anderson
" colorscheme base16-eighties
colorscheme base16-ocean
" colorscheme desert
" colorscheme dogrun
" colorscheme hybrid                             " black background
" colorscheme iceberg
" colorscheme lucius                             " soft colors
" colorscheme simple-dark
" colorscheme solarized

"-------------------------
" Extra
"-------------------------
augroup Visuals
    autocmd!
    " Line number
    au VimEnter * hi LineNr guifg=Blue guibg=DarkGray gui=none ctermfg=gray ctermbg=none cterm=none
    " Window virtical split bar
    au VimEnter * hi VertSplit guifg=Blue guibg=DarkGray gui=none ctermfg=Black ctermbg=Black cterm=none
    set fillchars+=vert::
    " Tab bar
    " au VimEnter * hi TabLine ctermfg=White ctermbg=None      " tab
    " au VimEnter * hi TabLineSel ctermfg=White ctermbg=Blue   " current tab
    " au VimEnter * hi TabLineFill ctermfg=White ctermbg=None  " tabbar
    " Match brackets
    au Vimenter * hi MatchParen ctermbg=blue guibg=lightblue
    " Search highlight
    au VimEnter * hi Search guifg=Blue guibg=DarkGray gui=none ctermfg=White ctermbg=Blue cterm=none
    " Folding
    au VimEnter * hi Folded guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=Black cterm=none
    au VimEnter * hi FoldColumn guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=Black cterm=none
    " sign column
    au VimEnter * hi SignColumn ctermfg=white guifg=black ctermbg=black guibg=black
    " Quickfix
    au QuickfixCmdPost * hi QuickFixLine ctermbg=Yellow guibg=Yellow
augroup END
