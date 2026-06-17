"-------------------------
" My color
"-------------------------
function! s:apply_my_highlights() abort
    " Background color should be the same color as Terminal
    hi Normal ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
    hi LineNr guifg=Blue guibg=NONE gui=none ctermfg=gray ctermbg=NONE cterm=none

    " Window vertical split bar
    hi VertSplit guifg=Blue guibg=DarkGray gui=none ctermfg=Black ctermbg=Black cterm=none
    set fillchars+=vert::

    " Match brackets
    hi MatchParen ctermbg=blue guibg=lightblue

    " Search highlight
    hi Search    ctermfg=Black ctermbg=Yellow guifg=#2E3440 guibg=#EBCB8B gui=none cterm=none
    hi IncSearch ctermfg=Black ctermbg=Cyan   guifg=#2E3440 guibg=#88C0D0 gui=none cterm=none

    " Folding
    hi Folded guifg=Black guibg=Black gui=none ctermfg=Blue ctermbg=Black cterm=none
    hi FoldColumn guifg=Blue guibg=DarkGray gui=none ctermfg=Blue ctermbg=Black cterm=none

    " comment line
    hi Comment ctermfg=Gray guifg=Gray

    " Sign column
    hi SignColumn ctermfg=white guifg=black ctermbg=black guibg=black

    " Quickfix
    hi QuickFixLine ctermbg=Yellow guibg=Yellow
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call s:apply_my_highlights()
augroup END

"-------------------------
" Color settings
"-------------------------
set background=dark
colorscheme base16-ocean
call s:apply_my_highlights()
