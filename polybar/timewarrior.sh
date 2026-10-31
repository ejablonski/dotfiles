#!/usr/bin/env bash

# Exit silently if timewarrior is not installed
command -v timew >/dev/null 2>&1 || exit 0

# Check if an active tracking session exists
if [ "$(timew get dom.active 2>/dev/null)" = "1" ]; then
  # Extract the tracked tag/annotation from the first line
  TASK=$(timew | head -n 1 | sed 's/^Tracking //')
  [ -z "$TASK" ] && TASK="Active"

  # Extract the formatted elapsed duration
  DURATION=$(timew | awk '/Total/ {print $2}')

  # Output formatted string (using Tokyo Night accent colors)
  echo "%{F#7aa2f7}󰥔%{F-} $TASK %{F#7dcfff}($DURATION)%{F-}"
else
  # Output empty string if you want it invisible when stopped,
  # or a dimmed placeholder when idle:
  echo "%{F#565f89}󰥔 Idle%{F-}"
fi
