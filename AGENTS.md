# AGENTS.md

## Overview
This is a Linux dotfiles repository for a Hyprland-based Wayland setup. Contains configuration files for various Linux applications and tools.

## Directory Structure
- `.config/hypr/` - Hyprland compositor (window manager) config
- `.config/waybar/` - Waybar status bar config
- `.config/fish/` - Fish shell config
- `.config/kitty/` - Kitty terminal config
- `.config/rofi/` - Rofi app launcher config
- `.config/dunst/` - Dunst notification daemon config
- `.config/nvim/` - Neovim config
- `.config/yazi/` - Yazi file manager config (includes custom mount plugin)
- `.config/mango/` - Mango DE/window manager config

## Usage
Configs are meant to be symlinked or copied to `$HOME/.config/`.

## Scripts
- `restart-hyprlock.sh` - Kills and restarts hyprlock via uwsm

## mihomo / VPN via rofi

- `.config/mihomo/example.yml` — tracked sample config. The real config lives at `~/.config/mihomo/config.yml` (symlinked to `.config/mihomo/`) and is gitignored via `.config/mihomo/*` + `!example.yml`.
- `.config/systemd/user/mihomo.target`, `mihomo-base.service`, `mihomo-naive.service` — user units. Not enabled at login; started/stopped on demand from rofi. `mihomo-base` runs `/usr/bin/sudo /usr/bin/mihomo -f %h/.config/mihomo/config.yml` because TUN needs root.
- `.config/rofi/scripts/network-manager/` — `entrypoint.sh` opens the combi menu (Wi-Fi tab + VPN tab, `Tab` to switch). VPN modules live in `modules/`, and only symlinks in `enabled/` show up in the menu (`ln -s ../modules/<name>.sh enabled/<name>.sh`).
- rofi 2.0 renamed options: use `-modes` / `-combi-modes` (the old `-modi` / `-combi-mody` are silently ignored).

## Dependencies (implied by config)
- Hyprland (wayland compositor)
- Fish shell
- Waybar
- Dunst
- Kitty
- Rofi
- Neovim
- Yazi
- UWSM (for starting wayland sessions)
- udisksctl + lsblk (for yazi mount plugin)