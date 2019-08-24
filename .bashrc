
# プロンプトに git のブランチ名を表示する
source ~/dotfiles/bin/git/git-prompt.sh
source ~/dotfiles/bin/git/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true

# show username
#export PS1='[\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '


# show username, time
export PS1='[\[\033[32m\]\u@\h\[\033[32m\]($(date +%H:%M)): \[\033[34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '

[[ -n "$VIMRUNTIME" ]] && {
    export PS1='[(\[\033[31m\]VIM\[\033[00m\]) \[\033[34m\]\W \[\033[00m\]\t ]$ '
}

# ユーザー名を表示しない
#export PS1='[\[\033[32m\]@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '

# Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Docker security addition on xxx
#export DOCKER_HOST=tcp://127.0.0.1:2376 DOCKER_TLS_VERIFY=1
# Finished for Docker security addition.
