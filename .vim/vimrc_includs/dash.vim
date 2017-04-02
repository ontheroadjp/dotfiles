"---------------------------------------------------------------------------
" cooperate in Dash.app
"---------------------------------------------------------------------------
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>
"au FileType nim  nmap K :DashNim<CR>\|:redraw!<CR>
