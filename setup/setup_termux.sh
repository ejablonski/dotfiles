#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_DIR="$HOME/.local/bin"

mkdir -p "$TARGET_DIR" "$BIN_DIR"

APPS=(
    i3
    rofi
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

# Link Termux utility & launcher scripts into ~/.local/bin (without .sh suffix)
for script in "$DOTFILES_DIR"/scripts/termux/*.sh; do
    [ -f "$script" ] || continue
    name="$(basename "$script" .sh)"
    link_config "$script" "$BIN_DIR/$name" "script:$name"
done

case ":$PATH:" in
    *":$BIN_DIR:"*) ;;
    *)
        echo ""
        echo "Note: $BIN_DIR is not in your PATH."
        echo "Add the following line to your ~/.bashrc:"
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
        ;;
esac

echo "Done setting up Termux (+ Termux:X11 + i3) dotfiles and scripts!"
