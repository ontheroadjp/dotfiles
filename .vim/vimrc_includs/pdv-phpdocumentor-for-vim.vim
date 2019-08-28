"---------------------------------------------------------------------------
" settings for PDV-phpDocumentor for Vim
" http://www.phpdoc.org/
"---------------------------------------------------------------------------

"if ! empty(neobundle#get("PDV--phpDocumentor-for-Vim"))
    " " Default values
    " let g:pdv_cfg_Type = "mixed"
    " let g:pdv_cfg_Package = ""
    " let g:pdv_cfg_Version = "$id$"
    " let g:pdv_cfg_Author = "Tobias Schlitt <toby@php.net>"
    " let g:pdv_cfg_Copyright = "1997-2005 The PHP Group"
    " let g:pdv_cfg_License = "PHP Version 3.0 {@link http://www.php.net/license/3_0.txt}"
    
    " Default values
    let g:pdv_cfg_Type = "mixed"
    let g:pdv_cfg_Package = ""
    let g:pdv_cfg_Version = "$id$"
    let g:pdv_cfg_Author = "Misaki Taro <taro@ontheroad.jp>"
    let g:pdv_cfg_Copyright = "2016 ontheroad.jp"
    let g:pdv_cfg_License = ""
    let g:pdv_cfg_ReturnVal = "void"
    nnoremap <Leader>d :call PhpDocSingle()<CR>
"endif
