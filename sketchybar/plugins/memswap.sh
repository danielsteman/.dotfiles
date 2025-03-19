#!/bin/sh

DEFCOLOR="0x44FFFFFF"
ALERTCOLOR="0xAAFF0000"
MEM_USED=$(vm_stat | awk -F ':[ ]*' '
  /Pages active/ {active=$2}
  /Pages wired/ {wired=$2}
  /Pages occupied by compressor/ {compressed=$2}
  END {printf "%.2f GB", (active + wired + compressed) * 4096 / 1024^3}')

clr="$DEFCOLOR"
CRITICAL_THRESHOLD=14

MEM_VALUE=$(echo "$MEM_USED" | awk '{print $1}')

if [ "$(echo "$MEM_VALUE > $CRITICAL_THRESHOLD" | bc -l)" -eq 1 ]; then
    clr="$ALERTCOLOR"
fi

sketchybar --set "$NAME" label="$MEM_USED" icon.color="$clr" label.color="$clr"
