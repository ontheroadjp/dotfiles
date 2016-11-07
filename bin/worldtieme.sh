#!/bin/bash

function _show() {
    printf "Sydney: " && TZ=Australia/Sydney date
    printf "Tokyo: " && TZ=Asia/Tokyo date
    printf "Hong Kong: " && TZ=Asia/Hong_Kong date
    printf "Shanghai: " && TZ=Asia/Shanghai date
    printf "London: " && TZ=Europe/London date
    printf "New York: " && TZ=America/New_York date
    printf "Los Angeles: " && TZ=America/Los_Angeles date
}

_show

exit 0
