set nocompatible
" ================================================
" Gemini + GitHub CLI Integration for Vim
" ================================================
" Features:
" 1. Visual selection translation to English using Gemini CLI
" 2. YAML frontmatter parsing for title, label, assignee, milestone
" 3. Buffer auto-send to GitHub Issue via gh CLI
" 4. Ignores Gemini/Node warnings and stderr logs
" ================================================

" ---- YAML frontmatter parsing (fixed version) ----
function! ParseYAMLFrontmatter()
  " Find YAML frontmatter boundaries (--- ... ---)
  let l:start = search('^---$', 'n')
  if l:start == 0
    return ['', '', '', '']
  endif
  let l:end = search('^---$', 'n', l:start + 1)
  if l:end == 0
    return ['', '', '', '']
  endif

  " Read lines within YAML block
  let l:lines = getline(l:start + 1, l:end - 1)
  let l:title = ''
  let l:label = ''
  let l:assignee = ''
  let l:milestone = ''

  " Parse each line individually
  for l:line in l:lines
    if l:line =~? '^title:\s*'
      let l:title = substitute(l:line, '^title:\s*', '', '')
    elseif l:line =~? '^label:\s*'
      let l:label = substitute(l:line, '^label:\s*', '', '')
    elseif l:line =~? '^assignee:\s*'
      let l:assignee = substitute(l:line, '^assignee:\s*', '', '')
    elseif l:line =~? '^milestone:\s*'
      let l:milestone = substitute(l:line, '^milestone:\s*', '', '')
    endif
  endfor

  return [l:title, l:label, l:assignee, l:milestone]
endfunction

" =========================================
" GitHub label definitions (Vimscript)
" =========================================
let g:gh_labels = [
      \ {'name': 'consideration',        'color': '0e8a16', 'description': 'Before tasks'},
      \ {'name': 'todo',        'color': '0e8a16', 'description': 'Tasks to do'},
      \ {'name': 'bug',         'color': 'd73a4a', 'description': 'Bug reports'},
      \ {'name': 'enhancement','color': 'a2eeef', 'description': 'New feature requests'},
      \ {'name': 'spec',         'color': '#5f4b34', 'description': 'Bug reports'},
      \ {'name': 'docs',        'color': '0e8a16', 'description': 'Documentation updates'},
      \ {'name': 'test',        'color': '5319e7', 'description': 'Testing related'}
      \ ]

" =========================================
" Ensure label exists on GitHub
" =========================================
function! EnsureLabelExists(label)
  if a:label == ''
    return
  endif

  " Get existing labels from GitHub
  let l:existing = systemlist('gh label list --json name | jq -r ".[].name"')
  if index(l:existing, a:label) != -1
    return
  endif

  " Search in Vimscript label definitions
  let l:found = 0
  for l:item in g:gh_labels
    if l:item.name ==# a:label
      let l:cmd = 'gh label create ' . shellescape(l:item.name) . \
                  \ ' --color ' . shellescape(l:item.color) . \
                  \ ' --description ' . shellescape(l:item.description)
      call system(l:cmd)
      let l:found = 1
      break
    endif
  endfor

  if !l:found
    echoerr "❌ Label '" . a:label . "' is not defined in the script"
    throw "Label not defined"
  endif
endfunction

" ===========================================================================
" Function: SendBufferToGH
" ===========================================================================
" Description:
"   Creates a GitHub Issue from the current Vim buffer by parsing YAML front
"   matter and sending the content to GitHub using the GitHub CLI (gh).
"
" Supported Features:
"   - YAML Front Matter Parsing:
"       * title       : Issue title (required)
"       * label       : Issue label(s) (optional)
"       * assignee    : GitHub username(s) to assign (optional)
"       * milestone   : GitHub milestone name (optional; if empty, skipped)
"
"   - Markdown Body:
"       * The content after the YAML front matter is used as the issue body.
"
"   - Execution:
"       * Can be triggered manually via :call SendBufferToGH()
"       * Can be triggered automatically on saving *.todo / *.bug files
"         with confirmation prompt.
"       * Manual shortcut mapping: <leader>ghi
"
" Behavior:
"   1. Parse YAML front matter from the top of the buffer.
"   2. Extract title, label, assignee, and milestone fields.
"   3. Extract the body content after YAML for Markdown.
"   4. Build and execute the `gh issue create` command.
"   5. Capture gh CLI output and display success/failure messages.
"   6. On success:
"       - Display the GitHub issue URL.
"       - Automatically delete the local buffer file and close the buffer.
"   7. On failure:
"       - Display error message and gh CLI output for debugging.
"
" Requirements:
"   - GitHub CLI (gh) must be installed and authenticated.
"   - Buffer must contain valid YAML front matter with at least a title.
"
" Notes:
"   - Milestone is optional; if the field is empty or does not exist in the
"     repository, it will be skipped silently.
"   - Labels and assignees are optional; multiple values can be specified
"     comma-separated if needed.
"   - The function uses a temporary file in /tmp to send the Markdown body
"     to the GitHub CLI.
"   - Designed for use with Vim or Neovim.
"
" Example YAML front matter for a todo issue:
"   ---
"   title: Organize dotfiles
"   label: todo
"   assignee: @me
"   milestone: v1.0 Release
"   ---
"
"   ## Description
"   Categorize and move scattered files and directories into .config/.
"
"   ## Objectives / Points
"   - Files directly under ~/ will not be moved
"   - A script to create symlinks is required
"
" ===========================================================================
function! SendBufferToGH()
  let l:lines = getline(1, '$')

  " YAML front matter
  let l:start = index(l:lines, '---')
  if l:start == -1
    echoerr "YAML front matter not found"
    return
  endif
  let l:end = index(l:lines[l:start+1:], '---')
  if l:end == -1
    echoerr "YAML front matter end not found"
    return
  endif
  let l:end = l:start + l:end + 1

  " Parse YAML fields
  let l:title = ''
  let l:label = ''
  let l:assignee = ''
  let l:milestone = ''

  for l:line in l:lines[l:start+1 : l:end-1]
    if l:line =~ '^title:'
      let l:title = trim(substitute(l:line, '^title:\s*', '', ''))
    elseif l:line =~ '^label:'
      let l:label = trim(substitute(l:line, '^label:\s*', '', ''))
    elseif l:line =~ '^assignee:'
      let l:assignee = trim(substitute(l:line, '^assignee:\s*', '', ''))
    elseif l:line =~ '^milestone:'
      let l:milestone = trim(substitute(l:line, '^milestone:\s*', '', ''))
    endif
  endfor

  " Ensure label exists or create it
  call EnsureLabelExists(l:label)

  " Body
  let l:body_lines = l:lines[l:end+1 :]
  let l:tmpfile = tempname() . '.md'
  call writefile(l:body_lines, l:tmpfile)

  " Build gh command
  let l:cmd = 'gh issue create'
  if l:title !=# ''       | let l:cmd .= ' --title ' . shellescape(l:title)       | endif
  if l:label !=# ''       | let l:cmd .= ' --label ' . shellescape(l:label)       | endif
  if l:assignee !=# ''    | let l:cmd .= ' --assignee ' . shellescape(l:assignee) | endif
  if l:milestone !=# ''   | let l:cmd .= ' --milestone ' . shellescape(l:milestone) | endif
  let l:cmd .= ' --body-file ' . shellescape(l:tmpfile)

  " Execute
  let l:output = system(l:cmd)

  if v:shell_error == 0
    echo "✅ Issue created successfully!"
    let l:url = matchstr(l:output, 'https://github\.com/\S\+')
    if l:url != ''
      echo "🌐 " . l:url
    endif

    " Delete buffer
    call delete(expand('%'))
    bdelete!
    echo "🗑️  Local file deleted after successful issue creation."

    " Delete temp file
    call delete(l:tmpfile)
    return 1
  else
    echoerr "❌ Failed to create issue."
    echom l:output
    return 0
  endif
endfunction

" =========================================
" Shortcut: \ghi to send buffer immediately
" =========================================
nnoremap <leader>ghi :call SendBufferToGH()<CR>

" =========================================
" Optional: Confirm on :w for *.todo, *.bug
" =========================================
augroup gh_issue_confirm
  autocmd!
  autocmd BufWritePre *.consideration,*.todo,*.bug,*.enhancement,*.spec,*.docs,*.test call ConfirmCreateGHIssue()
augroup END

function! ConfirmCreateGHIssue()
  let l:choice = input("💡 Create GitHub Issue? (y/N): ")
  if tolower(l:choice) ==# 'y'
    let l:success = SendBufferToGH()
    if l:success
      execute "bwipeout!"
    endif
  endif
endfunction


" ===========================================================================
" Function: ListAndOpenGitHubIssues
" ===========================================================================
" Description:
"   - Fetches open issues from the current GitHub repository using gh CLI.
"   - Displays the list in a Vim buffer as a neatly aligned table with headers:
"       Number | Title | Assignees | Labels | CreatedAt
"   - Ensures correct handling even if TSV rows have missing columns.
"   - Enter opens the selected issue in a browser and returns to the original buffer.
" ===========================================================================
let g:gh_issues_prev_buf = 0  " Store previous buffer globally

function! ListAndOpenGitHubIssues()
  " Save current buffer number
  let g:gh_issues_prev_buf = bufnr('%')

  " Temporary file
  let l:tmpfile = tempname()

  " Fetch issues as TSV
  let l:cmd = "gh issue list --state open --limit 100 --json number,title,assignees,labels,createdAt --jq '.[] | [(.number|tostring), .title, (.assignees|map(.login)|join(", ")), (.labels|map(.name)|join(", ")), .createdAt] | @tsv' > " . shellescape(l:tmpfile)
  call system(l:cmd)

  " Read TSV lines
  let l:lines = readfile(l:tmpfile)
  call delete(l:tmpfile)  " Cleanup temporary file

  if empty(l:lines)
    echo "No open issues found."
    return
  endif

  " Split TSV into array of arrays, ensure 5 columns
  let l:rows = []
  for line in l:lines
    if line != ''
      let l:cols = split(line, "\t")
      while len(l:cols) < 5
        call add(l:cols, '')
      endwhile
      call add(l:rows, l:cols)
    endif
  endfor

  " Determine max width for each column safely
  let l:widths = []
  for i in range(5)
    let l:maxlen = 0
    for row in l:rows
      if i < len(row)
        let l:maxlen = max([l:maxlen, strlen(row[i])])
      endif
    endfor
    call add(l:widths, l:maxlen)
  endfor

  " Build formatted lines with header
  let l:formatted = []
  let l:headers = ['Number','Title','Assignees','Labels','CreatedAt']
  let l:line = ''
  for idx in range(5)
    let l:line .= printf('%-*s', l:widths[idx]+2, l:headers[idx])
  endfor
  call add(l:formatted, l:line)

  " Add separator
  let l:sep = ''
  for idx in range(5)
    let l:sep .= repeat('-', l:widths[idx]+2)
  endfor
  call add(l:formatted, l:sep)

  " Add issue rows
  for row in l:rows
    let l:line = ''
    for idx in range(5)
      let l:line .= printf('%-*s', l:widths[idx]+2, row[idx])
    endfor
    call add(l:formatted, l:line)
  endfor

  " Open new buffer and display
  enew
  %delete _
  call setline(1, l:formatted)
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal nobuflisted
  setlocal readonly
  setlocal nonumber
  setlocal norelativenumber

  " Map Enter to open issue in browser
  nnoremap <buffer> <CR> :call OpenSelectedIssue()<CR>
endfunction

" ===========================================================================
" Function: OpenSelectedIssue
" ===========================================================================
" Description:
"   Opens the GitHub issue corresponding to the current line in a browser
"   and returns to the original buffer.
" ===========================================================================
function! OpenSelectedIssue()
  let l:line = getline('.')
  let l:num = matchstr(l:line, '^\d\+')
  if l:num == ''
    echo "No issue number found on this line."
    return
  endif

  " Open issue in web browser
  call system('gh issue view ' . l:num . ' --web')
  echo "Opening issue #" . l:num

  " Return to previous buffer
  if g:gh_issues_prev_buf > 0 && buflisted(g:gh_issues_prev_buf)
    execute 'buffer' g:gh_issues_prev_buf
  endif
endfunction

" ===========================================================================
" Shortcut: \ghl
" ===========================================================================
nnoremap <silent> <leader>ghl :call ListAndOpenGitHubIssues()<CR>


" ----------------------------------------------------



"map <F5> :wall!<CR>:!glow ~/memo<CR><CR>
noremap <C-s> :w<CR>

command Dic !dict <cword>

 " ================================================== Disable default plugins
 " Disable TOhtml.
"let g:loaded_2html_plugin       = 1
"
"  " Disable archive file open and brawse.
"let g:loaded_gzip               = 1
"let g:loaded_tar                = 1
"let g:loaded_tarPlugin          = 1
"let g:loaded_zip                = 1
"let g:loaded_zipPlugin          = 1
"
"  " Disable vimball.
"let g:loaded_vimball            = 1
"let g:loaded_vimballPlugin      = 1
"
"  " Disable netrw plugins.
"let g:loaded_netrw              = 1
"let g:loaded_netrwPlugin        = 1
"let g:loaded_netrwSettings      = 1
"let g:loaded_netrwFileHandlers  = 1
"
"  " Disable `GetLatestVimScript`.
"let g:loaded_getscript          = 1
"let g:loaded_getscriptPlugin    = 1
"
"  " Disable other plugins
"let g:loaded_man                = 1
"let g:loaded_matchit            = 1
" "let g:loaded_matchparen         = 1
" let g:loaded_shada_plugin       = 1
"let g:loaded_spellfile_plugin   = 1
"let g:loaded_tutor_mode_plugin  = 1
"let g:did_install_default_menus = 1
"let g:did_install_syntax_menu   = 1
"let g:skip_loading_mswin        = 1
"let g:did_indent_on             = 1
"let g:did_load_ftplugin         = 1
"let g:loaded_rrhelper           = 1

augroup vim_start_end
    autocmd!
    " remove trailing whitespace when saved
    autocmd BufWritePre * :%s/\s\+$//ge
augroup END

" viminf
set viminfo='100,<50,s10,h,!,%
set viminfofile=~/.vim/viminfo


"================================================================ Quickfix
" open:copen, close:ccl
au QuickfixCmdPost *grep* cwindow      " open vimgrep result in quickfix
au QuickfixCmdPost make,grep,grepadd,vimgrep copen  " open quickfix window for :grep
nnoremap <C-up> :copen<CR>                  " open quickfix window
nnoremap <C-y> :ccl<CR>                     " close quickfix window
" nnoremap <up> :cprevious<CR>                " move to previous item
" nnoremap <down> :cnext<CR>                  " move to next item
" nnoremap [Q :<C-u>cfirst<CR>               " move to first item
" nnoremap ]Q :<C-u>clast<CR>                " move to last item

" use ripgrep if installed
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

"================================================================ visuals
" Color schema
so ${HOME}/dotfiles/.vim/vimrc.d/ui/color-schema.vim

" Status bar
" 0: none
" 1: show when more than two windows
" 2:always show the status-line
set laststatus=2
so ${HOME}/dotfiles/.vim/vimrc.d/ui/vim-status-line.vim

" if has('termguicolors')
"   set termguicolors
" endif

"================================================================ General settings
set encoding=utf-8                              " set charactor code
" set encoding=utf-8 nobomb                        " set charactor code
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fileformats=unix,dos,mac
set nowrap                                       " automatic wordwrap
set backspace=indent,eol,start                   " it can delete newline character be BackSpace key

"set cursorline                                   " show cursor line
set linespace=4

" Clipboard
set clipboard+=unnamed

"--------------------------------------------------------------- Line number
set number                                  " show line number
" set relativenumber                        " show relative line number
nnoremap <leader>nn :set invnumber<CR>          " toggle show/hide line number
nnoremap <leader>mm :setl rnu!<CR>              " toggle normal/relativenumber

"--------------------------------------------------------------- Tab(Indent)
set expandtab                  " replace tab to space
set tabstop=4                  " indent width
set shiftwidth=4               " auto indent width
set softtabstop=4              " moving width of the consecutive white space
set autoindent                 " to continue indent width in new line
set smartindent                " to determining indent width automatically in new line
" let g:sh_indent_case_labels=1

"--------------------------------------------------------- Backup/Swap file
set nobackup                                     " disable backup file
set noswapfile                                   " disable swap file

"--------------------------------------------------------------- Command
" Save as root user
cabbr w!! w !sudo tee > /dev/null %

" %% to expand current directory in command mode
nmap %e :e %%
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h/').'/' : '%%'
cno<expr> %$ getcmdtype() == ':' ? expand('%:p/') : '%$'

"=============================================================== Mode change
" JJ, jk, kj  as <esc>
inoremap <silent> jk <esc>
inoremap <silent> kj <esc>

" visual mode to normal mode
vnoremap n <C-c>

" change insert-normal mode
inoremap <C-n> <C-o>

"------------------------------------------------------------- Window
nnoremap -- :split<CR>                  " horizontal split
nnoremap \\ :rightbelow vsp<CR>         " virtical split
set winheight=25
map ✩ <C-S-k-from-iterm2>
map ✡ <C-S-j-from-iterm2>
nnoremap <C-S-k-from-iterm2> <C-w>k
noremap <C-S-j-from-iterm2> <C-w>j

nnoremap <C-w><C-w> <C-w>o

"nnoremap \2 :close<CR>                 " close window
"nnoremap \h <C-w>h                     " move to left window
"nnoremap \j <C-w>j                     " move to bottom window
"nnoremap \k <C-w>k                     " move to above window
"nnoremap \l <C-w>l                     " move to right window
"nnoremap \q <c-w><c-w>                 " move between window
"nnoremap TT <C-w>T

"----------------------------------------------------------------- Tab
"nnoremap <silent> tn :tabnew<CR>        " open new tab
"nnoremap <silent> <Tab> :tabn<CR>       " change to next tab
"nnoremap <silent> <S-Tab> :tabp<CR>     " change to previous tab
"nnoremap <silent> t] :tabmove +<CR>     " move tab to right
"nnoremap <silent> t[ :tabmove -<CR>     " move tab to left

"--------------------------------------------------------------- Buffer
" nnoremap <silent> yt :buffers<CR>
" nnoremap <silent> yb :bprevious<CR>
" nnoremap <silent> ]b :bnext<CR>
" nnoremap <silent> [B :bfirst<CR>
" nnoremap <silent> ]B :blast<CR>

"--------------------------------------------------------------- Scrolling
nnoremap <C-n> <C-d> "Scroll down half a page
nnoremap <C-u> <C-u> "scroll up half page

"--------------------------------------------------------------- Moving cursor
nnoremap k gk
nnoremap j gj
vnoremap k gk
vnoremap j gj
nnoremap gk k
nnoremap gj j
vnoremap gk k
vnoremap gj j

" move cursor in insert mode

" inoremap <C-k> <Up>
" inoremap <C-j> <Down>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>

inoremap <expr> <C-k> pumvisible() ? "<C-p>" : "<Up>"
inoremap <expr> <C-j> pumvisible() ? "<C-n>" : "<Down>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>

"--------------------------------------------------------------- Scroll

nnoremap <C-k> Hzz
nnoremap <C-j> Lzz

nnoremap <C-k> 5kzz
nnoremap <C-j> 5jzz

"--------------------------------------------------------------- Jump to
" motion prefix ` to <space>
nnoremap <Space> `
nnoremap <Space>o <C-o>zz                   " Jump list (reverse)
nnoremap <Space>i <C-i>zz                   " Jump list (forword)

" Jump to begining of the line
nnoremap <C-h> ^
vnoremap <C-h> ^o

" Jump to end of the line
nnoremap <C-l> $
vnoremap <C-l> $<left>

" Jump to paragraph (reverse)
nnoremap { {<down>
noremap } }<up>$
vnoremap { {<down>o
vnoremap } }<up>$

"--------------------------------------------------------------- Search
set hlsearch                    " highlight search word
set smartcase                   " if capital note in search words, it doesn't regardress capital note or small note (nosmartcase)
set incsearch                   " to enable incremental search
" nnoremap n nzz                 " move center of display when search (n)
" nnoremap N Nzz                 " move center of display when search (N)

" highlight a word under the cursor
" nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nnoremap <silent> <Space><Space> *N

set shortmess-=S
" nnoremap <expr> c/ _(":%s/<Cursor>//gn")
" function! s:move_cursor_pos_mapping(str, ...)
"     let left = get(a:, 1, "<Left>")
"     let lefts = join(map(split(matchstr(a:str, '.*<Cursor>\zs.*\ze'), '.\zs'), 'left'), "")
"     return substitute(a:str, '<Cursor>', '', '') . lefts
" endfunction
"
" function! _(str)
"     return s:move_cursor_pos_mapping(a:str, "\<Left>")
" endfunction



"-------------------------------------------------------------- Folding
set foldmethod=indent       "Folding range
"set foldlevel=0            "Default level of folding when a file is opened
" set foldcolumn=1            "Add an area to the left edge to show the folded state
set fillchars=fold:.
" set fillchars=foldopen:@
" set fillchars=foldsep:.
function! MyFoldText()
    return printf('+-- %d lines: %s', v:foldend-v:foldstart+1, getline(v:foldstart))
endfunction

set foldtext=%{MyFoldText()}



"" Region of cursor
"" zO  -- Open all folds under the cursor recursively
"nnoremap <C-h> zc " close
"nnoremap <C-l> zO " open

"" Whole file
"" zm -- Fold more
"" zr -- Reduce folding
"nnoremap <C-> zM	    " close all folds
"nnoremap <C-k> zR	    " open all folds
nnoremap <C-i> zA	    " Toggle flds

"----------------------------------------------------------- yank & put
nnoremap p gp
nnoremap P gP
nnoremap gp p
nnoremap gP P

" " past in normalmode
" if &term =~ "xterm"
"     let &t_ti .= "\e[?2004h"
"     let &t_te .= "\e[?2004l"
"     let &pastetoggle = "\e[201~"
"     if !exists('*XTermPasteBegin')
"         function XTermPasteBegin(ret)
"             set paste
"             return a:ret
"         endfunction
"     endif
"     noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
"     inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
"     cnoremap <special> <Esc>[200~ <nop>
"     cnoremap <special> <Esc>[201~ <nop>
" endif

"------------------------------------------------------------------- Plugins
" so ${HOME}/dotfiles/.vim/vimrc.d/neobundle-management.vim	    "  NeoBundle
so ${HOME}/dotfiles/.vim/vimrc.d/vim-plug-management.vim	    " vim-plug
runtime! vimrc.d/editing.vim

"------------------------------------------- By filetype (note ":help" in vim)
autocmd BufNewFile,BufRead *.{html,htm,ejs*,js,vue} set filetype=html.javascript.vue
autocmd BufNewFile,BufRead *.{sh,profile,fnc,bats} set filetype=bash
autocmd BufNewFile,BufRead *.{zshrc,zprofile,zshenv,conf} set filetype=zsh
autocmd BufNewFile,BufRead *.{consideration,todo,bug,enhancement,spec,docs,test} set filetype=markdown

augroup shell
    autocmd!
    autocmd BufNewFile *.{sh,bash,fnc} 0r $HOME/dotfiles/.vim/templates/sh.tpl
    autocmd BufNewFile *.{bats} 0r $HOME/dotfiles/.vim/templates/bats.tpl
augroup END
augroup markdown
    autocmd!
    autocmd BufNewFile *.{consideration} 0r $HOME/dotfiles/.vim/templates/github/issue_consideration.tpl
    autocmd BufNewFile *.{todo} 0r $HOME/dotfiles/.vim/templates/github/issue_todo.tpl
    autocmd BufNewFile *.{enhancement} 0r $HOME/dotfiles/.vim/templates/github/issue_enhancement.tpl
    autocmd BufNewFile *.{spec} 0r $HOME/dotfiles/.vim/templates/github/issue_spec.tpl
    autocmd BufNewFile *.{bug} 0r $HOME/dotfiles/.vim/templates/github/issue_bug.tpl
    autocmd BufNewFile *.{docs} 0r $HOME/dotfiles/.vim/templates/github/issue_docs.tpl
    autocmd BufNewFile *.{test} 0r $HOME/dotfiles/.vim/templates/github/issue_test.tpl
augroup END
augroup PHP
    autocmd!
    au BufNewFile,BufRead *.php set ft=php.html.bootstrap.laravel.cdn.javascript.vue
    au BufRead,BufNewFile *.php let php_sql_query = 1            " PHP settings
    au BufRead,BufNewFile *.php let php_baselib = 1              " PHP settings
    au BufRead,BufNewFile *.php let php_htmlInStrings = 1        " PHP settings
    au BufRead,BufNewFile *.php let php_noShortTags = 1          " PHP settings
    au BufRead,BufNewFile *.php let php_parent_error_close = 1   " PHP settings
    au BufRead,BufNewFile *.php let g:sql_type_default='mysql'   " DB settings
    " dictionary
    au FileType php,ctp :set dictionary=~/.source ~/vim/dict/php.dict
    au FileType php,ctp :set dictionary=~/vim/dict/php.dict
    au FileType php,ctp :set complete+=k/~/vim/dict/php.dict
augroup END
augroup Javascript
    autocmd!
    autocmd BufNewFile *.vue 0r $HOME/dotfiles/.vim/templates/vue.tpl
    " load ESLint
    au Filetype javascript cnoremap eslint !clear && node_modules/eslint/bin/eslint.js %<CR>
    au BufNewFile,BufRead *.vue tabstop=0 softtabstop=0 shiftwidth=0
augroup END
augroup Python
    autocmd!
    autocmd BufNewFile *.{py} 0r $HOME/dotfiles/.vim/templates/python.tpl
    " linter
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>li :call Run('ruff check')<CR>
    " test
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>te :call Run('pytest')<CR>
    " formatter
    autocmd BufNewFile,BufRead *.{py}
        \ noremap <leader>fo :call Run('isort --profile black','black')<CR>

    function! ExecShellCmd(command)
        let temp_file = tempname()
        execute 'silent! :!'.a:command.' > '.temp_file
        let output = join(readfile(temp_file), "\n")
        call delete(temp_file)
        return output
    endfunction

    function! Run(...) abort
        let result = ExecShellCmd('git status --short | wc -l')
        if trim(result) == 0
            let l:file = expand('%:p/')
            for n in a:000
                call setqflist([], ' ', {'lines' : systemlist(n.' '.l:file)})
            endfor
            copen
            normal! <CR>
            redraw!
        else
            redraw!
            echo '[abort] need git commit first'
        endif
    endfunction
augroup END

filetype on
