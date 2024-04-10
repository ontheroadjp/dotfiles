" Bulk insertion at the beginning and end of a sentence with visual mode
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

" yank and commented out
augroup Copy
    autocmd!
    autocmd BufRead,BufNewFile *.vim nnoremap <silent> <buffer> <C-\> "zyyI" <esc>"zp
    autocmd BufRead,BufNewFile *.sh,*.py nnoremap <silent> <buffer> <C-\> "zyyI# <esc>"zp
augroup END

" $ to ${}
augroup BracketsExt
    autocmd!
    autocmd BufRead,BufNewFile *.sh,*.fnc inoremap <buffer> $ ${}<left>
augroup END

