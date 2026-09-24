#!/usr/bin/env bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "—"')
PARAM=$(echo "$input" | jq -r '.model.param_summary // empty')
DIR=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
WORKTREE=$(echo "$input" | jq -r '.worktree.name // empty')
MAX=$(echo "$input" | jq -r '.model.max_mode // false')

fg()  { printf '\033[38;2;%s;%s;%sm' "$1" "$2" "$3"; }
bold=$'\033[1m'
dim=$'\033[2m'
reset=$'\033[0m'

if [ -n "$WORKTREE" ]; then
  LOC="$WORKTREE"
else
  LOC="${DIR##*/}"
fi

BRANCH=""
if [ -n "$DIR" ] && git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
  BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
fi

MS=$(python3 -c 'import time; print(int(time.time()*1000))' 2>/dev/null || echo $(($(date +%s) * 1000)))
FRAME=$(( (MS / 125) % 8 ))

SPINS=('🌀' '✨' '⚡' '💫' '🌟' '🔥' '💥' '🌈')
SPIN="${SPINS[$FRAME]}"
SPARKS=('✨' '⭐' '🌟' '💫' '✨' '⭐' '🌟' '💫')
SPARK="${SPARKS[$FRAME]}"
SPARK2="${SPARKS[$(( (FRAME + 3) % 8 ))]}"

case $FRAME in
  0) AR=0;   AG=220; AB=255 ;;
  1) AR=80;  AG=160; AB=255 ;;
  2) AR=180; AG=100; AB=255 ;;
  3) AR=255; AG=80;  AB=200 ;;
  4) AR=255; AG=120; AB=80  ;;
  5) AR=255; AG=200; AB=40  ;;
  6) AR=120; AG=255; AB=100 ;;
  7) AR=40;  AG=240; AB=200 ;;
esac

if   [ "$PCT" -ge 91 ]; then
  case $((FRAME % 2)) in
    0) CR=255; CG=40;  CB=60  ;;
    1) CR=255; CG=100; CB=80  ;;
  esac
  CTX_EMOJI='🥵'
elif [ "$PCT" -ge 76 ]; then
  CR=255; CG=140; CB=40
  CTX_EMOJI='😰'
elif [ "$PCT" -ge 51 ]; then
  CR=255; CG=210; CB=50
  CTX_EMOJI='😅'
else
  CR=50;  CG=220; CB=140
  CTX_EMOJI='🧠'
fi

BAR_WIDTH=10
FILLED=$((PCT * BAR_WIDTH / 100))
EMPTY=$((BAR_WIDTH - FILLED))
BAR=""

for ((i = 0; i < FILLED; i++)); do
  POS=$(( (i + 1) * 100 / BAR_WIDTH ))
  if   [ "$POS" -ge 91 ]; then BAR+='🟥'
  elif [ "$POS" -ge 76 ]; then BAR+='🟧'
  elif [ "$POS" -ge 51 ]; then BAR+='🟨'
  else BAR+='🟩'
  fi
done

for ((i = 0; i < EMPTY; i++)); do
  BAR+='⬛'
done

MODEL_PART="$MODEL"
[ -n "$PARAM" ] && MODEL_PART="$MODEL ${dim}${PARAM}${reset}$(fg "$AR" "$AG" "$AB")"

MAX_BADGE=""
[ "$MAX" = "true" ] && MAX_BADGE=" 🚀 MAX"

LINE1="${SPIN} $(fg "$AR" "$AG" "$AB")${bold}${MODEL_PART}${reset}${MAX_BADGE} "
LINE1+="${SPARK} 📁 ${LOC}"
[ -n "$BRANCH" ] && LINE1+=" 🌿 ${BRANCH}"
LINE1+=" ${SPARK2}"

LINE2="${CTX_EMOJI} ${BAR} $(fg "$CR" "$CG" "$CB")${bold}${PCT}%${reset}"

printf '%b\n%b\n' "$LINE1" "$LINE2"
