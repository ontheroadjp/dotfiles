#-------------------------------------------------
# PHP
#-------------------------------------------------
if [ $(uname) = "Darwin" ]; then
    export PATH="/usr/local/opt/php@7.4/bin:$PATH"
    export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
fi

#-------------------------------------------------
# composer
#-------------------------------------------------
export PATH="${PATH}:${HOME}/.composer/vendor/bin"

#-------------------------------------------------
# Laravel
#-------------------------------------------------
alias art='php artisan '
alias tinker='php artisan tinker'
alias pub='php artisan vendor:publish --force'
alias sv='php artisan serve'
alias rl='php artisan route:list'
alias t='vendor/bin/phpunit --colors'
