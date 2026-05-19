#!/usr/bin/env bash

N=10
times=()

for i in $(seq 1 $N); do
  t=$( { time zsh -l -c exit >/dev/null; } 2>&1 | grep real | sed -E 's/.*0m([0-9]+\.[0-9]+)s/\1/' )
  times+=("$t")
  echo "Run $i: ${t}s"
done

min=${times[0]}
max=${times[0]}
total=0

for t in "${times[@]}"; do
  (( $(echo "$t < $min" | bc -l) )) && min=$t
  (( $(echo "$t > $max" | bc -l) )) && max=$t
  total=$(echo "$total + $t" | bc -l)
done

avg=$(echo "scale=3; $total / $N" | bc -l)

avg=$(printf "%.3f" "$avg")
min=$(printf "%.3f" "$min")
max=$(printf "%.3f" "$max")

echo "----------------------------"
echo "Average start time: ${avg}s (${N}backs)"
echo "Minimum: ${min}s"
echo "Maximum: ${max}s"

