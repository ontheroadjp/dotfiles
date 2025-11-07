#!/usr/bin/env zsh
#
# bench.zsh - 任意のコマンドの実行時間をベンチマーク
#
# 使い方:
#   ./bench.zsh "コマンド" [回数]
#
# 例:
#   ./bench.zsh "git status --porcelain" 50
#   ./bench.zsh "ls -l" 100

setopt localoptions errreturn
zmodload zsh/datetime 2>/dev/null

if (( $# < 1 )); then
  echo "Usage: $0 <command> [count=100]" >&2
  exit 1
fi

local cmd="$1"
local count=${2:-100}
local total=0 min=999999 max=0 elapsed start end

# --- ウォームアップ1回（キャッシュ除去）---
eval "$cmd" >/dev/null 2>&1

for ((i=1; i<=count; i++)); do
  start=$EPOCHREALTIME
  eval "$cmd" >/dev/null 2>&1
  end=$EPOCHREALTIME
  elapsed=$(printf "%.6f" "$(echo "$end - $start" | bc)")
  (( $(echo "$elapsed < $min" | bc -l) )) && min=$elapsed
  (( $(echo "$elapsed > $max" | bc -l) )) && max=$elapsed
  total=$(echo "$total + $elapsed" | bc)
done

local avg=$(echo "scale=6; $total / $count" | bc -l)

print -P "%F{cyan}💻 コマンド:%f $cmd"
print -P "%F{cyan}🔁 回数:%f $count"
print -P "%F{green}⏱️ 平均:%f ${avg}s"
print -P "%F{yellow}⚡ 最短:%f ${min}s"
print -P "%F{red}🐢 最長:%f ${max}s"

