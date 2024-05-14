set rtp+=


" This is the default extra key bindings
let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }


" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
    copen
    cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'up': '60%' }

" preview
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']

"-----------------------------------------------
" tag search
"-----------------------------------------------
nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>

"-----------------------------------------------
" file search
"-----------------------------------------------
nnoremap <silent> ,ff :Files<CR>

"-----------------------------------------------
" mru search
"-----------------------------------------------
nnoremap <silent> ,fr :FZFMru<CR>
" \ 'source':  v:oldfiles,
" \ 'source': mr#mru#list(),
" \ 'source':  mr#mrw#list(),
" \ 'source':  mr#mrr#list(),
" \ 'bind': 'ctrl-f:change-prompt(mr.vim> )+reload(mr#mru#list()',
" \ 'bind': 'ctrl-d:change-prompt(v:oldfiles> )+reload(v:oldfiles)',
command! FZFMru call fzf#run({
    \ 'header': 'CTRL-D: Directories / CTRL-F: Files',
    \ 'source':  mr#mru#list(),
    \ 'sink':    'e',
    \ 'options': '-m -x +s'})

"-----------------------------------------------
" GHQ
"-----------------------------------------------
nnoremap <silent> ,fg :Ghq<CR>
function! CdFind(dir)
    cd `=a:dir`
    edit `=a:dir`
    GFiles
    call feedkeys('i', 'n')
endfunction

if executable('ghq')
command! -bang -nargs=0 Ghq
    \ call fzf#run({
    \   'source': 'ghq list --full-path',
    \   'sink': function('CdFind')})
endif

"-----------------------------------------------
" RG
"-----------------------------------------------
if executable('rg')
    command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --hidden --line-number --no-heading '.shellescape(<q-args>), 0,
        \   fzf#vim#with_preview({'options': '--exact --reverse --delimiter : --nth 3..'}))
endif

