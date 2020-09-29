# -----------------------------------
# Memo
# -----------------------------------
function _zsh_prompt_memo(){
    if [ $# -eq 0 ]; then
        unset memotxt
        return
    fi
    for str in $@; do
        memotxt="${memotxt} ${str}"
    done
}
alias pmemo="_zsh_prompt_memo"
alias p="_zsh_prompt_memo"

# -----------------------------------
# 補完機能有効にする
# -----------------------------------
## zsh 補完
#source ~/dotfiles/bin/git/git-completion.zsh

autoload -U compinit
compinit -u

# -----------------------------------
# プロンプトに git のブランチ名を表示する
# -----------------------------------
source ~/dotfiles/bin/git/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true         # unstaged (*) and staged (+)
GIT_PS1_SHOWUNTRACKEDFILES=true     # untracked file (%)
GIT_PS1_SHOWSTASHSTATE=true         # stashed ($)
#GIT_PS1_SHOWUPSTREAM=auto          # upstream (<, >, <>, =)

setopt PROMPT_SUBST;
PS1='[%{$fg[green]%}%n@%m(%T)%{${reset_color}%} %{$fg[blue]%}%c%{${reset_color}%}'
PS1=${PS1}'%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}]\$ '
RPROMPT='${memotxt} '"(%?)"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

echo "Load .zshrc"

