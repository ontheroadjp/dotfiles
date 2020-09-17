# -----------------------------------
# Memo
# -----------------------------------
function memo(){
    if [ $# -eq 0 ]; then
        unset memotxt
        return
    fi
    for str in $@
    do
        memotxt="${memotxt} ${str}"
    done
}

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
# -----------------------------------
# プロンプトに git のブランチ名を表示する(vcs_info 版)
# -----------------------------------
#autoload -Uz vcs_info
#zstyle ':vcs_info:*' enable git svn
#zstyle ':vcs_info:*' max-exports 6 # formatsに入る変数の最大数
#zstyle ':vcs_info:git:*' check-for-changes true
#zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
#zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
##zstyle ':vcs_info:*' formats "%F{green}%c%u(%b)%f"
#zstyle ':vcs_info:*' formats "%F{green}%c%u(%r)%f%r"
#zstyle ':vcs_info:*' actionformats '(%b|%a)'
#precmd(){ vcs_info }

# プロンプトの変更(left)
#setopt PROMPT_SUBST; PROMPT="["
#PROMPT=${PROMPT}'%{$fg[green]%}${USER}@${HOST%%.*}(%T)'
#PROMPT=${PROMPT}': '
#PROMPT=${PROMPT}'%{$fg[blue]%}%1~ ${vcs_info_msg_0_}${reset_color}'
#PROMPT=${PROMPT}']%(!.#.$) '
#RPROMPT='${memotxt}''${vcs_info_msg_0_}'"$p_color (%?)%{${reset_color}%}"

# プロンプトの変更(right)
#RPROMPT='${memotxt}''%{$fg[red]%}$(__git_ps1 " (%s)")%{${reset_color}%}'"$p_color (%?)%{${reset_color}%}"
#RPROMPT='${memotxt}''$(__git_ps1 " (%s%r)")'"$p_color (%?)"

RPROMPT='${memotxt}'"(%?)"

echo "Load .zshrc"
