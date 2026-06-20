codex() {
    emulate -L zsh
    setopt local_traps

    _codex_cleanup() {
        echo "TRAP"
        if [[ -n $TMUX ]]; then
            local pane_id num
            pane_id=$(tmux display-message -p "#{pane_id}" 2>/dev/null)
            if [[ -n $pane_id ]]; then
                num=$(goslack list | awk -v pid="$pane_id" 'NR>1 && $4==pid {print $1; exit}')
                if [[ -n $num ]]; then
                    goslack rm "$num" --notify "codex が終了したためマッピングを解除しました。"
                fi
            fi
        fi
        tmux select-pane -T "shell"
    }

    # trap _codex_cleanup EXIT

    echo -n "node: "
    node -v || return 1
    echo -n "python3: " && python3 --version
    tmux select-pane -T "codex"
    # goslack
    # bash ~/.claude/hooks/tmux-agent-status.sh ✅;
    command codex --sandbox danger-full-access --ask-for-approval untrusted "$@"
    # command codex "$@"
}
