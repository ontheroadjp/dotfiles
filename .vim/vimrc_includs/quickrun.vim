"---------------------------------------------------------------------------
" settings for QuickRun (for Markdown)
" note: http://qiita.com/us10096698/items/1ac05c5c9543d2f79fa3
" enabling syntax-highlight in .md file
" 
" Usage:
" exec command: <leader>r 
"---------------------------------------------------------------------------
let g:quickrun_config = {}
let g:quickrun_config['markdown'] = {
\    'outputter': 'browser'
\}
