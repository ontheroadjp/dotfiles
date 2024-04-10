"---------------------------------------------------------------------------
" settings for rking/ag(grep → ag)
"---------------------------------------------------------------------------

#" grep search
#nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
#
#" grep search in cursor
#nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
#
#" show result for grep search again
#nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>
#
#" useing ag(The Silver Searcher) in unite grep
#if executable('ag')
#	let g:unite_source_grep_command = 'ag'
#	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
#	let g:unite_source_grep_recursive_opt = ''
#endif


"---------------------------------------------------------------------------
" settings for taglist
"---------------------------------------------------------------------------

"a place of tags file
set tags=tags

"command path
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"

"show tags only editing file
"let Tlist_Show_One_File = 1

"if taglist is last window, close vim
"let Tlist_Exit_OnlyWiindow = 1

"If multi files exist, show list of the tags
"nnoremap <C-]> g<C-]>

" Key binding for tree open/close (rebindings by Karabiner)
nnoremap <silent><C-l> :TlistToggle<CR>

"To open in new window
"map <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

"To open in horizontal split window
"nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>

"To open in virtical split window
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>


#"---------------------------------------------------------------------------
#" settings for Vdebug
#" <F5>: start debugger / move to next brake point
#" <F2>: step-over
#" <F3>: step-in
#" <F4>: step-out
#" <F6>: stop debugger
#" <F7>: detouch debugger
#" <F9>: exec to cursor line
#" <F10>: set brake point
#" <F11>: show context variables (e.g. after "eval")
#" <F12>: evaluate variable value at cursor
#" :Breakpoint <type> <args>: can be set several types of the brake point (see :help VdebugBreakpoints)
#" :VdebugEval <code>: evaluate variable value in <code>
#" <Leader>e: evaluate the expression under visual highlight and display the " result
#"---------------------------------------------------------------------------
#
#let g:vdebug_keymap = {
#\    "run" : "<F5>",
#\    "run_to_cursor" : "<F1>",
#\    "step_over" : "<F2>",
#\    "step_into" : "<F3>",
#\    "step_out" : "<F4>",
#\    "close" : "<F6>",
#\    "detach" : "<F7>",
#\    "set_breakpoint" : "<F10>",
#\    "get_context" : "<F11>",
#\    "eval_under_cursor" : "<F12>",
#\}
#
#let g:vdebug_options= {
#\    "port" : 9000,
#\    "server" : 'localhost',
#\    "timeout" : 20,
#\    "on_close" : 'detach',
#\    "break_on_open" : 1,
#\    "ide_key" : '',
#\    "remote_path" : "",
#\    "local_path" : "",
#\    "debug_window_level" : 0,
#\    "debug_file_level" : 0,
#\    "debug_file" : "",
#\}
