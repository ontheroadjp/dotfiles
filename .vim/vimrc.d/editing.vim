" ---------------------------------------------------------
" remove trailing whitespace when saved
" ---------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//ge

" ---------------------------------------------------------
" Bulk insertion at the beginning and end of a sentence with visual mode
" ---------------------------------------------------------
vnoremap <expr> I  <SID>force_blockwise_visual('I')
vnoremap <expr> A  <SID>force_blockwise_visual('A')
" Enable 'I' and 'A' in visual line mode
function! s:force_blockwise_visual(next_key)
    if mode() ==# 'v'
        return "\<C-v>" . a:next_key
    elseif mode() ==# 'V'
        return "\<C-v>0o$" . a:next_key
    else  " mode() ==# "\<C-v>"
        return a:next_key
    endif
endfunction

"--------------------------------------------------------------- Editing
" insert brank line to under cursor
nnoremap 00 :<C-u>call append(expand('.'), '')<CR>j

" insert two brank line and to be inline mode
nnoremap 0i :<C-u>call append(expand('.'), '')<CR>o

" These are setted in iTerm2 preferences at profile->keys
" They are important for pressing Ctrl + Shift key-bindings
" vim couldn't catch Ctrl + Shift same time
" So, iTerms send specific charactor when press Ctrl + Shift
map ✠ <C-CR>
imap ✠ <C-CR>
map ✢ <C-S-CR>
imap ✢ <C-S-CR>

" add a blank line under the cursor line
nnoremap <C-CR> mzo<ESC>`z
inoremap <C-CR> <End><CR>

" add a blank line above the cursor line
nnoremap <C-S-CR> mzO<ESC>`z
inoremap <C-S-CR> <Home><CR><Up>

" Move Single line under the cursor
" nnoremap <C-S-Up> "zdd<Up>"zP
" noremap <C-S-Down> "zdd"zp
"
" Move Multi lines under the cursor
" vnoremap <C-S-Up> "zx<Up>"zP`[V`]
" vnoremap <C-S-Down> "zx"zp`[V`]

