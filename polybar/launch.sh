#!/usr/bin/env bash

# Terminate any running Polybar instances
killall -q polybar

# Wait until the processes have been shut down cleanly
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar on every connected display found by xrandr
if type "xrandr" >/dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi
