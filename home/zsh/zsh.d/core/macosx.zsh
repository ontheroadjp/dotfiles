
# ----------------------------------
# .zsh_sessions
# ----------------------------------
# sudo vim /etc/zshrc_Apple_Terminal
# SHELL_SESSION_DIR="${ZDOTDIR:-$HOME}/.zsh_sessions"

# ----------------------------------
# variables
# ----------------------------------
# export PATH="/usr/local/sbin:${PATH}"       # for Homebrew
# export PATH="/usr/local/share:${PATH}"      # for Python
# export PATH="${HOME}/dotfiles/mac_osx/HandBrakeCLI1.4.2/HandBrakeCLI:${PATH}"   # for HandBrakeCLI
export MEMO_PATH=${WORKSPACE}/Dropbox/Documents/NOTE/dev

# Normal command replace
alias tree='tree -N'    # for display Japanese char

# Editor
alias cot="open -a /Applications/CotEditor.app" # CotEditor
alias md="open -a /Applications/MarkText.app"     # Typora

# ctag
# changing the BSD version to the version installed by Homebrew
alias ctags="$(brew --prefix)/bin/ctags"

# open finder
function finder() { [ -z $1 ] && { open .  } || open $1 }

# open terminal the same as current finder dir
function _cd_to_finder_window_opened(){
    target=$(osascript -e \
        'tell application "Finder" to if(count of Finder windows) > 0 then get POSIX path of(target of front Finder window as text)')
    if [ "$target" != "" ]; then
        cd "$target" && pwd
    else
        echo 'No Finder window found.' >&2
    fi
}
alias terminal='_cd_to_finder_window_opened'

# sleep
alias sleepon='sudo pmset -a disablesleep 0'
alias sleepoff='sudo pmset -a disablesleep 1'

# kill notifyd process
function kill-notifyd-process() {
    process=$(ps ax | egrep "[0-9] /usr/sbin/notifyd" | awk '{print $1}')
    sudo kill -9 ${process}
}

# show smtp(d) log
alias smtplog='sudo log stream --predicater'\''(process == "smtpd") \
                        || (process == "smtp")'\'' --info'

