set updatetime=10

augroup GitGutter
    autocmd!
    autocmd BufRead,BufNewFile * GitGutterDisable
augroup END


nnoremap ght :GitGutterToggle<CR>
nnoremap ghh :GitGutterLineHighlightsToggle<CR>

" show all hunks
nmap ghl :GitGutterQuickFix<cr>:copen<cr>

" show preview
nmap ghp <Plug>(GitGutterPreviewHunk)

" jump hunk
nmap ghj <Plug>(GitGutterNextHunk)
nmap ghk <Plug>(GitGutterPrevHunk)

" git staged
nmap <leader>gha <Plug>(GitGutterStageHunk)
nmap <leader>ghr <Plug>(GitGutterRevertHunk)

let g:gitgutter_signs             = 1
let g:gitgutter_highlight_lines   = 0
let g:gitgutter_highlight_linenrs = 0
let g:gitgutter_sign_priority     = 10

let g:gitgutter_sign_allow_clobber   = 0
let g:gitgutter_set_sign_backgrounds = 0

let g:gitgutter_sign_added           = '+'
let g:gitgutter_sign_modified        = 'e'
let g:gitgutter_sign_removed         = '_'
let g:gitgutter_sign_removed_first_line = '^_'
let g:gitgutter_sign_removed_above_and_below = '_¯'
let g:gitgutter_sign_modified_removed        = 'e_'

highlight DiffAdd ctermfg=blue guifg=red ctermbg=black guibg=yellow
highlight DiffChange ctermfg=yellow guifg=red ctermbg=black guibg=yellow
highlight DiffDelete ctermfg=red guifg=red ctermbg=black guibg=yellow
highlight DiffText ctermfg=green guifg=red ctermbg=black guibg=yellow

highlight GitGutterAdd ctermfg=blue guifg=red ctermbg=black guibg=yellow
highlight GitGutterChange ctermfg=yellow guifg=red ctermbg=black guibg=yellow
highlight GitGutterDelete ctermfg=red guifg=red ctermbg=black guibg=yellow
highlight GitGutterChangeDelete ctermfg=green guifg=red ctermbg=black guibg=yellow

