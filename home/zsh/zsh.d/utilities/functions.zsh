#-------------------------------------------------
# Functions
#-------------------------------------------------
function _is_exist() { type $@ > /dev/null 2>&1 }

#-------------------------------------------------
# Functions for colors
# usage: echo 'piyo' | _red
#-------------------------------------------------
# function _black() { xargs -I{} echo $'\e[30m{}\e[m' }
# function _red() { xargs -I{} echo $'\e[31m{}\e[m' }
# function _green() { xargs -I{} echo $'\e[32m{}\e[m' }
# function _yellow() { xargs -I{} echo $'\e[33m{}\e[m' }
# function _blue() { xargs -I{} echo $'\e[34m{}\e[m' }
# function _pink() { xargs -I{} echo $'\e[35m{}\e[m' }
# function _cyan() { xargs -I{} echo $'\e[36m{}\e[m' }
# function _white() { xargs -I{} echo $'\e[37m{}\e[m' }
#
# function _black_fill() { xargs -I{} echo $'\e[40m{}\e[m' }
# function _red_fill() { xargs -I{} echo $'\e[41m{}\e[m' }
# function _green_fill() { xargs -I{} echo $'\e[42m{}\e[m' }
# function _yellow_fill() { xargs -I{} echo $'\e[43m{}\e[m' }
# function _blue_fill() { xargs -I{} echo $'\e[44m{}\e[m' }
# function _pink_fill() { xargs -I{} echo $'\e[45m{}\e[m' }
# function _cyan_fill() { xargs -I{} echo $'\e[46m{}\e[m' }
# function _white_fill() { xargs -I{} echo $'\e[47m{}\e[m' }

