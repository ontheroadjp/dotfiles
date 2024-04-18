autocmd Filetype *    let g:AutoComplPop_CompleteOption='.,w,b,u,t,i'
" autocmd Filetype java let g:AutoComplPop_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/j2se14.dict'
" autocmd Filetype c    let g:AutoComplPop_CompleteOption='.,w,b,u,t,i,k~/.vim/dict/c.dict'

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

let g:acp_behaviorSnipmateLength = 1

"<TAB> completion
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        if pumvisible()
            return "\<C-N>"
        else
            return "\<C-N>\<C-P>"
            " return "\<TAB>"
        end
    endif
endfunction

" Remap the tab key to select action with InsertTabWrapper
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

nnoremap ,s :AutoComplPopDisable<CR>
nnoremap ,q :AutoComplPopEnable<CR>



