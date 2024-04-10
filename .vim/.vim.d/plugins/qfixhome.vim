"---------------------------------------------------------------------------
" QFixHowm
" note: https://sites.google.com/site/fudist/Home/qfixhowm/quick-start)
"---------------------------------------------------------------------------
"Usage:
"g,c        : create new memo
"g,<Space>  : create new memo (in the same file)
"g,j        : create new memo (related in opning buffer)
"g,m        : show memo list
"g,g        : search memo
"g,u        : quick memo
"<C-w>,     : open/close Quickfix window
"---------------------------------------------------------------------------

" key-bindings for QFixHowm
let QFixHowm_Key = 'g'

" a place of the save files
let howm_dir = '~/Dropbox/memo'

" save file name
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'

" file encording
let howm_fileencoding = 'utf-8'

" line feed code
let howm_fileformat = 'unix'

" mark of a title
let QFixHowm_Title = '#'

" initializig dictionary for a regular expression of the title line
let QFixMRU_Title = {}

" regular expression for regarding title line in MRU 
" (designation by a regular expression of the Vim)
let QFixMRU_Title['mkd'] = '^###[^#]'

" regular expression for regarding title line in grep 
" (!: needing to change depends on type of grep)
let QFixMRU_Title['mkd_regxp'] = '^###[^#]'

let QFixHowm_DiaryFile = 'diary/%Y/%m/%Y-%m-%d-000000.howm'
