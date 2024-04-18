#!/bin/bash

set -Ceu

files=(
    '.zshenv'
    '.zprofile'
    '.zshrc'
    '.vimrc'
    '.zsh.d/core/cdla.zsh'
    '.zsh.d/core/docker.zsh'
    '.zsh.d/core/fzf.zsh'
    '.zsh.d/core/git.zsh'
    '.zsh.d/core/peco.zsh'
    '.zsh.d/core/tmux.zsh'
    '.zsh.d/dev/php.zsh'
    '.zsh.d/dev/ruby.zsh'
    '.zsh.d/dev/vagrant.zsh'
    '.zsh.d/lazy_load_env.sh'
    '.zsh.d/networking.zsh'
    '.zsh.d/shell-tools.zsh'
    '.tmux.conf'
    '.tmux/.tmux.base.conf'
)

if $(git checkout -b clean > /dev/null 2>&1); then
    git checkout -b clean
else
    git checkout clean
fi

count=1
for file in ${files[@]}; do
    mv ${file} ${file}.bk
    grep -v '^\s*#' ${file}.bk | grep -v '^\s*$' > ${file}
    printf ${count}": ";  echo "[clean] ${file}"
    count=$(expr $count + 1)
done
files=(
    '.vimrc'
)
for file in ${files[@]}; do
    mv ${file} ${file}.bk
    grep -v '^\s*"' ${file}.bk | grep -v '^\s*$' > ${file}
    printf ${count}": ";  echo "[clean] ${file}"
    count=$(expr $count + 1)
done
echo "All done."
exit 0

