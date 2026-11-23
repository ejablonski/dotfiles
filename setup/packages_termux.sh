#!/usr/bin/env bash
set -euo pipefail

# Post-install package setup for Termux (+ Termux:X11 + i3 + C++23 dev)
# Recommended: Termux installed from GitHub Releases or F-Droid (not Google Play).
# Pass --headless to skip X11/GUI/audio packages.

if ! command -v pkg >/dev/null 2>&1; then
    echo "Error: 'pkg' not found. Run this script inside Termux." >&2
    exit 1
fi

HEADLESS=false
if [ "${1:-}" = "--headless" ]; then
    HEADLESS=true
fi

echo "Updating base Termux packages..."
pkg update -y
pkg upgrade -y

echo "Enabling x11-repo and tur-repo..."
pkg install -y x11-repo tur-repo
pkg update -y

CORE_PACKAGES=(
    # C++23 toolchain (Clang + GCC 15 via tur-repo + build & debug tools)
    clang
    gcc-15
    gcc-default
    cmake
    make
    ninja
    ccache
    gdb
    pkg-config
    neocmakelsp
    tree-sitter

    # Editor & CLI workflow
    neovim
    ripgrep
    fd
    fzf
    lazygit
    yazi
    timewarrior
    starship
    git
    openssh
)

GUI_PACKAGES=(
    # Termux:X11 + i3 + terminal + audio + Adreno Turnip/Zink acceleration
    termux-x11-nightly
    i3
    rofi
    feh
    kitty
    dbus
    pulseaudio
    mesa
    mesa-vulkan-icd-freedreno
    fontconfig
)

PACKAGES=("${CORE_PACKAGES[@]}")
if [ "$HEADLESS" = false ]; then
    PACKAGES+=("${GUI_PACKAGES[@]}")
fi

echo "Installing Termux packages (headless=$HEADLESS)..."
pkg install -y "${PACKAGES[@]}"

echo ""
echo "Installed compilers:"
clang++ --version | head -n 1 || true
g++ --version | head -n 1 || true

echo ""
echo "Done installing Termux packages!"
if [ "$HEADLESS" = false ]; then
    echo "Reminder: Install JetBrainsMono Nerd Font into ~/.local/share/fonts and run 'fc-cache -fv'."
fi
