#!/usr/bin/env bash

# Exit silently if timewarrior is not installed
command -v timew >/dev/null 2>&1 || exit 0

# Check if an active tracking session exists
if [ "$(timew get dom.active 2>/dev/null)" = "1" ]; then
  ACTIVE_JSON=$(timew get dom.active.json 2>/dev/null)

  TASK=""
  if [ -n "$ACTIVE_JSON" ]; then
    TASK=$(python3 -c '
import sys, json

try:
    data = json.loads(sys.argv[1])
    tags = " ".join(data.get("tags", []))
    annotation = (data.get("annotation") or "").strip()
    if tags and annotation:
        task = f"{tags} \"{annotation}\""
    elif annotation:
        task = f"\"{annotation}\""
    elif tags:
        task = tags
    else:
        task = "Active"
except Exception:
    task = "Active"

print(task)
' "$ACTIVE_JSON" 2>/dev/null)
  fi

  # Fallback to plain tag from timew if json parsing was empty
  if [ -z "$TASK" ]; then
    TASK=$(timew 2>/dev/null | head -n 1 | sed 's/^Tracking //')
    [ -z "$TASK" ] && TASK="Active"
  fi

  # Extract the formatted elapsed duration
  DURATION=$(timew 2>/dev/null | awk '/Total/ {print $2}')
  [ -z "$DURATION" ] && DURATION="0:00:00"

  # Output formatted string (using Tokyo Night accent colors)
  echo "%{F#7aa2f7}󰥔%{F-} $TASK %{F#7dcfff}($DURATION)%{F-}"
else
  # Output dimmed placeholder when idle
  echo "%{F#565f89}󰥔 Idle%{F-}"
fi
