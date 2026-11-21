# Dotfiles

Personal Linux & Termux configuration files managed via symlinks to `~/.config`.

Supports three environments from a single repository:
- **Laptop (Lenovo T480 — Manjaro + Sway):** Full desktop + C++ dev environment
- **Server (Manjaro — i3 / VNC / SSH):** Minimal i3 + C++ dev environment
- **Phone (Termux + Termux:X11 — i3):** Minimal i3 + C++ dev environment

---

## Installation

Run the install script for your target environment:

```bash
# Main laptop (T480, Sway + full suite)
./install_laptop.sh

# Manjaro server (minimal i3 + C++ dev tools)
./install_server.sh

# Smartphone (Termux + Termux:X11, minimal i3 + C++ dev tools)
./install_termux.sh
```

Configure Endorfy Thock wireless keyboard on laptop (sets `hid_apple fnmode=2` so `F1`–`F12` work as standard function keys by default):
```bash
./setup_thock_keyboard.sh
```

---

## Required & Recommended Software

### 1. Laptop — Sway (Manjaro / Arch)

```bash
sudo pacman -Syu \
  sway waybar rofi swaybg swaylock swayidle swaynag wl-clipboard cliphist grim slurp brightnessctl playerctl pavucontrol xdg-desktop-portal-wlr xfce4-settings \
  neovim ripgrep fd fzf clang cmake make gcc neocmakelsp \
  kitty lazygit yazi timewarrior zathura zathura-pdf-mupdf starship \
  ttf-jetbrains-mono-nerd

# AUR
pamac install swaysome
```

| Application / Package | Purpose |
| :--- | :--- |
| `sway` | Tiling Wayland compositor compatible with i3 syntax. |
| `swaysome` (AUR) | Multi-monitor workspace groups manager (AwesomeWM-style per-monitor workspaces). |
| `waybar` | Highly customizable GTK top status bar for Sway. |
| `rofi` | Application launcher, favorites menu, and power menu (`$mod+d`). |
| `swaybg` | Wallpaper rendering daemon on Wayland. |
| `swaylock` / `swayidle` / `swaynag` | Screen locking, idle management, and confirmation dialogs. |
| `wl-clipboard` / `cliphist` | Wayland clipboard utilities and history manager. |
| `grim` / `slurp` | Wayland screenshot capture (`Print` key) and region selection. |
| `brightnessctl` / `playerctl` / `pavucontrol` | Laptop brightness, media keys, and volume mixer. |
| `xdg-desktop-portal-wlr` | Desktop portal backend for Wayland screen sharing. |
| `xfce4-settings` | XFCE settings daemon (`xfsettingsd`) managing GTK themes, fonts, icons, and cursors. |
| `zathura` / `zathura-pdf-mupdf` | Minimalist, keyboard-driven PDF/document viewer. |

---

### 2. Server — Minimal i3 + C++ Dev Tools (Manjaro / Arch)

```bash
sudo pacman -Syu \
  i3-wm rofi feh \
  neovim ripgrep fd fzf clang cmake make gcc neocmakelsp \
  kitty lazygit yazi timewarrior starship \
  ttf-jetbrains-mono-nerd
```

> If you only connect to the server over SSH, `i3-wm`, `rofi`, and `feh` are optional; Neovim automatically uses OSC 52 for clipboard over SSH.

---

### 3. Phone — Termux + Termux:X11 + Minimal i3

```bash
pkg update && pkg upgrade
pkg install x11-repo

pkg install \
  termux-x11-nightly i3 rofi feh \
  neovim ripgrep fd fzf clang cmake make \
  kitty lazygit yazi timewarrior starship
```

> Install `JetBrainsMono Nerd Font` into `~/.local/share/fonts` (and run `fc-cache -fv`) for icons and ligatures in `i3`, `kitty`, and `nvim`.
> Optional: `neocmakelsp` can be installed via `cargo install neocmakelsp` — Neovim enables it automatically when present in `$PATH`.

---

### 4. Shared Core Tools (All Environments)

| Application / Package | Purpose |
| :--- | :--- |
| `neovim` | Modal editor configured for C/C++ (uses local system `clangd` and optional `neocmakelsp`, no Mason). |
| `ripgrep` (`rg`) / `fd` / `fzf` | Fast search and file finding backends for `fzf-lua`. |
| `clang` | C/C++ compiler toolchain providing `clangd` (LSP) and `clang-format`. |
| `cmake` / `make` / `gcc` | Build tools (`ctest` integration, Treesitter parsers, LuaSnip regex build). |
| `neocmakelsp` *(optional)* | CMake LSP server (`CMakeLists.txt` completion & diagnostics); auto-enabled when in `$PATH`. |
| `kitty` | GPU-accelerated terminal emulator with Tokyo Night theme. |
| `starship` | Cross-shell prompt with Tokyo Night Powerline theme. |
| `lazygit` | Terminal UI for Git (`<leader>gg` in Neovim). |
| `yazi` | Asynchronous terminal file manager. |
| `timewarrior` (`timew`) | Command-line time tracking tool. |
| `i3-wm` / `rofi` / `feh` | Lightweight tiling WM (built-in Tokyo Night `i3bar` with workspaces + date), launcher, and wallpaper setter for server & Termux. |
