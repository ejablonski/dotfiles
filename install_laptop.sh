#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$TARGET_DIR"

APPS=(
    sway
    waybar
    rofi
    zathura
    xfce4
    nvim
    kitty
    yazi
    lazygit
    timewarrior
)

link_config() {
    local src="$1"
    local target="$2"
    local label="$3"

    if [ ! -e "$src" ]; then
        echo "Skipping $label: source not found ($src)"
        return
    fi

    if [ "$src" -ef "$target" ]; then
        echo "Skipping $label: already located at target"
        return
    fi

    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to ${target}.bak"
        mv "$target" "${target}.bak"
    fi

    ln -sfn "$src" "$target"
    echo "Linked: $label -> $target"
}

for app in "${APPS[@]}"; do
    link_config "$DOTFILES_DIR/$app" "$TARGET_DIR/$app" "$app"
done

link_config "$DOTFILES_DIR/starship/starship.toml" "$TARGET_DIR/starship.toml" "starship.toml"

echo "Done linking laptop (Sway) dotfiles!"
