#-------------------------------------------------
# tmux settings
#-------------------------------------------------
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function tmux_automatically_attach_session() {
    if is_tmux_runnning; then
        echo "${fg_bold[blue]} _____ __  __ _   ___  __ ${reset_color}"
        echo "${fg_bold[blue]}|_   _|  \/  | | | \ \/ / ${reset_color}"
        echo "${fg_bold[blue]}  | | | |\/| | | | |\  /  ${reset_color}"
        echo "${fg_bold[blue]}  | | | |  | | |_| |/  \  ${reset_color}"
        echo "${fg_bold[blue]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        echo $(date)
    fi
}
tmux_automatically_attach_session

