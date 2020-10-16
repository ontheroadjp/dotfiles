#!/bin/bash

-set Ceu

PROGNAME=$(basename $0)
VERSION="1.0"

function _usage() {
    echo "Usage: ${PROGNAME} [OPTIONS] FILE"
    echo "  This script is ~."
    echo
    echo "Options:"
    echo "  -h, --help"
    echo "      --version"
    echo "  -a, --long-a ARG"
    echo "  -b, --long-b [ARG]"
    echo "  -c, --long-c"
    echo "  -v, --verbose    Print various debugging information"
    echo
    exit 1
}

function _log() {
    [ ${LOGGING} -eq 0 ] && echo $1
}


# -------------------------------------------------------------

function _main() {
    _log "Hello World"
    echo "Hellow World"
}

# -------------------------------------------------------------
LOGGING=false

declare -i argc=0
declare -a argv=()

while (( $# > 0 ))
do
    case $1 in
        -h | --help)
            _usage
            exit 1
            ;;
        --version)
            echo ${VERSION}
            exit 1
            ;;
        -v | --verbose)
            LOGGING=true
            ;;
        -a | --long-a) # Must have argument
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                echo "$PROGNAME: option requires an argument -- $1" 1>&2
                exit 1
            fi
            ARG_A=$2
            shift 2
            ;;
        -b | --long-b) # Either with or without argument is possible
            if [[ -z "$2" ]] || [[ "$2" =~ ^-+ ]]; then
                shift
            else
                shift 2
            fi
            ;;
        -c | --long-c) # no argument
            shift 1
            ;;
        -- | -)
            shift 1
            param+=( "$@" )
            break
            ;;
        -*)
            if [[ "$1" =~ 'n' ]]; then
                nflag='-p'
            fi
            if [[ "$1" =~ 'l' ]]; then
                lflag='-p'
            fi
            if [[ "$1" =~ 'p' ]]; then
                pflag='-p'
            fi
            shift
            ;;
        *)
            ((++argc))
            argv=("${argv[@]}" "$1")
            shift
            ;;
    esac
done

_main

exit 0
