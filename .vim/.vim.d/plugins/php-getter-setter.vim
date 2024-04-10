"<LocalLeader>p   (or <Plug>PhpgetsetInsertGetterSetter)
"      Inserts a getter/setter for the property on the current line, or
"      the range of properties specified via a visual block.  User is
"      prompted for choice.
"
"  <LocalLeader>g   (or <Plug>PhpgetsetInsertGetterOnly)
"      Inserts a getter for the property on the current line, or the
"      range of properties specified via a visual block.  User is not
"      prompted.
"
"  <LocalLeader>s   (or <Plug>PhpgetsetInsertSetterOnly)
"      Inserts a getter for the property on the current line, or the
"      range of properties specified via a visual block.  User is not
"      prompted.
"
"  <LocalLeader>b   (or <Plug>PhpgetsetInsertBothGetterSetter)
"      Inserts both a getter and setter for the property on the current
"      line, or the range of properties specified via a visual block.
"      User is not prompted.

map <Leader>pp <Plug>PhpgetsetInsertGetterSetter
map <Leader>pg <Plug>PhpgetsetInsertGetterOnly
map <Leader>ps <Plug>PhpgetsetInsertSetterOnly
map <Leader>pb <Plug>PhpgetsetInsertBothGetterSetter

