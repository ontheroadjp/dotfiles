"" Lint for PHP: when file is saved, 'php -i' runs.
"autocmd filetype php :set makeprg=php\ -l\ %
"autocmd filetype php :set errorformat=%m\ in\ %f\ on\ line\ %l
"autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif


"Sort PHP use statements
"https://gist.github.com/JeffreyWay/7265789dcdc6a2659822
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>
