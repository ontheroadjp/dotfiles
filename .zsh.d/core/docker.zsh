#-------------------------------------------------
# WEB (Dockerhub)
#-------------------------------------------------
function _open_my_dockerhub() {
    place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}"
    }
}
alias dockerhub='_open_my_dockerhub';

function dockerhub-build() {
    place="$(ghq list | sed "s:github.com:hub.docker.com/r:" | peco)"
    [ ! -z "${place}" ] && {
        open "https://${place}/builds"
    }
}

#-------------------------------------------------
# Docker
#-------------------------------------------------
[ -e ~/dotfiles/docker-dd ] && {
    source ${DOTPATH}/docker-dd/docker-dd-common.fnc
    source ${DOTPATH}/docker-dd/docker-dd-network.fnc
    source ${DOTPATH}/docker-dd/docker-dd-volume.fnc
}

# for docker-compose.yml
alias dd="docker-compose ${@}"
alias ddup="docker-compose up ${@}"
alias ddupd="docker-compose up -d ${@}"
alias dddown="docker-compose down"
alias ddrestart="docker-compose restart"

echo "Load Docker settings."

