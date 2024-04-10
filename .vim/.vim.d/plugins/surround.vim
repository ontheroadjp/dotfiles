autocmd FileType bash,sh let b:surround_{char2nr("v")} = "$(\r)"
autocmd FileType bash,sh let b:surround_{char2nr("V")} = "${\r}"
