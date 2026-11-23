#!/data/data/com.termux/files/usr/bin/bash
# Shared helpers for Termux:X11, PulseAudio, and Adreno Turnip+Zink scripts.

TMPDIR="${TMPDIR:-/data/data/com.termux/files/usr/tmp}"
export TMPDIR

safe_kill_pattern() {
    local pattern="$1"
    local pid
    while IFS= read -r pid; do
        [ -n "$pid" ] || continue
        if [ "$pid" != "$$" ] && [ "$pid" != "$PPID" ]; then
            kill -9 "$pid" 2>/dev/null || true
        fi
    done < <(pgrep -f "$pattern" 2>/dev/null || true)
}

stop_x11_and_audio() {
    am broadcast -a com.termux.x11.ACTION_STOP -p com.termux.x11 >/dev/null 2>&1 || true
    safe_kill_pattern "termux\.x11|Xwayland|pulseaudio"
    rm -rf "$TMPDIR/.X11-unix/X"*
}

stop_wine_and_steam() {
    safe_kill_pattern "steam\.exe|steamwebhelper|wineserver|wine64|wine-preloader|box64"
}

start_pulseaudio() {
    pulseaudio --start \
        --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" \
        --exit-idle-time=-1
}

export_x11_env() {
    export DISPLAY=:1
    export PULSE_SERVER=127.0.0.1
    export XDG_RUNTIME_DIR="$TMPDIR"
}

export_turnip_zink_env() {
    export_x11_env
    # Adreno 740 Hardware Acceleration (Turnip + Zink)
    export MESA_LOADER_DRIVER_OVERRIDE=zink
    export MESA_GL_VERSION_OVERRIDE=4.0
    export MESA_GLSL_VERSION_OVERRIDE=400
    export GALLIUM_DRIVER=zink
    export TU_DEBUG=noconform
    export ZINK_DESCRIPTORS=lazy
    export mesa_glthread=true
}

start_termux_x11() {
    local display="${1:-:1}"
    local display_num="${display#:}"
    local socket="$TMPDIR/.X11-unix/X${display_num}"
    local retries=200 # 200 * 0.05s = 10s

    termux-x11 "$display" &
    while [ ! -S "$socket" ]; do
        retries=$((retries - 1))
        if [ "$retries" -le 0 ]; then
            echo "Error: Timed out waiting for Termux:X11 socket ($socket)." >&2
            return 1
        fi
        sleep 0.05
    done
    echo "• X11 Socket Ready  : $socket"
}

open_termux_x11_app() {
    am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 || true
}

print_system_health() {
    local cores
    cores="$(awk '/^Cpus_allowed_list:/ {print $2}' /proc/self/status 2>/dev/null || echo 'unknown')"
    echo "• Allowed CPU Cores : $cores"
    if [ "$cores" = "0-2" ]; then
        echo "  [WARNING] Locked to efficiency cores (0-2)! Use Termux GitHub + Termux:X11 sharedUid or keep Termux visible."
    fi
    echo "• CPU Cgroup        : $(tr '\n' ' ' < /proc/self/cgroup 2>/dev/null || echo 'unknown')"
    echo "• Available RAM     : $(awk '/^MemAvailable:/ {printf "%.0f MB", $2/1024}' /proc/meminfo 2>/dev/null || echo 'unknown')"
    echo "• Adreno GPU Node   : $([ -r /dev/kgsl-3d0 ] && ls -l /dev/kgsl-3d0 || echo 'MISSING!')"
}
