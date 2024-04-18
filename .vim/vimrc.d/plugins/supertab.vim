" ---------------------------------------------
" SuperTab
" ---------------------------------------------
" 0:black	       1:red	         2:green	     3:yellow	     4:blue
" 5:pink	       6:syan	         7:light-gray	 8:gray	         9:light-red
"10:light-green   11:light-yellow	12:light-blue	13:light-pink	14: light-cyan
"15: white

hi Pmenu ctermbg=7	        " background
hi PmenuSel ctermbg=5	    " selected
hi PmenuSbar ctermbg=4	    " scroll bar
hi PmenuThumb ctermfg=3	    " lever of the scroll bar

let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-p>"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
" let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]

" Problem with load order (vimrc is evaluated before latex-box setting of omnifunc)
" \ verbose set omnifunc? | " is empty
" added this autocommand to after/ftplugin/tex.vim
" :do FileType solves also the problem

"autocmd FileType *
"      \ if &omnifunc != '' |
"      \     call SuperTabChain("context") |
"      \     call SuperTabSetDefaultCompletionType(&omnifunc, "<c-p>") |
"      \     call SuperTabSetDefaultCompletionType("<c-x><c-]>") |
"      \     call SuperTabSetDefaultCompletionType("<c-x><c-k>") |
"      \ endif

"autocmd FileType *
"      \ if &omnifunc != '' |
"      \     call SuperTabChain(&omnifunc, "<c-p>") |
"      \     call SuperTabSetDefaultCompletionType("context") |
"      \     call SuperTabSetDefaultCompletionType("<c-x><c-]>") |
"      \     call SuperTabSetDefaultCompletionType("<c-x><c-k>") |
"      \ endif
