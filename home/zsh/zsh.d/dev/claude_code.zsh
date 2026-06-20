export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1

claude() {
    emulate -L zsh

    setopt local_traps
    _claude_cleanup() {
        echo "TRAP"
    #     if [[ -n $TMUX ]]; then
    #         local pane_id num
    #         pane_id=$(tmux display-message -p "#{pane_id}" 2>/dev/null)
    #         if [[ -n $pane_id ]]; then
    #             num=$(goslack list | awk -v pid="$pane_id" 'NR>1 && $4==pid {print $1; exit}')
    #             if [[ -n $num ]]; then
    #                 goslack rm "$num" --notify "claude が終了したためマッピングを解除しました。"
    #             fi
    #         fi
    #     fi
        tmux select-pane -T "shell"
    }

    trap _claude_cleanup EXIT
    echo -n "node: " && node -v
    # goslack
    tmux select-pane -T "claude"
    #bash ~/.claude/hooks/tmux-agent-status.sh ✅;
    command claude "$@"
}
