alias diskinfo='lsblk -e 7 -o NAME,FSTYPE,FSVER,SIZE,FSAVAIL,FSUSE%,TYPE,TRAN,MODEL,MOUNTPOINTS'

_diskhealth() {
    sudo smartctl -d sat -A /dev/$1
}
alias diskhealth='_diskhealth' $@

# ```bash
# # mount
# udisksctl mount -b /dev/sdb1
#
# # unmount
# sync
# udisksctl unmount -b /dev/sdb1
# udisksctl power-off -b /dev/sdb
# ```

ninfo() {
    nload -t 1000 $(ip -br addr | fzf | awk '{print $1}')
}
