# Cheet sheet

## vim
### in visual mode
o           : change begining and ending visual selection

### in insert mode
<C-n>       : change insert-normal mode


### Editing
r           : edit a char at cursor position (vim default)
R           : edit chars at cursor position (vim default)

### Scroll & Cursor Move
<C-k>       : move cursor to top and scroll center of the window
<C-j>       : move cursor to bottom and scroll center of the window

### Curssor Move
w           : move to first char in next word (vim default)
b           : move to first char in current word (vim default)
e           : move to last char in current word (vim default)
ge          : move to last char in previous word (vim default)
H           : move to top of the window (vim default)
M           : move to middle of the window (vim default)
L           : move to bottom of the window (vim default)

### Scroll
zz          : scroll cursor line to center of the window (vim default)
zt          : scroll cursor line to top of the window (vim default)
zb          : scroll cursor line to bottom of the window (vim default)

### Window
--          : split window horizontally
\\          : split window vertically
<C-w><C-w>  : move cursor rotation (vim default)
<C-w>h      : move cursor to left window (vim default)
<C-w>k      : move cursor to above window (vim default)
<C-w>l      : move cursor to right window (vim default)
<C-w>j      : move cursor to below window (vim default)

### Folding
<C-i>       : toggle open and close of folding

### Edit
gv          : reselect (vim default)
00          : make a brank line under the cursor
0i          : make a brank line under the cursor and enter insert mode
<shift>>>   : right indent (vim default)
<shift><<   : left indent (vim default)

### Buffer info
,cd         : change current dir
,dd         : show current dir
,ft         : show filetype

### Unite
,fr         : open a list of recent used files
,ff         : open a list of files/dirs in current dir

### NERDTree
,e          : open NERDTree
