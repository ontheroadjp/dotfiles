#-------------------------------------------------
# tmux settings
#-------------------------------------------------

if command -v tmux >/dev/null 2>&1; then
    tmux() {
        # tmux automatically at terminal startup
        if [ $# -eq 0 ]; then
            if [ -z "${TMUX}" ]; then
                # Get list of existing sessions (exclude popup sessions)
                sessions=$(command tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "^popup$")
                if [ -n "${sessions}" ]; then
                    # attach to existing session without popup
                    command tmux attach-session -t $(echo "${sessions}" | head -n1)
                else
                    # create new session
                    command tmux new-session -s main
                fi
            fi
        fi
        # exec original tmux
        command tmux "$@"
    }
else
    echo "tmux doesn't installed."
fi

# if [ -z "${TMUX}" ] && [ -n "$PS1" ]; then
if [[ -o login ]] && [ -z "${TMUX}" ]; then
    tmux
fi

if [ -n "${TMUX}" ]; then
    echo "${fg_bold[blue]} _____ __  __ _   ___  __ ${reset_color}"
    echo "${fg_bold[blue]}|_   _|  \/  | | | \ \/ / ${reset_color}"
    echo "${fg_bold[blue]}  | | | |\/| | | | |\  /  ${reset_color}"
    echo "${fg_bold[blue]}  | | | |  | | |_| |/  \  ${reset_color}"
    echo "${fg_bold[blue]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
    echo $(date)
fi

#-------------------------------------------------
# ssh
#-------------------------------------------------
if [[ -n "$TMUX" ]]; then
    function ssh() {
      if [[ -n "$TMUX" ]]; then
        local pane_id=$(tmux display -p '#{pane_id}')
        # if [[ "$*" == *nobita* ]]; then
          tmux select-pane -P 'fg=white,bg=black'
        # fi
        command ssh "$@"
        tmux select-pane -t $pane_id -P 'fg=default,bg=default'
      else
        command ssh "$@"
      fi
    }
fi

