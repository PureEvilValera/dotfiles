#!/bin/bash

$HOME/.config/hypr/scripts/rog.sh
sleep 10
if journalctl --since="30 seconds ago" | grep "connector HDMI-A-1: Atomic commit failed"; then
  $HOME/restart-hyprlock.sh
fi
