#!/usr/bin/env bash

# Path to your wallpaper (PNG, JPG, or SVG)
WALLPAPER="$HOME/Pictures/wp.jpg"

# Tokyo Night Palette
BG="1a1b26"
FG="c0caf5"
ACCENT="7aa2f7"
WRONG="f7768e"
VERIFY="7dcfff"

i3lock \
  --image="$WALLPAPER" \
  --fill \
  --ignore-empty-password \
  --show-failed-attempts \
  --nofork \
  --radius=100 \
  --ring-width=6 \
  --indicator \
  --clock \
  --time-str="%H:%M" \
  --time-color="${FG}ff" \
  --time-size=38 \
  --date-str="%A, %d %B" \
  --date-color="${FG}aa" \
  --date-size=14 \
  --inside-color="${BG}cc" \
  --ring-color="${ACCENT}cc" \
  --keyhl-color="${VERIFY}ff" \
  --bshl-color="${WRONG}ff" \
  --insidever-color="${BG}cc" \
  --ringver-color="${VERIFY}ff" \
  --insidewrong-color="${BG}cc" \
  --ringwrong-color="${WRONG}ff" \
  --line-uses-inside \
  --verif-text="Verifying..." \
  --verif-color="${FG}ff" \
  --wrong-text="Incorrect" \
  --wrong-color="${WRONG}ff" \
  --noinput-text=""
