#!/bin/bash

msgId="3378455"

brightnessctl "$@" >/dev/null

brightpercent=$(brightnessctl -m --device='amdgpu_bl1' | awk -F, '{print substr($4, 0, length($4)-1)}')

notify-send -i $HOME/.config/hypr/scripts/dunst/icons/brightness.svg -a "changeBrightness" -u low -r "$msgId" \
  -h int:value:"$brightpercent" "Яркость экрана: $brightpercent%"
