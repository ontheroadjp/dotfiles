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

#-------------------------------------------------
# ssh
#-------------------------------------------------
if [[ -n "$TMUX" ]]; then
    function ssh() {
      if [[ -n "$TMUX" ]]; then
        local pane_id=$(tmux display -p '#{pane_id}')
        # if [[ "$*" == *nobita* ]]; then
          tmux select-pane -P 'bg=colour060,fg=default'
        # fi
        command ssh "$@"
        tmux select-pane -t $pane_id -P 'fg=default,bg=default'
      else
        command ssh "$@"
      fi
    }
fi

#-------------------------------------------------
# set pane name automatically
#-------------------------------------------------
#function _set_tmux_pane_title_automatically() {
# if [[ -n "$TMUX" ]]; then
#   tmux select-pane -T "${1%% *}"
# fi
#}
#
#autoload -Uz add-zsh-hook
#add-zsh-hook preexec _set_tmux_pane_title

#-------------------------------------------------
# set pane name manually
#-------------------------------------------------
function _set_tmux_pane_title_manually() {
    local target=""
    local OPTIND opt

    while getopts "t:" opt; do
        case "${opt}" in
            t) target="${OPTARG}" ;;
            *) echo "Usage: spn [-t pane_id] <title>" >&2; return 1 ;;
        esac
    done

    shift $((OPTIND - 1))

    local title="$1"

    if [[ -z "${title}" ]]; then
        echo "Error: Title is required." >&2
        echo "Usage: spn [-t pane_id] <title>" >&2
        return 1
    fi

    if [[ -n "${target}" ]]; then
        tmux select-pane -t "${target}" -T "${title}"
    else
        tmux select-pane -T "${title}"
    fi
}
alias spn='_set_tmux_pane_title_manually'

#-------------------------------------------------
# popup window
#-------------------------------------------------
#_toggle_tmux_popup_window() {
# local current
# current="$(tmux display-message -p '#{session_name}')"
#
# if [[ "$current" == "$1" ]]; then
#   tmux detach-client
# else
#   tmux display-popup \
#     -d "#{pane_current_path}" \
#     -w 80% \
#     -h 80% \
#     -E "tmux new-session -A -s $1"
# fi
#}
#
#a() { _toggle_tmux_popup_window "popup" }
#server() { _toggle_tmux_popup_window "server" }
