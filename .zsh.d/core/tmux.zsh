#-------------------------------------------------
# tmux settings
#-------------------------------------------------
# tmux automatically at terminal startup
if command -v tmux >/dev/null 2>&1; then
  if [ -z "$TMUX" ]; then
    # Get list of existing sessions (exclude popup sessions)
    sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "^popup$")

    if [ -n "$sessions" ]; then
      # attach to existing session without popup
      tmux attach-session -t $(echo "$sessions" | head -n1)
    else
      # create new session
      tmux new-session -s main
    fi
  fi
fi

echo "${fg_bold[blue]} _____ __  __ _   ___  __ ${reset_color}"
echo "${fg_bold[blue]}|_   _|  \/  | | | \ \/ / ${reset_color}"
echo "${fg_bold[blue]}  | | | |\/| | | | |\  /  ${reset_color}"
echo "${fg_bold[blue]}  | | | |  | | |_| |/  \  ${reset_color}"
echo "${fg_bold[blue]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
echo $(date)

