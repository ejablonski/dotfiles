#!/usr/bin/env bash
set -euo pipefail

# Post-install package setup for Laptop (Manjaro / Arch + Sway)

PACKAGES=(
    # Sway & Wayland desktop
    sway
    waybar
    rofi
    swaybg
    swaylock
    swayidle
    swaynag
    wl-clipboard
    cliphist
    grim
    slurp
    brightnessctl
    playerctl
    pavucontrol
    xdg-desktop-portal-wlr
    xfce4-settings

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

    # Terminal, CLI tools & PDF viewer
    kitty
    lazygit
    yazi
    timewarrior
    zathura
    zathura-pdf-mupdf
    starship

    # Fonts
    ttf-jetbrains-mono-nerd
)

echo "Installing laptop (Manjaro / Arch + Sway) packages..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

echo "Installing AUR packages (swaysome)..."
if command -v pamac >/dev/null 2>&1; then
    pamac install --no-confirm swaysome
elif command -v yay >/dev/null 2>&1; then
    yay -S --needed swaysome
elif command -v paru >/dev/null 2>&1; then
    paru -S --needed swaysome
else
    echo "Warning: No AUR helper (pamac/yay/paru) found. Install 'swaysome' manually from AUR."
fi

echo "Done installing laptop packages!"
