" カーソルの次の文字列を取得（引数は取得したい文字数）
function! GetNextString(length) abort
	let l:str = ""
	for i in range(0, a:length-1)
		let l:str = l:str.getline(".")[col(".")-1+i]
	endfor
	return l:str
endfunction

" カーソルの前の文字列を取得（引数は取得したい文字数）
function! GetPrevString(length) abort
	let l:str = ""
	for i in range(0, a:length-1)
		let l:str = getline(".")[col(".")-2-i].l:str
	endfor
	return l:str
endfunction

" アルファベットかどうか?
function! IsAlphabet(char) abort
	let l:charIsAlphabet = (a:char =~ "\a")
	return (l:charIsAlphabet)
endfunction

" 全角かどうか?
function! IsFullWidth(char) abort
	let l:charIsFullWidth = (a:char =~ "[^\x01-\x7E]")
	return (l:charIsFullWidth)
endfunction

" 数字かどうか?
function! IsNum(char) abort
	let l:charIsNum = (a:char >= "0" && a:char <= "9")
	return (l:charIsNum)
endfunction

" 開き括弧かどうか?
function IsOpenParenthesis(char) abort
	return (a:char == "{" || a:char == "[" || a:char == "(" || a:char == "<")
endfunction

" 閉じ括弧かどうか?
function IsCloseParenthesis(char) abort
	return (a:char == "}" || a:char == "]" || a:char == ")" || a:char == ">")
endfunction

" 括弧の中にいるかどうか?
function IsInsideParentheses(prevChar,nextChar) abort
	let l:cursorIsInsideParentheses1 = (a:prevChar == "{" && a:nextChar == "}")
	let l:cursorIsInsideParentheses2 = (a:prevChar == "[" && a:nextChar == "]")
	let l:cursorIsInsideParentheses3 = (a:prevChar == "(" && a:nextChar == ")")
	let l:cursorIsInsideParentheses4 = (a:prevChar == "<" && a:nextChar == ">")
	return (l:cursorIsInsideParentheses1 || l:cursorIsInsideParentheses2 || l:cursorIsInsideParentheses3 || l:cursorIsInsideParentheses4)
endfunction

" クォートの中にいるかどうか?
function IsInsideQuot(prevChar, nextChar) abort
	let l:existsQuot = (a:prevChar == "'" && a:nextChar == "'")
	let l:existsDoubleQuot = (a:prevChar == "\"" && a:nextChar == "\"")
	let l:existsBackQuot = (a:prevChar == "`" && a:nextChar == "`")
    return (l:existsQuot || l:existsDoubleQuot || l:existsBackQuot)
endfunction

" 括弧の入力
function! InputParentheses(parenthesis) abort
	let l:nextChar = GetNextString(1)
	let l:prevChar = GetPrevString(1)
	let l:parentheses = { "{": "}", "[": "]", "(": ")", "<": ">" }

	let l:nextCharIsEmpty = (l:nextChar == "")
	let l:nextCharIsCloseParenthesis = (l:nextChar == "}" || l:nextChar == "]" || l:nextChar == ")" || l:nextChar == ">")
	let l:nextCharIsSpace = (l:nextChar == " ")

	" if l:nextCharIsEmpty || l:nextCharIsCloseParenthesis || l:nextCharIsSpace
	if (l:nextCharIsEmpty || l:nextCharIsSpace)
		return a:parenthesis.l:parentheses[a:parenthesis]."\<LEFT>"
	endif
	return a:parenthesis
endfunction

" 閉じ括弧の入力
function! InputCloseParenthesis(parenthesis) abort
	let l:nextChar = GetNextString(1)
	if l:nextChar == a:parenthesis
		return "\<RIGHT>"
	endif
	return a:parenthesis
endfunction

" クォーテーションの入力
function! InputQuot(quot) abort
	let l:nextChar = GetNextString(1)
	let l:prevChar = GetPrevString(1)

	let l:cursorIsInsideQuotes = (l:prevChar == a:quot && l:nextChar == a:quot)
	let l:nextCharIsEmpty = (l:nextChar == "")
	let l:nextCharIsClosingParenthesis = (l:nextChar == "}" || l:nextChar == "]" || l:nextChar == ")")
	let l:nextCharIsSpace = (l:nextChar == " ")
	let l:prevCharIsAlphabet = IsAlphabet(l:prevChar)
	let l:prevCharIsFullWidth = IsFullWidth(l:prevChar)
	let l:prevCharIsNum = IsNum(l:prevChar)
	let l:prevCharIsQuot = (l:prevChar == "\'" || l:prevChar == "\"" || l:prevChar == "\`")

	if l:cursorIsInsideQuotes
		return "\<RIGHT>"
	elseif l:prevCharIsAlphabet || l:prevCharIsNum || l:prevCharIsFullWidth || l:prevCharIsQuot
		return a:quot
	elseif l:nextCharIsEmpty || l:nextCharIsClosingParenthesis || l:nextCharIsSpace
		return a:quot.a:quot."\<LEFT>"
	else
		return a:quot
	endif
endfunction

" カンマの入力
function! InputComma(comma) abort
	let l:nextChar = GetNextString(1)
	let l:prevChar = GetPrevString(1)
	let l:nextCharIsEmpty = (l:nextChar == "")
	let l:nextCharIsSpace = (l:nextChar == " ")
	let l:nextCharIsCloseParenthesis = IsCloseParenthesis(l:nextChar)
    if (l:prevChar == "\"" || l:prevChar == "'") && (l:nextCharIsCloseParenthesis || l:nextCharIsEmpty || l:nextCharIsSpace)
        return ", ".l:prevChar.l:prevChar."\<left>"
    else
        return ","
    endif
endfunction

" 改行の入力
function! InputCR() abort
	let l:nextChar = GetNextString(1)
	let l:prevChar = GetPrevString(1)
	let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)

	if l:cursorIsInsideParentheses
		return "\<CR>\<ESC>\<S-o>"
	else
		return "\<CR>"
	endif
endfunction

" スペースキーの入力
function! InputSpace() abort
	let l:prevChar = GetPrevString(1)
	let l:nextChar = GetNextString(1)
	let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)
	if l:cursorIsInsideParentheses
		return "\<Space>\<Space>\<LEFT>"
	endif

	let l:prevTwoString = GetPrevString(2)
	let l:nextTwoString = GetNextString(2)
    if l:prevChar == "=" && l:prevTwoString != " ="
        return "\<BS>\<Space>=\<Space>"
    endif
    if l:nextChar == "=" && l:nextTwoString != "= "
        return "\<right>\<BS>\<Space>=\<Space>"
    endif
	return "\<Space>"
endfunction

" バックスペースの入力
function! InputBS() abort

	let l:prevChar = GetPrevString(1)
	let l:nextChar = GetNextString(1)
	let l:prevTwoString = GetPrevString(2)
	let l:nextTwoString = GetNextString(2)
	let l:prevThreeString = GetPrevString(3)
	let l:cursorIsInsideParentheses = IsInsideParentheses(l:prevChar,l:nextChar)
    let l:cursorIsInsideQuot = IsInsideQuot(l:prevChar, l:nextChar)
	let l:cursorIsInsideSpace1 = (l:prevTwoString == "{ " && l:nextTwoString == " }")
	let l:cursorIsInsideSpace2 = (l:prevTwoString == "[ " && l:nextTwoString == " ]")
	let l:cursorIsInsideSpace3 = (l:prevTwoString == "( " && l:nextTwoString == " )")
	let l:cursorIsInsideSpace4 = (l:prevTwoString == "< " && l:nextTwoString == " >")
	let l:cursorIsInsideSpace = (l:cursorIsInsideSpace1 || l:cursorIsInsideSpace2 || l:cursorIsInsideSpace3 || l:cursorIsInsideSpace4)
"	let l:existsQuot = (l:prevChar == "'" && l:nextChar == "'")
"	let l:existsDoubleQuot = (l:prevChar == "\"" && l:nextChar == "\"")

    if l:cursorIsInsideQuot && l:prevThreeString == ', '.l:prevChar
        return "\<BS>\<RIGHT>\<BS>\<BS>\<BS>"
    endif

    if l:prevThreeString == ' = '
        return "\<BS>\<BS>\<BS>="
    elseif l:nextTwoString == '= '
        return "\<right>\<right>\<BS>\<BS>\<BS>="
    endif

	if l:cursorIsInsideParentheses || l:cursorIsInsideQuot || l:cursorIsInsideSpace
		return "\<BS>\<RIGHT>\<BS>"
	endif

	return "\<BS>"
endfunction

"" 括弧で挟む
"function! ClipInParentheses(parenthesis) abort
"	let l:mode = mode()
"	let l:parentheses = { "{": "}", "[": "]", "(": ")" }
"	if l:mode ==# "v"
"		return "\"ac".a:parenthesis."\<ESC>\"agpi".l:parentheses[a:parenthesis]
"	elseif l:mode ==# "V"
"		return "\"ac".l:parentheses[a:parenthesis]."\<ESC>\"aPi".a:parenthesis."\<CR>\<ESC>\<UP>=%"
"	endif
"endfunction
"
"" クォーテーションで挟む
"function! ClipInQuot(quot) abort
"	let l:mode = mode()
"	if l:mode ==# "v"
"		return "\"ac".a:quot."\<ESC>\"agpi".a:quot
"	endif
"endfunction

inoremap <expr> { InputParentheses("{")
inoremap <expr> [ InputParentheses("[")
inoremap <expr> ( InputParentheses("(")
inoremap <expr> < InputParentheses("<")
inoremap <expr> } InputCloseParenthesis("}")
inoremap <expr> ] InputCloseParenthesis("]")
inoremap <expr> ) InputCloseParenthesis(")")
inoremap <expr> > InputCloseParenthesis(">")
inoremap <expr> ' InputQuot("\'")
inoremap <expr> " InputQuot("\"")
inoremap <expr> ` InputQuot("\`")
inoremap <expr> , InputComma("\,")
inoremap <expr> <CR> InputCR()
inoremap <expr> <Space> InputSpace()
inoremap <expr> <BS> InputBS()
"xnoremap <expr> { ClipInParentheses("{")
"xnoremap <expr> [ ClipInParentheses("[")
"xnoremap <expr> ( ClipInParentheses("(")
"xnoremap <expr> < ClipInParentheses("<")
"xnoremap <expr> ' ClipInQuot("\'")
"xnoremap <expr> " ClipInQuot("\"")
"xnoremap <expr> ` ClipInQuot("\`")

