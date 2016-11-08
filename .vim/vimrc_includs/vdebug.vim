"---------------------------------------------------------------------------
" settings for Vdebug
" <F5>: start debugger / move to next brake point
" <F2>: step-over
" <F3>: step-in
" <F4>: step-out
" <F6>: stop debugger
" <F7>: detouch debugger
" <F9>: exec to cursor line
" <F10>: set brake point
" <F11>: show context variables (e.g. after "eval")
" <F12>: evaluate variable value at cursor
" :Breakpoint <type> <args>: can be set several types of the brake point (see :help VdebugBreakpoints)
" :VdebugEval <code>: evaluate variable value in <code>
" <Leader>e: evaluate the expression under visual highlight and display the " result
"---------------------------------------------------------------------------

let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F1>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "<F6>",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<F10>",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<F12>",
\}

let g:vdebug_options= {
\    "port" : 9000,
\    "server" : 'localhost',
\    "timeout" : 20,
\    "on_close" : 'detach',
\    "break_on_open" : 1,
\    "ide_key" : '',
\    "remote_path" : "",
\    "local_path" : "",
\    "debug_window_level" : 0,
\    "debug_file_level" : 0,
\    "debug_file" : "",
\}
