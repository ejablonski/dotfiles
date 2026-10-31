#!/usr/bin/env bash

WALLPAPER="$HOME/Pictures/wp.jpg"

# Tokyo Night Palette (RRGGBBAA)
BG="1a1b26cc"
FG="c0caf5ff"
ACCENT="7aa2f7cc"
WRONG="f7768eff"
VERIFY="7dcfffff"

if [ -f "$WALLPAPER" ]; then
  IMAGE_OPT=(-i "$WALLPAPER" -s fill)
else
  IMAGE_OPT=(-c 1a1b26)
fi

swaylock \
  -f \
  -e \
  -F \
  "${IMAGE_OPT[@]}" \
  --indicator-radius 100 \
  --indicator-thickness 6 \
  --inside-color "$BG" \
  --ring-color "$ACCENT" \
  --key-hl-color "$VERIFY" \
  --bs-hl-color "$WRONG" \
  --inside-ver-color "$BG" \
  --ring-ver-color "$VERIFY" \
  --inside-wrong-color "$BG" \
  --ring-wrong-color "$WRONG" \
  --line-uses-inside \
  --text-color "$FG" \
  --text-ver-color "$FG" \
  --text-wrong-color "$WRONG"
