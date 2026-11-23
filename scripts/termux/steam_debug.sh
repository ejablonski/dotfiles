#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=lib/x11_common.sh
source "$SCRIPT_DIR/lib/x11_common.sh"

stop_wine_and_steam
sleep 0.5

WINEESYNC=0 WINEFSYNC=0 gwine "C:\Program Files (x86)\Steam\steam.exe" \
    -no-cef-sandbox \
    -cef-disable-gpu \
    +open steam://open/minigameslist
