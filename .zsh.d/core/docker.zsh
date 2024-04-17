#-------------------------------------------------
# WEB (Dockerhub)
#-------------------------------------------------
#if _is_exist ghq && _is_exist peco; then
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
#fi

#-------------------------------------------------
# Docker
#-------------------------------------------------
#if _is_exist docker; then
    [ -e ~/dotfiles/docker-dd ] && {
        source ${DOTPATH}/docker-dd/docker-dd-common.fnc
        source ${DOTPATH}/docker-dd/docker-dd-network.fnc
        source ${DOTPATH}/docker-dd/docker-dd-volume.fnc
    }

    #export TOYBOX_HOME=/home/nobita/workspace/docker-toybox
    #export PATH=${TOYBOX_HOME}/bin:${PATH}
    #if [ -f ${TOYBOX_HOME}/bin/complition.sh ]; then
    #    source ${TOYBOX_HOME}/bin/complition.sh
    #fi

    # for docker-compose.yml
    alias dd="docker-compose ${@}"
    alias ddup="docker-compose up ${@}"
    alias ddupd="docker-compose up -d ${@}"
    alias dddown="docker-compose down"
    alias ddrestart="docker-compose restart"

    echo "Load Docker settings."
#fi
