#!/bin/sh

#-------------------------------------------------
# <Dopecker>
# Functions for Docker
#-------------------------------------------------
function DDn() {
    docker network ls
}

function DDnid() {
    id=$(docker network ls| tail -n +2 | peco | awk '{print $1}')
    if [ ! -z "$id" ] ; then
        echo ${id}
    fi
}
function DDnrm() {
    id=$(DDnid)
    if [ ! -z "$id" ] ; then
        echo 'docker network rm'
        docker network rm $1 ${id}
    fi
}
function DDninspect() {
    id=$(DDnid)
    if [ ! -z "$id" ] ; then
        echo 'docker network inspect'
        docker network inspect ${id}
    fi
}
function DDngateway() {
    id=$(DDnid)
    if [ ! -z "$id" ] ; then
        docker network inspect -f '{{range .IPAM.Config}} {{.Gateway}} {{end}}' ${id} | sed "s/ //"
    fi
}
function DDnsubnet() {
    id=$(DDnid)
    if [ ! -z "$id" ] ; then
        docker network inspect -f '{{range .IPAM.Config}} {{.Subnet}} {{end}}' ${id} | sed "s/ //"
    fi
}
function DDnnode() {
    id=$(DDnid)
    if [ ! -z "$id" ] ; then
        docker network inspect -f '{{range .Containers}} {{.Name}} {{end}}' ${id} | sed "s/ //"
    fi
}
