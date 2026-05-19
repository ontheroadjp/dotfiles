" set rtp+=

" If you do not load the plugin first,
" the command defined in this file may be unknown.
call plug#load('fzf.vim')
call plug#load('mr.vim')

let $FZF_DEFAULT_OPTS="
    \ -0
    \ -1
    \ --reverse
    \ --multi
    \ --height=100%
    \ --pointer='👉'
    \ --prompt=': '
    \ --color='bg+:#242C43,bg:black,spinner:#81A1C1,hl:#616E88'
    \ --color='fg:#D8DEE9,header:#616E88,info:#81A1C1,pointer:#81A1C1'
    \ --color='marker:#81A1C1,fg+:#A9D889,prompt:#81A1C1,hl+:#81A1C1'
    \ --bind ctrl-l:abort
    \ "

let g:fzf_layout = { 'up': '60%' }

" preview
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['hidden,right,50%,<70(up,40%)', 'ctrl-/']

"" This is the default extra key bindings
"let g:fzf_action = {
"    \ 'ctrl-t': 'tab split',
"    \ 'ctrl-x': 'split',
"    \ 'ctrl-v': 'vsplit' }
"
"
"" An action can be a reference to a function that processes selected lines
"function! s:build_quickfix_list(lines)
"    call setqflist(map(copy(a:lines), '{ "filename": v:val, "lnum": 1 }'))
"    copen
"    cc
"endfunction
"
"let g:fzf_action = {
"  \ 'ctrl-f': function('s:build_quickfix_list'),
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }
"
"-----------------------------------------------
" tag search
"-----------------------------------------------
nnoremap <silent> ,ft :call fzf#vim#tags(expand('<cword>'))<CR>

"-----------------------------------------------
" list subdir
"-----------------------------------------------
nnoremap <silent> ,sub :Files<CR>

"-----------------------------------------------
" list mru
"-----------------------------------------------
function! s:mru_source() abort
    return mr#mru#list()
endfunction

function! s:FZFMru() abort
    call fzf#run(fzf#wrap('FZFMru', {
          \ 'source': s:mru_source(),
          \ 'sink': 'e',
          \ 'options': '--header "MRU Files by mr.vim"'
          \ }))
endfunction
command! FZFMru call <SID>FZFMru()
nnoremap <silent> ,fr :FZFMru<CR>

"-----------------------------------------------
" list specific dirs: ww (WORKSPACE), dd (dotfiles), rr (GHQ)
"-----------------------------------------------
command! -nargs=1 FZFFd call fzf#run(fzf#wrap('FZFFd', {
      \ 'source': printf('fd
            \ --type f
            \ --hidden
            \ --follow
            \ --exclude .DS_Store
            \ --exclude .git
            \ --exclude .node_modules
            \ --exclude .venv
            \ --exclude .__pycache__
            \ --exclude .gems
            \ "" %s
            \'
            \, shellescape(expand(<q-args>))
            \ ),
      \ 'sink': 'e',
      \ 'options': printf('--header "fd search in %s"', expand(<q-args>))
      \ }))

if isdirectory(expand('~/WORKSPACE'))
    nnoremap <silent> ,ww :FZFFd ~/WORKSPACE<CR>
endif

if isdirectory(expand('~/dotfiles'))
    nnoremap <silent> ,dd :FZFFd ~/dotfiles<CR>
endif

if executable('ghq')
    function! s:ghq_root_fd()
      let l:dir = trim(system('ghq root'))
      execute 'FZFFd' fnameescape(l:dir)
    endfunction
    nnoremap <silent> ,rr :call <SID>ghq_root_fd()<CR>
endif

