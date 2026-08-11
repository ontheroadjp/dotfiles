#-------------------------------------------------
# core-toolkit-for-shell
#-------------------------------------------------
# dirmarks
source $(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/dirmarks/dirmarks.fnc

# shell-stash
alias ss="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/shell-stash/shell-stash.sh"
alias pop="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/shell-stash/shell-stash.sh p"

# backup
alias bk="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/backup/backup.sh bk"
alias brrm="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/backup/backup.sh bkrm"
alias kb="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/backup/backup.sh kb"
alias kbrm="$(ghq root)/github.com/ontheroadjp/core-toolkit-for-shell/backup/backup.sh kbrm"

# quick-memo
alias qm="quick-memo"

# deeple-translate
alias ja="python3 /home/diego/repo/github.com/ontheroadjp/shell-tools/tools/utilities/deepl-translater/deepl-translater.py -o ja"
alias en="python3 /home/diego/repo/github.com/ontheroadjp/shell-tools/tools/utilities/deepl-translater/deepl-translater.py -o en"
alias ko="python3 /home/diego/repo/github.com/ontheroadjp/shell-tools/tools/utilities/deepl-translater/deepl-translater.py -o ko"
alias zh="python3 /home/diego/repo/github.com/ontheroadjp/shell-tools/tools/utilities/deepl-translater/deepl-translater.py -o zh"


# calc
alias calc='noglob calc'

# dict
dict() {
    local url='https://api.starton.jp/dict/english/api/words'
    curl ${url}/$1 -s /concern | \
        jq -r '.headword,.part_of_speech,.meanings[].ja'
}

# yt-dlp
alias ytmp4='yt-dlp -t mp4'
alias ytmp3='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias ytseg='yt-dlp --cookies-from-browser chrome'

