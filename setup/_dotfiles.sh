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

        # tmux
        .tmux.conf

        # vim
        .vim
        .vimrc
    )

	for f in ${dotfiles[@]}
	do
		[ "${f}" = ".git" ] && continue
		if [ -e ${DOTPATH}/${F} ]; then
			ln -snfv "${DOTPATH}/${f}" "${HOME}/${f}" > /dev/null
			echo "success: ${f}"
		else
			echo "missing file/directory: ${f}"
		fi
	done

	# Karabiner
    karabiner_path="${HOME}/Library/Application\ Support/Karabiner/private.xml"
	if [ -e "${karabiner_path}" ]; then
	    ln -sf ${DOTPATH}/karabiner/private.xml ${karabiner_path} > /dev/null
	    echo "success: Karabiner - private.xml"
    fi
}

_deploy_dotfiles && {
    echo "Complete!"
}

exit 0
