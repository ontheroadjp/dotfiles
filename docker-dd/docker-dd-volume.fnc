#!/bin/sh

#-------------------------------------------------
# <Dopecker>
# Functions for Docker
#-------------------------------------------------
function DV() {
    docker volume ls
}

function DVid() {
    id=$(docker volume ls | tail -n +2 | peco | awk '{print $2}')
    if [ ! -z "$id" ] ; then
        echo ${id} 
    fi
}
function DVrm() {
    id=$(DVid)
    if [ ! -z "$id" ] ; then
        echo 'docker volume rm'
        docker volume rm $1 ${id}
    fi
}
function DVrma() {
    docker volume rm $(docker volume ls -q)
}
function DVinspect() {
    id=$(DVid)
    if [ ! -z "$id" ] ; then
        echo 'docker volume inspect'
        docker volume inspect ${id}
    fi
}
function DVmp() {
    id=$(DVid)
    if [ ! -z "$id" ] ; then
        docker volume inspect -f "{{.Mountpoint}}" $1 ${id}
    fi
}
