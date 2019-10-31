
""カラースキーマー
colorscheme desert
""colorscheme Tomorrow-Night-Eighties
colorscheme lucius
"
" フォント指定
set antialias
set guifont=Ricty\ Diminished\ Regular:h16

" 行高の設定
set linespace=10
"
"" 初期表示行列
"set lines=35
"set columns=100
"
"" GUIの非表示
""set guioptions-=T
"
"" 透過設定
"autocmd GUIEnter * set transparency=8      " 起動時
"autocmd FocusGained * set transparency=8   " アクティブ時
"autocmd FocusLost * set transparency=5     " 非アクティブ時

" Full screen mode on start up
if has("gui_running")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif

