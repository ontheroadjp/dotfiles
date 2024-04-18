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
colorscheme base16-ocean

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
    " Match brackets
    au Vimenter * hi MatchParen ctermbg=blue guibg=lightblue
    " Search highlight
    au VimEnter * hi Search guifg=Blue guibg=DarkGray gui=none ctermfg=White ctermbg=Blue cterm=none
    " Folding
    au VimEnter * hi Folded guifg=Blue guibg=DarkGray gui=none ctermfg=Black ctermbg=Black cterm=none
    set fillchars=fold:.
    " Quickfix
    au QuickfixCmdPost * hi QuickFixLine ctermbg=Yellow guibg=Yellow
augroup END
