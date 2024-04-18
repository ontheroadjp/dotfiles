# -----------------------------------------
# Ruby
# -----------------------------------------
if [ $(uname) = "Darwin" ]; then
    RBENV_ROOT="$HOME/.rbenv"
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    eval "$(rbenv init -)"
fi

