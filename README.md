# Dotfiles

Personal Linux configuration files managed via symlinks to `~/.config`.

## Installation

Symlink all configuration directories to your `$HOME/.config`:
```bash
./install.sh
```

---

## Required & Recommended Software

The configurations in this repository depend on the following applications, categorized by domain. You can install each group individually using the provided `pacman` commands.

### 1. Sway (Wayland Desktop)

```bash
sudo pacman -Syu sway waybar rofi swaybg swaylock swayidle swaynag wl-clipboard cliphist grim slurp brightnessctl playerctl pavucontrol xdg-desktop-portal-wlr xfce4-settings
pamac install swaysome
```

| Application / Package | Purpose |
| :--- | :--- |
| `sway` | Tiling Wayland compositor compatible with i3 syntax. |
| `swaysome` (AUR) | Multi-monitor workspace groups manager (AwesomeWM-style per-monitor workspaces). |
| `waybar` | Highly customizable GTK top status bar for Sway. |
| `rofi` | Application launcher, favorites menu, and power menu (`$mod+d`). |
| `swaybg` | Wallpaper rendering daemon on Wayland. |
| `swaylock` | Screen locking utility. |
| `swayidle` | Idle management daemon for inactivity lock and display power-off. |
| `swaynag` | Shows interactive warning and confirmation prompts (e.g., exit session). |
| `wl-clipboard` | Wayland clipboard command-line utilities (`wl-copy`, `wl-paste`). |
| `cliphist` | Wayland clipboard history manager used with `wl-paste`. |
| `grim` | Screen grabber utility for taking screenshots (`Print` key). |
| `slurp` | Interactive region selection utility companion for `grim`. |
| `brightnessctl` | Laptop display brightness controller for hardware keys. |
| `playerctl` | Media controller for hardware media keys (play/pause/next). |
| `pavucontrol` | GUI volume mixer invoked by right-clicking Waybar volume. |
| `xdg-desktop-portal-wlr` | Desktop portal backend for Wayland screen sharing and OBS/WebRTC. |
| `xfce4-settings` | XFCE settings daemon (`xfsettingsd`) managing GTK themes, fonts, icons, and cursors. |

---

### 2. i3 (X11 Desktop)

```bash
sudo pacman -Syu i3-wm polybar rofi feh i3lock xss-lock dex network-manager-applet pulseaudio xorg-xrandr bluez-utils xfce4-settings
```

| Application / Package | Purpose |
| :--- | :--- |
| `i3-wm` | Tiling window manager for X11 sessions. |
| `polybar` | Fast, lightweight modular status bar for X11. |
| `rofi` | Application launcher and window switcher for X11 (`$mod+d`). |
| `feh` | Fast image viewer used to set X11 desktop wallpaper. |
| `i3lock` | Screen locker for X11 sessions. |
| `xss-lock` | Listens to logind sleep/suspend events to invoke the lock screen. |
| `dex` | Launches XDG autostart `.desktop` files in i3. |
| `network-manager-applet` | NetworkManager system tray applet (`nm-applet`) for Wi-Fi management. |
| `pulseaudio` | Sound server providing `pactl` for volume control. |
| `xorg-xrandr` | Multi-monitor detection used by the Polybar launcher. |
| `bluez-utils` | Provides `bluetoothctl` used for Bluetooth status in status bars. |
| `xfce4-settings` | XFCE settings daemon (`xfsettingsd`) managing GTK themes, fonts, icons, and cursors. |

---

### 3. Neovim (Editor)

```bash
sudo pacman -Syu neovim ripgrep fd fzf clang cmake make gcc
```

| Application / Package | Purpose |
| :--- | :--- |
| `neovim` | Extensible modal text editor (`nvim`). |
| `ripgrep` (`rg`) | Fast recursive text search engine used by `fzf-lua` live grep. |
| `fd` | Fast directory traversing tool used by `fzf-lua` file searches. |
| `fzf` | General-purpose command-line fuzzy finder. |
| `clang` | C/C++ compiler toolchain providing `clangd` (LSP) and `clang-format`. |
| `cmake` | Build system generator providing `ctest` integration. |
| `make` / `gcc` | Build tools needed to compile Treesitter parsers and LuaSnip regex extensions. |

---

### 4. Terminal & Document Tools

```bash
sudo pacman -Syu kitty lazygit yazi timewarrior zathura zathura-pdf-mupdf starship
```

| Application / Package | Purpose |
| :--- | :--- |
| `kitty` | Fast, GPU-accelerated terminal emulator. |
| `starship` | Fast, customizable cross-shell prompt configured with Tokyo Night Powerline theme. |
| `lazygit` | Terminal UI for Git version control (`<leader>gg` in Neovim). |
| `yazi` | High-performance asynchronous terminal file manager. |
| `timewarrior` (`timew`) | Command-line time tracking tool integrated into Polybar and Waybar. |
| `zathura` | Minimalist, keyboard-driven document and PDF viewer. |
| `zathura-pdf-mupdf` | Fast MuPDF rendering engine backend for Zathura. |

---

### 5. System & Appearance

```bash
sudo pacman -Syu ttf-jetbrains-mono-nerd
```

| Application / Package | Purpose |
| :--- | :--- |
| `ttf-jetbrains-mono-nerd` | Primary font providing programming ligatures and UI icons across all tools. |

---

### Full System Bootstrap

To install all packages for both Sway and i3 environments at once:
```bash
# Official Repositories
sudo pacman -Syu \
  sway waybar rofi swaybg swaylock swayidle swaynag wl-clipboard cliphist grim slurp brightnessctl playerctl pavucontrol xdg-desktop-portal-wlr \
  i3-wm polybar feh i3lock xss-lock dex network-manager-applet pulseaudio xorg-xrandr bluez-utils \
  neovim ripgrep fd fzf clang cmake make gcc \
  kitty lazygit yazi timewarrior zathura zathura-pdf-mupdf starship \
  ttf-jetbrains-mono-nerd xfce4-settings

# AUR Packages
pamac install swaysome
```
