
# プロンプトに git のブランチ名を表示する
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\[\033[32m\]@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]]\$ '

# Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

