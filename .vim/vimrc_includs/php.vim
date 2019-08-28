"" Lint for PHP: when file is saved, 'php -i' runs.
"autocmd filetype php :set makeprg=php\ -l\ %
"autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l
"autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif

" Auto-remove trailing spaces
autocmd BufWritePre *.php :%s/\s\+$//e

"Sort PHP use statements (https://gist.github.com/JeffreyWay/7265789dcdc6a2659822)
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>


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
