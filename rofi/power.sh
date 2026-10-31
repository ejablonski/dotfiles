#!/usr/bin/env bash

# Handle selected power action
case "$1" in
    "Lock")
        if [ -n "$SWAYSOCK" ] || [ -n "$WAYLAND_DISPLAY" ]; then
            coproc ( ~/.config/sway/lock.sh >/dev/null 2>&1 )
        else
            coproc ( ~/.config/i3/lock.sh >/dev/null 2>&1 )
        fi
        exit 0
        ;;
    "Logout")
        if [ -n "$SWAYSOCK" ] || [ -n "$WAYLAND_DISPLAY" ]; then
            swaymsg exit
        else
            i3-msg exit
        fi
        exit 0
        ;;
    "Sleep")
        systemctl suspend
        exit 0
        ;;
    "Hibernate")
        systemctl hibernate
        exit 0
        ;;
    "Shutdown")
        systemctl poweroff
        exit 0
        ;;
esac

# Header / prompt
echo -en "\0prompt\x1fPower\n"

# Output options with icons and search keywords
echo -en "Lock\0icon\x1fsystem-lock-screen\x1fmeta\x1flock screen\n"
echo -en "Logout\0icon\x1fsystem-log-out\x1fmeta\x1flogout exit leave quit\n"
echo -en "Sleep\0icon\x1fsystem-suspend\x1fmeta\x1fsuspend sleep\n"
echo -en "Hibernate\0icon\x1fsystem-hibernate\x1fmeta\x1fhibernate\n"
echo -en "Shutdown\0icon\x1fsystem-shutdown\x1fmeta\x1fpower off poweroff exit\n"
