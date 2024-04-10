" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap ,. <Plug>(easymotion-s2)

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map sj <Plug>(easymotion-j)
map sk <Plug>(easymotion-k)
map ml <Plug>(easymotion-overwin-line)



