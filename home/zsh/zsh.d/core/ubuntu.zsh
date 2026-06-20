# alias
alias open='xdg-open'

alias sleepoff="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
alias sleepon="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"

# terminal
alias terminal='gnome-terminal --working-directory="$PWD"'


# clipboard
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'
alias pc=pbcopy

# clipboard (gpaste)
alias clip="gpaste-client get $(gpaste-client history | fzf | cut -d: -f1) | pbcopy"

# battery
alias power-info="upower -i $(upower -e | grep 'BAT')"
alias power="cat /sys/class/power_supply/BAT0/capacity"
alias power-status="cat /sys/class/power_supply/BAT0/status"

# calender popup
alias cal="gnome-calendar"

# mpv
# alias video='mpv "$(fd -e mp4 -e mkv -e webm | fzf)"'
# alias music='mpv --no-video "$(fd -e mp3 -e mp4 -e mkv -e webm | fzf)"'
alias video="fd -t f -e mp4 -e wmv -e m4a -e flac | fzf -m | xargs -d '\n' mpv"
# alias music="fd -t f -e mp3 -e m4a -e flac | fzf -m | xargs -d '\n' mpv --no-video"

# gocryptfs
alias neymaron="mkdir -p ~/Documents/neymar && gocryptfs ~/Documents/neymar.enc ~/Documents/neymar"
alias neymaroff="fusermount -u ~/Documents/neymar && rm -rf ~/Documents/neymar"

# rclone for Google Drive
gdrive() {
    rclone mount gdrive: ~/mnt/gdrive \
        --vfs-cache-mode full \
        --vfs-cache-max-size 20G \
        --vfs-cache-max-age 24h \
        --daemon
}
