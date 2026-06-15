# ------------------------------------------
# nodebrew
# ------------------------------------------
# export PATH=${HOME}/.nodebrew/current/bin:${PATH}

# ------------------------------------------
# nvm (node)
# ------------------------------------------
# nvm ls                # List installed Node versions
# nvm install 18        # add any version
# nvm use 18            # switch
# nvm alias default 18  # set default version

# for nvm
# export NVM_DIR="$HOME/.nvm"
# _lazy_load_nvm() {
#     unalias nvm 2>/dev/null
#     unalias node 2>/dev/null
#     unalias npm 2>/dev/null
#     [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
#     # This loads nvm bash_completion
#     [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
#     "$@"
# }
#
# if [ -e "$NVM_DIR/nvm.sh" ]; then
#     alias nvm='_lazy_load_nvm nvm'
#     alias node='_lazy_load_nvm node'
#     alias npm='_lazy_load_nvm npm'
# fi

# for mice
zsh-defer eval "$($HOME/.local/bin/mise activate zsh)"
