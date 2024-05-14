" ----------------------------------------------
" vim-lsp.vim
" ----------------------------------------------
function! ToggleLintMessage() abort
    let l:value = g:lsp_diagnostics_virtual_text_enabled
    if l:value == 0
        let l:value = 1
        setlocal signcolumn=yes
        let g:lsp_diagnostics_highlights_enabled = 0
    else
        let l:value = 0
        setlocal signcolumn=no
        let g:lsp_diagnostics_highlights_enabled = 1
    endif
    let g:lsp_diagnostics_virtual_text_enabled = l:value
    execute 'edit'
endfunction

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+1)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-1)


    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/dotfiles/.vim/lsp.log')

    " ------------------
    " delays
    let g:lsp_diagnostics_echo_delay = 5
    let g:lsp_diagnostics_float_delay = 5
    let g:lsp_diagnostics_highlights_delay = 5
    let g:lsp_diagnostics_signs_delay = 5
    let g:lsp_diagnostics_virtual_text_delay = 5

    " initial settings
    if g:lsp_diagnostics_highlights_enabled == 1
        setlocal signcolumn=no
        let g:lsp_diagnostics_highlights_enabled = 1
        let g:lsp_diagnostics_virtual_text_enabled = 0
    endif

    " show/hide virtual text
    nnoremap <buffer> <C-u> :call ToggleLintMessage()<CR>

    " General settings
    let g:lsp_diagnostics_enabled = 1         " disable diagnostics support
    " let g:lsp_diagnostics_echo_cursor = 1

    " sign column
    let g:lsp_diagnostics_signs_insert_mode_enabled = 0

    " Visual text
    let g:lsp_diagnostics_virtual_text_prefix = '[LSP] '

    " folding
    let g:lsp_fold_enabled = 0
    " set foldmethod=expr
    " \ foldexpr=lsp#ui#vim#folding#foldexpr()
    " \ foldtext=lsp#ui#vim#folding#foldtext()

    let g:lsp_hover_conceal = 0

    " highlight word under the cursor
    let g:lsp_document_highlight_enabled = 0
    highlight lspReference ctermfg=208 guifg=red ctermbg=black guibg=black

    " warning - virtual text
    highlight LspWarningHighlight ctermfg=yellow guifg=red ctermbg=black guibg=yellow
    highlight LspWarningText ctermfg=yellow guifg=red ctermbg=black guibg=yellow

    " error - vritual text
    highlight LspErrorHighlight ctermfg=213 guifg=red ctermbg=black guibg=cyan
    highlight LspErrorText ctermfg=213 guifg=red ctermbg=black guibg=cyan
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    " autocmd User lsp_buffer_enabled call ToggleLintMessage()
augroup END

