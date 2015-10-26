
"カラースキーマー
colorscheme desert

" フォント指定
"set guifont=Ricty\ Regular:h18
set guifont=Ricty\ Diminished\ Regular:h18

" 初期表示行列
set lines=120 columns=80

" GUIの非表示
set guioptions-=T

" 透過設定
autocmd GUIEnter * set transparency=1      " 起動時
autocmd FocusGained * set transparency=8   " アクティブ時
autocmd FocusLost * set transparency=5     " 非アクティブ時
