# Dotfiles

Personal Linux & Termux configuration files managed via symlinks to `~/.config`.

Supports three environments from a single repository:
- **Laptop (Lenovo T480 — Manjaro + Sway):** Full desktop + C++ dev environment
- **Server (Manjaro — i3 / VNC / SSH):** Minimal i3 + C++ dev environment
- **Phone (Termux + Termux:X11 — i3):** Minimal i3 + C++23 dev environment

---

## Repository Structure

- `<app>/` — Application configuration directories (`nvim`, `sway`, `i3`, `kitty`, `rofi`, `starship`, `waybar`, `yazi`, `lazygit`, `timewarrior`, `xfce4`, `zathura`)
- `setup/` — Per-device symlink setup scripts (`setup_*.sh`), post-install package scripts (`packages_*.sh`), and hardware setup (`setup_thock_keyboard.sh`)
- `scripts/` — Device-specific utility and launcher scripts (e.g., `scripts/termux/` for `Termux:X11`, `i3`, and `box64`/`Wine` launchers)

---

## Setup & Installation

### 1. Install Packages (Post-Install)

Run the package installation script for your target device:

```bash
# Main laptop (Manjaro / Arch, Sway + full suite)
./setup/packages_laptop.sh

# Manjaro server (minimal i3 + C++ dev tools; add --headless for SSH-only)
./setup/packages_server.sh
./setup/packages_server.sh --headless

# Smartphone (Termux + Termux:X11, minimal i3 + C++23 dev tools; add --headless for CLI-only)
./setup/packages_termux.sh
```

### 2. Link Dotfiles & Scripts

```bash
# Main laptop (T480, Sway + full suite)
./setup/setup_laptop.sh

# Manjaro server (minimal i3 + C++ dev tools)
./setup/setup_server.sh

# Smartphone (Termux: links ~/.config dotfiles and scripts/termux/*.sh -> ~/.local/bin)
./setup/setup_termux.sh
```

Configure Endorfy Thock wireless keyboard on laptop (sets `hid_apple fnmode=2` so `F1`–`F12` work as standard function keys by default):
```bash
./setup/setup_thock_keyboard.sh
```

---

## Required & Recommended Software

### 1. Laptop — Sway (Manjaro / Arch)

Installed via `./setup/packages_laptop.sh`:

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

Installed via `./setup/packages_server.sh` (pass `--headless` on SSH-only servers to skip `i3-wm`, `rofi`, `feh`, `kitty`, and fonts; Neovim automatically uses OSC 52 for clipboard over SSH).

---

### 3. Phone — Termux + Termux:X11 + Minimal i3

> **Recommended Termux install source:** Use **GitHub Releases** (`termux/termux-app`) or **F-Droid** rather than the Google Play Store build to avoid Android W^X (`targetSdkVersion >= 29`) execution restrictions. If using `Termux:X11`, the **GitHub Releases** build also supports `termux-x11-universal-sharedUid-release.apk` so Android does not throttle Termux CPU cores while `Termux:X11` is in the foreground.

Installed via `./setup/packages_termux.sh`:
- Enables `x11-repo` and `tur-repo`
- Installs C++23 toolchain: `clang` (`clangd`, `clang-format`, `lld`), `gcc-15` + `gcc-default` (from `tur-repo`), `cmake`, `make`, `ninja`, `ccache`, `gdb`, `pkg-config`, `neocmakelsp`, `tree-sitter`
- Installs X11/desktop/GPU stack: `termux-x11-nightly`, `i3`, `rofi`, `feh`, `kitty`, `dbus`, `pulseaudio`, `mesa`, `mesa-vulkan-icd-freedreno` (Turnip + Zink for Adreno), `fontconfig`
- Installs core CLI/editor tools: `neovim`, `ripgrep`, `fd`, `fzf`, `lazygit`, `yazi`, `timewarrior`, `starship`, `git`, `openssh`

> Install `JetBrainsMono Nerd Font` into `~/.local/share/fonts` (and run `fc-cache -fv`) for icons and ligatures in `i3`, `kitty`, and `nvim`.

#### Termux Scripts (`scripts/termux/`)

`./setup/setup_termux.sh` links each `scripts/termux/*.sh` script into `~/.local/bin` (without the `.sh` suffix):

| Script | Command | Purpose |
| :--- | :--- | :--- |
| `scripts/termux/start_i3.sh` | `start_i3` | Starts PulseAudio, Turnip+Zink GPU acceleration, `Termux:X11 :1`, and native `i3` (with pre-flight health check & log). |
| `scripts/termux/start_steam_direct.sh` | `start_steam_direct` | Starts PulseAudio + `Termux:X11 :1`, runs pre-flight checks, and launches Steam directly via `gwine`. |
| `scripts/termux/start_quake.sh` | `start_quake` | Starts `Termux:X11` + `i3` and launches Quake (`classic` or rerelease) via `gwine`. |
| `scripts/termux/steam.sh` | `steam` | Minimal `gwine` Steam launcher. |
| `scripts/termux/steam_debug.sh` | `steam_debug` | Restarts Wine/Steam with `WINEESYNC=0 WINEFSYNC=0` for debugging. |

---

### 4. Shared Core Tools (All Environments)

| Application / Package | Purpose |
| :--- | :--- |
| `neovim` | Modal editor configured for C/C++ (uses local system `clangd` and optional `neocmakelsp`, no Mason). |
| `ripgrep` (`rg`) / `fd` / `fzf` | Fast search and file finding backends for `fzf-lua`. |
| `clang` / `gcc` | C/C++ compiler toolchains providing `clangd` (LSP), `clang-format`, and C++23 support (`gcc-15` via `tur-repo` on Termux). |
| `cmake` / `ninja` / `make` / `ccache` / `gdb` | Build, caching, and debugging tools (`ctest` integration, Treesitter parsers, LuaSnip regex build). |
| `neocmakelsp` *(optional)* | CMake LSP server (`CMakeLists.txt` completion & diagnostics); auto-enabled when in `$PATH`. |
| `kitty` | GPU-accelerated terminal emulator with Tokyo Night theme. |
| `starship` | Cross-shell prompt with Tokyo Night Powerline theme. |
| `lazygit` | Terminal UI for Git (`<leader>gg` in Neovim). |
| `yazi` | Asynchronous terminal file manager. |
| `timewarrior` (`timew`) | Command-line time tracking tool. |
| `i3-wm` / `rofi` / `feh` | Lightweight tiling WM (built-in Tokyo Night `i3bar` with workspaces + date), launcher, and wallpaper setter for server & Termux. |
