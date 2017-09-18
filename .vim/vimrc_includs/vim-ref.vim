"---------------------------------------------------------------------------
" settings for thinca/vim-ref
"---------------------------------------------------------------------------
" using text browser (lynx）
"
" Usage:
" :man search-word (ex. :man ls)
" :phpm search-word (ex. :phpm echo)
" :eng search-word (ex. :dic happy)
"---------------------------------------------------------------------------
"a place of lynx.cfg (in case of the installing lynx by Homebrew)
"/usr/local/Cellar/lynx/2.8.7/etc/lynx.cfg

"a place of lynx.cfg (in case of the installing lynx by MacPorts)
"/opt/local/etc/lynx.cfg

"---------------------------------------------------------------------------
" settigs for man
"---------------------------------------------------------------------------
cnoremap dicman Ref man<Space>

"---------------------------------------------------------------------------
" settings for PHP Manual
"---------------------------------------------------------------------------
let g:ref_phpmanual_path = '/Users/hideaki/.vim/vim-ref/php-chunked-xhtml'
"cnoremap phpm Ref phpmanual<Space>
cnoremap dicphp Unite ref/phpmanual<CR>

"---------------------------------------------------------------------------
" settings for using alc in the webdict
"---------------------------------------------------------------------------
let g:ref_source_webdict_cmd = 'lynx -dump -nonumbers %s'
let g:ref_source_webdict_use_cache = 1
let g:ref_source_webdict_sites = {
\   'alc' : {
\       'url' : 'http://eow.alc.co.jp/%s/UTF-8/'
\   }
\}
function! g:ref_source_webdict_sites.alc.filter(output)
	return join(split(a:output, "\n")[29 :], "\n")
endfunction

cnoremap dicen Ref webdict alc<Space>
