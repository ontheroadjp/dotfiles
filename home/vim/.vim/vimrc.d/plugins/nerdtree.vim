"---------------------------------------------------------------------------
" NERDTree
"---------------------------------------------------------------------------
" Key-bindings: NERDTree open/close
"nnoremap <silent><C-e> :NERDTreeToggle<CR>
nnoremap ,e :NERDTreeToggle<CR>
"nmap <C-e> <Leader>e

" show Tree in default
"autocmd VimEnter * execute 'NERDTree'

" set a place of the Tree in left or right
"let g:NERDTreeWinPos="left"

" set tree width (default: 31)
"let g:NERDTreeWinSize=45

" show line number in NERDTree
let g:NERDTreeShowLineNumbers=1

" show bookmarks in default
let g:NERDTreeShowBookmarks=1

" set bookmark file name - default: $HOME/.NERDTreeBookmarks
"let g:NERDTreeBookmarksFile=

"set exclude files - default ['\~$']
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']

" show hidden files
let NERDTreeShowHidden = 1

" close Tree window automatically when file is opened
let g:NERDTreeQuitOnOpen=1

" close NERDTree when all buffers is closed.
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" change current directory when moving in NERDTree
"default (0) -  0:don't change, 1:can be changed, 2:auto change
let g:NERDTreeChDirMode=0

" change color of the file extension
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow','#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'green', 'none', '#ff00ff', '#151515')

" colorize - default: (1) enable
""let g:NERDChristmasTree=1

"カーソル位置の自動調節を行うか - 初期値(1):自動調節
""let g:NERDTreeAutoCenter=1

"カーソルの自動調節位置設定 - 初期値(3)
""let g:NERDTreeAutoCenterThreshold

" auto file sorting - default: (0) disable
"let g:NERDTreeCaseSensitiveSort=1

" heiglighting cursor line - default: (1) enable
"let g:NERDTreeHighlightCursorline=1

"セカンドツリーを表示を有効に ":edit <ディレクトリ名> " - 初期値(1):有効
"let g:NERDTreeHijackNetrw=1

"mouse - default: 1
"1: open file/directory by double-click
"2: open file by single-click and open directory by double-click
"3: open file/directory bo single-click
let g:NERDTreeMouseMode=3

" show file name in tree - default: (1) show
"let g:NERDTreeShowFiles=1

"ソートを行う時の、表示順番設定 (正規表現で設定) - 初期値 ['\/$', '*', '\.swp$',  '\.bak$', '\~$']
"let g:NERDTreeSortOrder=

" status format - default: %{b:NERDTreeRoot.path.strForOS(0)}
"let g:NERDTreeStatusline=

" show shortcut-key for bookmarks and help - default: (0) show
"let g:NERDTreeMinimalUI=0

"古い形式である|と+と~の記号だけでツリー表示 - 初期値(1):グラフィカルに表示する
"let g:NERDTreeDirArrows=0

