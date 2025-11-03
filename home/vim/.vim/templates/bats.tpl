#!/usr/bin/env bats

SCRIPT_FILE_NAME=$(basename $0)
SCRIPT_NAME=${SCRIPT_FILE_NAME%.*}
SELF=$(cd $(dirname $0); pwd)

TMP_FILE=''
TMP_DIR=''

setup() {
    TMP_FILE=$(mktemp -t "bats_${SCRIPT_FILE_NAME}")
    TMP_DIR=$(mktemp -d -t "bats_${SCRIPT_FILE_NAME}")
}

teardown() {
  rm -rf ${TMP_FILE}
  rm -rf ${TMP_DIR}
}

@test "Running no argument given" {
    run $(${SELF}/${SCRIPT_FILE_NAME})
    [ "${status}" -eq 0 ]
}

@test "addition using bc" {
    result="$(echo 2+2 | bc)"
    [ "$result" -eq 4 ]
}

@test "addition using bc (fail)" {
    result="$(echo 2+1 | bc)"
    [ "$result" -eq 4 ]
}

@test "skip test" {
    skip
    [ ! -f "$test_file" ]
}

@test "normal command" {
    ls
}
