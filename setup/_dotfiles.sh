#! /bin/sh

DOTPATH=${HOME}/dotfiles

function _is_exist {
    type $@ > /dev/null 2>&1
}

function _deploy_dotfiles() {
    echo ">>> deploy dotfiles..."
    dotfiles=(
        # bash
        .bash_profile
        .bashrc

        #zsh
        .zshrc
        .zprofile
        .zsh_history
        .zcompdump

        # git
        .gitconfig
        .gitignore_global
        .git_template

        # tmux
        .tmux.conf

        # vim
        .vim
        .vimrc

        # ag
        .agignore
    )

	for f in ${dotfiles[@]}; do
		[ "${f}" = ".git" ] && continue
		if [ -e ${DOTPATH}/${F} ]; then
			ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}" > /dev/null
			echo "success: ${f}"
		else
			echo "missing file/directory: ${f}"
		fi
	done
}

# Karabiner-elements
function _install_karabiner() {
    echo ">>> install karabiner settings..."
    mkdir -p ~/.config
    ln -sf ${DOTPATH}/mac_osx/karabiner_elements ${HOME}/.config/karabiner > /dev/null
    echo "success"
}

# iTerm2
function _install_iterm2() {
    echo ">>> install iTerm2 settings..."
    mkdir -p ~/.config
    ln -sf ${DOTPATH}/mac_osx/iTerm2 ${HOME}/.config/iTerm2 > /dev/null
    echo "success"
}

_deploy_dotfiles
[ $(uname) = 'Darwin' ] && {
    _install_karabiner
    _install_karabiner
}

echo "Complete!"
exit 0
