#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

gwine "C:\Program Files (x86)\Steam\steam.exe" \
    -no-cef-sandbox \
    -cef-disable-gpu \
    -cef-disable-gpu-compositing
