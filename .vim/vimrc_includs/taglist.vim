"---------------------------------------------------------------------------
" settings for taglist
"---------------------------------------------------------------------------

"a place of tags file
set tags=tags

"command path
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"

"show tags only editing file
"let Tlist_Show_One_File = 1 

"if taglist is last window, close vim
"let Tlist_Exit_OnlyWiindow = 1 

"If multi files exist, show list of the tags
"nnoremap <C-]> g<C-]>

" Key binding for tree open/close (rebindings by Karabiner) 
nnoremap <silent><C-l> :TlistToggle<CR>

"To open in new window
"map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"To open in horizontal split window
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

"To open in virtical split window
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
