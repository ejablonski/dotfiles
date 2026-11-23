#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
# shellcheck source=lib/x11_common.sh
source "$SCRIPT_DIR/lib/x11_common.sh"

LOG_FILE="$HOME/start_i3.log"
exec > >(tee "$LOG_FILE") 2>&1

termux-wake-lock 2>/dev/null || true

echo "=========================================="
echo " [start_i3] Pre-Flight Health Check"
echo " Time: $(date)"
echo "=========================================="
print_system_health
echo "=========================================="

# 1. Stop old X11 / audio processes
stop_x11_and_audio

# 2. Start PulseAudio
start_pulseaudio

# 3. Export Display & Adreno 740 Hardware Acceleration (Turnip + Zink)
export_turnip_zink_env

# 4. Start Termux:X11 and wait for socket
start_termux_x11 :1

# 5. Open Termux:X11 app and launch native i3
open_termux_x11_app
dbus-run-session -- i3
