#-------------------------------------------------
# Networking
#-------------------------------------------------
# auto URL encode in TERMINAL
# This causes pasted URLs to be automatically quoted,
# without needing to disable globbing.
#autoload -Uz bracketed-paste-magic
#zle -N bracketed-paste bracketed-paste-magic
#autoload -Uz url-quote-magic
#zle -N self-insert url-quote-magic

# URL Encoding
function _urlencode {
  echo "$1" | nkf -WwMQ | sed 's/=$//g' | tr = % | tr -d '\n'
}

# show IP Address
alias ip='ipconfig getifaddr en0'
#alias ip='ipconfig getifaddr en1'

# dstat - Server resourse monitoring
if _is_exist dstat; then
    alias dfull='dstat -Tclmdrn'
    alias dmem='dstat -Tclm'
    alias dcpu='dstat -Tclr'
    alias dnet='dstat -Tclnd'
    alias ddisk='dstat -Tcldr'
    alias dplugins='la /usr/share/dstat/*.py'
fi


