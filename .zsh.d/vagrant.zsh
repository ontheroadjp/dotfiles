#-------------------------------------------------
# Vagrant
#-------------------------------------------------
alias v='vagrant ssh'
alias vu='vagrant up'
alias vh='vagrant halt'
alias vd='vagrant destroy'
alias von='vagrant sandbox on'
alias voff='vagrant sandbox off'
alias vrb='vagrant sandbox rollback'
alias vc='vagrant sandbox commit'

alias vbl='vagrant box list'
alias vs='vagrant status'

#    # enable completion for the vagrant
#    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
#        source `brew --prefix`/etc/bash_completion.d/vagrant
#    elif _is_exist brew; then
#        brew tap homebrew/completions
#        source `brew --prefix`/etc/bash_completion.d/vagrant
#    fi
echo "Load Vagrant settings."
