#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=lib/x11_common.sh
source "$SCRIPT_DIR/lib/x11_common.sh"

LOG_FILE="$HOME/start_steam_direct.log"
exec > >(tee "$LOG_FILE") 2>&1

GLIBC_PREFIX="/data/data/com.termux/files/usr/glibc"

termux-wake-lock 2>/dev/null || true

# 1. Stop old X11 / audio / Wine processes
stop_x11_and_audio
stop_wine_and_steam

# 2. Start PulseAudio
start_pulseaudio

# 3. Export X11 / PulseAudio env and start Termux:X11
export_x11_env
start_termux_x11 :1

# 4. Pre-Flight Health Check
echo "=========================================="
echo " [start_steam_direct] Pre-Flight Health Check"
echo " Time: $(date)"
echo "=========================================="
print_system_health
echo "• X11 Socket (:1)   : $([ -S "$TMPDIR/.X11-unix/X1" ] && echo 'OK' || echo 'MISSING!')"
echo "• PulseAudio        : $(pgrep -x pulseaudio >/dev/null && echo 'RUNNING' || echo 'NOT RUNNING')"
echo "• Turnip glibc ICD  : $([ -f "$GLIBC_PREFIX/share/vulkan/icd.d/freedreno_icd.aarch64.json" ] && echo 'OK' || echo 'MISSING!')"
echo "• Shim libfix_fread : $([ -f "$GLIBC_PREFIX/lib/libfix_fread.so" ] && echo 'OK' || echo 'MISSING!')"
echo "• glibc resolv.conf : $([ -f "$GLIBC_PREFIX/etc/resolv.conf" ] && echo 'OK' || echo 'MISSING!')"
echo "=========================================="

# 5. Open Termux:X11 app and launch Steam directly
open_termux_x11_app
sleep 0.5

gwine explorer /desktop=Steam,1280x720 "C:\Program Files (x86)\Steam\steam.exe" \
    -no-cef-sandbox \
    -cef-disable-gpu \
    -cef-disable-gpu-compositing \
    -nochatui \
    -nofriendsui \
    steam://open/minigameslist
