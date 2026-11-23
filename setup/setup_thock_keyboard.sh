#!/usr/bin/env bash
# Endorfy Thock wireless keyboard (such as the Thock 75% or TKL Wireless) maps
# F1–F12 to media or brightness controls instead of standard function keys on
# Linux, it is because Linux treats the keyboard through the hid_apple kernel
# module with fnmode=1 (Apple-style media keys by default).
set -e

echo "Configuring Endorfy Thock keyboard (hid_apple fnmode=2)..."

# 1. Persist setting across reboots via modprobe.d
echo "options hid_apple fnmode=2" | sudo tee /etc/modprobe.d/hid_apple.conf >/dev/null
echo "Written: /etc/modprobe.d/hid_apple.conf"

# 2. Apply immediately if the hid_apple module is currently loaded
if [ -f /sys/module/hid_apple/parameters/fnmode ]; then
    echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode >/dev/null
    echo "Applied live: /sys/module/hid_apple/parameters/fnmode = 2"
fi

echo "Done! Function keys (F1-F12) are now default."
