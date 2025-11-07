#!/usr/bin/env zsh
#
# bench_func.zsh - Benchmark execution time of any Zsh function
#
# Usage
# . /bench_func.zsh [function] [definition file] [Function name] [count] [arguments...]
#
# 例:
#   ./bench_func.zsh ~/.zshrc __git_ps1_update_fast 100
#   ./bench_func.zsh ./myfunc.zsh myfunc 50 arg1 arg2

setopt localoptions errreturn
zmodload zsh/datetime 2>/dev/null

# --- Argument check ---
if (( $# < 2 )); then
  echo "Usage: $0 <function-file> <function-name> [count=100] [args...]" >&2
  exit 1
fi

local file=$1
local func=$2
local count=${3:-100}
shift 3
local args=("$@")

# --- read file ---
if [[ ! -r "${file}" ]]; then
  echo "Cannot read file: ${file}" >&2
  exit 1
fi

source "${file}"

# --- 関数が存在するか確認 ---
if ! typeset -f "${func}" >/dev/null; then
  echo "Function '${func}' not found" >&2
  exit 1
fi

# --- ベンチマーク本体 ---
local total=0 min=999999 max=0 elapsed start end

# ウォームアップ
"${func}" "${args[@]}" >/dev/null 2>&1

for ((i=1; i<=count; i++)); do
  start=${EPOCHREALTIME}
  "${func}" "${args[@]}" >/dev/null 2>&1
  end=${EPOCHREALTIME}
  elapsed=$(printf "%.6f" "$(echo "${end} - ${start}" | bc)")
  (( $(echo "${elapsed} < $min" | bc -l) )) && min=${elapsed}
  (( $(echo "${elapsed} > $max" | bc -l) )) && max=${elapsed}
  total=$(echo "${total} + ${elapsed}" | bc)
done

local avg=$(echo "scale=6; ${total} / ${count}" | bc -l)

print -P "%F{cyan}📊 function:%f ${func}"
print -P "%F{cyan}🔁 times:%f ${count}"
print -P "%F{green}⏱️ average:%f ${avg}s"
print -P "%F{yellow}⚡ Shortest:%f ${min}s"
print -P "%F{red}🐢 longest:%f ${max}s"

