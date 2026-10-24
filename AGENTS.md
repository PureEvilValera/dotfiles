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