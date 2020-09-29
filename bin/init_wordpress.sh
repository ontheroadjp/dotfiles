
##-------------------------------------------------
## WordPress
##-------------------------------------------------

echo "Where is your WordPress root directory?"
read wproot

echo "What is your theme name?(shud be dir name)"
read themename

#基本設定
export WPROOT=${wproot}
export WPTHEME=${WPROOT}/wp-content/themes/${themename}
export WPPLUGIN=${WPROOT}/wp-content/plugins

#エイリアス（移動用）
cdlatheme() {
	\pushd ${WPROOT}/wp-content/themes/$@ && la
}
alias wp='cdla ${WPROOT}'
alias ${themename}='cdlatheme ${themename}'
alias pl='cdla $WPPLUGIN'

#エイリアス（編集用）
alias wp-config='vim ${WPROOT}/wp-config.php'
alias header='vim ${WPTHEME}/header.php'
alias home='vim ${WPTHEME}/home.php'
alias pindex='vim ${WPTHEME}/index.php'
alias single='vim ${WPTHEME}/single.php'
alias archive='vim ${WPTHEME}/archive.php'
alias sidebar='vim ${WPTHEME}/sidebar.php'
alias style='vim ${WPTHEME}/style.css'
alias functions='vim ${WPTHEME}/functions.php'


