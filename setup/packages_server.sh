#!/usr/bin/env bash
set -euo pipefail

# Post-install package setup for Server (Manjaro / Arch + minimal i3 + C++ dev)
# Pass --headless to skip X11/GUI packages on SSH-only servers.

HEADLESS=false
if [ "${1:-}" = "--headless" ]; then
    HEADLESS=true
fi

CORE_PACKAGES=(
    # C/C++ development & Neovim toolchain
    neovim
    ripgrep
    fd
    fzf
    clang
    cmake
    make
    gcc
    neocmakelsp

    # CLI tools
    lazygit
    yazi
    timewarrior
    starship
)

GUI_PACKAGES=(
    i3-wm
    rofi
    feh
    kitty
    ttf-jetbrains-mono-nerd
)

PACKAGES=("${CORE_PACKAGES[@]}")
if [ "$HEADLESS" = false ]; then
    PACKAGES+=("${GUI_PACKAGES[@]}")
fi

echo "Installing server (Manjaro / Arch) packages (headless=$HEADLESS)..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

echo "Done installing server packages!"
