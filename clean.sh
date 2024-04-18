#!/bin/bash

set -Ceu

files=(
    '.zshenv'
    '.zprofile'
    '.zshrc'
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
)

if [ -z ${DOTPATH} ]; then
    echo "DOTPATH environment variable is unavailable."
    exit 1
else
    cd ${DOTPATH}
fi

if $(git checkout -b clean > /dev/null 2>&1); then
    git checkout -b clean
    echo "[create] clean branch."
else
    git checkout clean
    echo "[checkout] clean branch."
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
    '.vim/vimrc.d/editing.vim'
    '.vim/vimrc.d/vim-plug-management.vim'
    '.vim/vimrc.d/ui/color-schema.vim'
    '.vim/vimrc.d/ui/vim-status-line.vim'
    '.vim/vimrc.d/plugins/fzf.vim'
    '.vim/vimrc.d/plugins/snipmate.vim'
    '.vim/vimrc.d/plugins/supertab.vim'
    '.vim/vimrc.d/plugins/vim-commentout.vim'
    '.vim/vimrc.d/plugins/vim-emmet.vim'
)
for file in ${files[@]}; do
    mv ${file} ${file}.bk
    grep -v '^\s*"' ${file}.bk | grep -v '^\s*$' > ${file}
    printf ${count}": ";  echo "[clean] ${file}"
    count=$(expr $count + 1)
done
echo "All done."
exit 0

