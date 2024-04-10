" deniteと合わせて上部に表示
let g:fzf_layout = { 'up': '~40%' }

" <C-]>でタグ検索
nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>

" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1

