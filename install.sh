#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

mkdir -p "$TARGET_DIR"

for src in "$DOTFILES_DIR"/*/; do
    [ -d "$src" ] || continue

    app_name="$(basename "$src")"

    # Skip hidden directories (starting with a dot, e.g., .git)
    if [[ "$app_name" == .* ]]; then
        continue
    fi

    src="${src%/}"
    target="$TARGET_DIR/$app_name"

    # Skip if source and target refer to the exact same directory
    if [ "$src" -ef "$target" ]; then
        echo "Skipping $app_name: already located at target"
        continue
    fi

    # If target exists and is NOT a symlink, back it up
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target to ${target}.bak"
        mv "$target" "${target}.bak"
    fi

    # Create / update symbolic link
    ln -sfn "$src" "$target"
    echo "Linked: $app_name -> $target"
done

# Handle starship.toml at the root of ~/.config
if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
    ln -sfn "$DOTFILES_DIR/starship/starship.toml" "$TARGET_DIR/starship.toml"
    echo "Linked: starship.toml -> $TARGET_DIR/starship.toml"
fi

echo "Done linking child directories!"
