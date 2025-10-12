#!/bin/sh

function DDhelp() {
    DDh
}
function DDh() {
  cat <<-EOF
Usage:
    <command>
command
    DD                  Show all containers
    DDimages            Show all images
    DDps                Show running containers
    DDpsa               Show all containers
    DDstart             Start stopped container
    DDstop              Stop running container
    DDstopa             Stop all of running container
    DDrm                Remove a container
    DDrma               Remove all of running containers
    DDdown              Stop and remove running container
    DDid                Show container id
    DDrmi               Remove image
    DDrmia              Remove all images
    DDnone              Remove <none> image
    DDidi               Show image id
    DDbash              Go into container with /bin/bash
    DDsh                Go into container with /bin/sh
    DDmysql             Go into container with mysql -u root -proot
    DDmongo             Go into container with mongo -u root -p
    DDmyadmin           Run phpMyAdmin container connected to you container
                        usage: http://<host>:8080
    DDstats             Display a live stream of container
    DDtop               Display the running processes of a container
    DDlogs              Fetch the logs of a container
    DDhistory           Show the history of an image
    DDinspect           Return low-level information on a container
    DDip                Show the IP Address of a container
    DDhosts             Show the contents in /etc/hosts file
    DDenv               List defined environment variables

    (Network commnad)
    DN                  Show all networks
    DNrm                Remove a network
    DNinspect           Display detailed information on network
    DNgateway           Show the Gateway IPv4 Address of a network
    DNsubnet            Show the Subnet IPv4 Address of a network
    DNnode              List containers connected a network
    DNid                Show a network id

    (Volume command)
    DV                  Show all volumes
    DVrm                Remove a volume
    DVinspect           Display detailed information on volume
    DVmp                Show the directory path stored real data
    DVid                Show a volume id

    DDh                 Show usage of the docker-dd

EOF
}

#-------------------------------------------------

function DD() {
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<Running: Up>\033[0m"
    docker ps | grep -v Restarting | tail -n +2 | awk 'BEGIN{OFS=" "}
        function red(f,s) { printf "\033[1;31m" f "\033[0m",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m",s }
        { printf "%-2d: ",NR }{ printf "%-18.17s",$1 }
        { blue("%-25.24s",$2) }{ green("%s",$NF) }{ printf "\n"  }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<Stopped>\033[0m"
    docker ps -a | grep "Exited \([0-9]*\)" | awk 'BEGIN{OFS=" "}
        function red(f,s) { printf "\033[1;31m" f "\033[0m",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m",s }
        { printf "%-2d: ",NR }{ printf "%-18.17s",$1 }
        { blue("%-25.24s",$2) }{ green("%s",$NF) }{ printf "\n"  }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<Stopped: Created>\033[0m"
    docker ps -a | grep "Created" | awk 'BEGIN{OFS=" "}
        function red(f,s) { printf "\033[1;31m" f "\033[0m",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m",s }
        { printf "%-2d: ",NR }{ printf "%-18.17s",$1 }
        { blue("%-25.24s",$2) }{ green("%s",$NF) }{ printf "\n"  }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<Error:Dead>\033[0m"
    docker ps -a | grep "Dead" | awk 'BEGIN{OFS=" "}
        function red(f,s) { printf "\033[1;31m" f "\033[0m",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m",s }
        { printf "%-2d: ",NR }{ printf "%-18.17s",$1 }
        { blue("%-25.24s",$2) }{ green("%s",$NF) }{ printf "\n"  }'
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<Error: Restarting>\033[0m"
    docker ps -a | grep "Restarting \([0-9]*\)" | awk 'BEGIN{OFS=" "}
        function red(f,s) { printf "\033[1;31m" f "\033[0m",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m",s }
        { printf "%-2d: ",NR }{ printf "%-18.17s",$1 }
        { blue("%-25.24s",$2) }{ green("%s",$NF) }{ printf "\n"  }'
}
function DDimages() {
    echo -e "\033[1;33m--------------------------------\033[0m"
    echo -e "\033[1;33m<IMAGES>\033[0m"
    docker images | tail -n +2 | awk 'BEGIN{OFS="\t"} \
        function red(f,s) { printf "\033[1;31m" f "\033[0m \t",s }
        function green(f,s) { printf "\033[1;32m" f "\033[0m \t",s }
        function yellow(f,s) { printf "\033[1;33m" f "\033[0m",s }
        function blue(f,s) { printf "\033[1;34m" f "\033[0m \t",s }
        { printf "%-2d: ",NR }
        { blue("%-25.23s",$1) }{ green("%-15.14s",$2) }
        { printf "%-15.14s",$3 }{ printf "%-6.5s",$(NF - 1) }{ print $NF }'
}
function DDi() {
    echo '<docker images>'
    docker images | tail -n +2
}

#-------------------------------------------------
# for container controll
#-------------------------------------------------
function DDps() {
    echo '<docker ps>'
   docker ps | tail -n +2
}
function DDpsa() {
    echo '<docker ps -a>'
   docker ps -a | tail -n +2
}
function DDstart() {
    id=$(docker ps -a | grep "Exited \([0-9]*\)" | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker start'
        docker start ${id}
    fi
}
function DDstop() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker stop'
        docker stop ${id}
    fi
}
function DDstopa() {
    echo 'docker stop'
    docker stop $(docker ps -a -q)
}
function DDrm() {
    id=$(docker ps -a | grep "Created \| Dead \| Exited \([0-9]*\)" | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker rm'
        docker rm $1 ${id}
    fi
}
function DDrma() {
    containers=$(docker ps -a -q \
        --filter status='restarting' \
        --filter status='paused' \
        --filter status='exited' \
        --filter status='dead' \
    )

    [ ! -z ${containers} ] && {
        docker rm ${containers}
        echo 'remove all docker containers.'
    } || {
        echo 'No container is running.'
    }
}
function DDdown() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker stop'
        docker stop ${id}
        echo 'docker rm'
        docker rm ${id}
    fi
}
function DDkill() {
    id=$(docker ps -a | grep "Dead \| Restarting" | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo 'docker rm'
        docker rm -f ${id}
    fi
}
function DDid() {
    id=$(docker ps | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        echo ${id}
    fi
}

#-------------------------------------------------
# for image controll
#-------------------------------------------------
function DDrmi() {
    id=$(docker images | tail -n +2 | peco | awk '{print $3}')
    if [ ! -z "$id" ] ; then
        echo 'docker rmi'
        docker rmi $1 ${id}
    fi
}
function DDrmia() {
        echo 'docker rmi'
        docker rmi $1 $(docker images -q)
}
function DDnone() {
    echo 'docker <none>'
    docker rmi $(docker images | awk '/^<none>/ { print $3 }')
}
function DDidi() {
    id=$(docker images | tail -n +2 | peco | awk '{ print $3 }')
    if [ ! -z "$id" ] ; then
        echo ${id}
    fi
}

#-------------------------------------------------
# for container working
#-------------------------------------------------
function DDrun() {
    id=$(DDidi)
    if [ ! -z "$id" ] ; then
        docker run -v $(pwd):/root/DIR -itd ${id}
    fi
}
function DDzsh() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} /bin/zsh --login
    fi
}
function DDbash() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} /bin/bash --login
    fi
}
function DDsh() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} /bin/sh --login
    fi
}
function DDmysql() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker exec -i -t ${id} mysql -u root -proot
    fi
}
function DDmongo() {
    id=$(DDid)
    if [ ! -z "$id" ]; then
        docker exec -i -t ${id} mongo -u root -p
    fi
}
function DDmyadmin() {
    ip=$(DDip)
    if [ ! -z "$ip" ] ; then
        docker run -d -e PMA_HOST=${ip} -p 8080:80 phpmyadmin/phpmyadmin
    fi
}

#-------------------------------------------------
# for getting container/image condition
#-------------------------------------------------
function DDstats() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker stats ${id}
    fi
}
function DDtop() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        docker top ${id}
    fi
}
function DDlogs() {
    id=$(docker ps -a | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker logs $1 ${id}
    fi
}
function DDhistory() {
    id=$(docker images | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker history ${id}
    fi
}
function DDinspect() {
    id=$(docker ps -a | tail -n +2 | peco | cut -d" " -f1)
    if [ ! -z "$id" ] ; then
        docker inspect ${id} | less
    fi
}
function DDip() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        #echo -e "\033[1;33m<IPAddress@${id}>\033[0m"
        out=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' ${id})
        if [ ! -z "${out}" ]; then
            echo ${out}; exit 0
        fi

        network=$(docker inspect -f '{{ .HostConfig.NetworkMode }}' ${id})
        docker inspect -f "{{ .NetworkSettings.Networks.${network}.IPAddress }}" ${id}
    fi
}
#function DDvol() {
#    id=$(DDid)
#    if [ ! -z "$id" ] ; then
#        docker inspect -f '{{ .Volumes }}' ${id}
#    fi
#}
function DDhosts() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        #echo -e "\033[1;33m</etc/hosts@${id}>\033[0m"
        docker exec -i -t ${id} cat /etc/hosts
    fi
}
function DDenv() {
    id=$(DDid)
    if [ ! -z "$id" ] ; then
        #echo -e "\033[1;33m<env@${id}>\033[0m"
        docker exec -i -t ${id} env
    fi
}

