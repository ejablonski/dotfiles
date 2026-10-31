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

  # Output formatted string with Pango markup (using Tokyo Night accent colors)
  echo "<span color=\"#7aa2f7\">󰥔</span> $TASK <span color=\"#7dcfff\">($DURATION)</span>"
else
  # Output dimmed placeholder when idle
  echo "<span color=\"#565f89\">󰥔 Idle</span>"
fi
