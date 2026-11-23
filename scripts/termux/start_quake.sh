#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=lib/x11_common.sh
source "$SCRIPT_DIR/lib/x11_common.sh"

LOG_FILE="$HOME/start_quake.log"
exec > >(tee "$LOG_FILE") 2>&1

termux-wake-lock 2>/dev/null || true

# 1. Stop old X11 / audio / i3 / Wine processes
stop_x11_and_audio
pkill -9 -x i3 2>/dev/null || true
stop_wine_and_steam

# 2. Start PulseAudio
start_pulseaudio

# 3. Start Termux:X11 and wait for socket
export_x11_env
start_termux_x11 :1

# 4. Start i3 in background so X11 assigns keyboard & mouse focus properly
dbus-run-session -- i3 &
sleep 0.5

# 5. Open Termux:X11 app
open_termux_x11_app

QUAKE_DIR="$HOME/.wine/drive_c/Program Files (x86)/Steam/steamapps/common/Quake"
if [ ! -d "$QUAKE_DIR" ]; then
    echo "Error: Quake directory not found: $QUAKE_DIR" >&2
    exit 1
fi
mkdir -p "$QUAKE_DIR/rerelease"
echo "2310" > "$QUAKE_DIR/rerelease/steam_appid.txt"
echo "2310" > "$QUAKE_DIR/steam_appid.txt"

echo "=========================================="
print_system_health
echo "=========================================="

# Silence debug logs so audio & framerate don't stutter
export WINEDEBUG=-all
export BOX64_LOG=0
export PULSE_LATENCY_MSEC=80

if [ "${1:-}" = "classic" ]; then
    cd "$QUAKE_DIR" || exit 1
    gwine WinQuake.exe
else
    cd "$QUAKE_DIR/rerelease" || exit 1
    gwine Quake_x64_steam.exe +r_rhirenderfamily d3d11
fi
