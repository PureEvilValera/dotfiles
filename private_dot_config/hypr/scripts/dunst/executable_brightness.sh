#!/bin/bash

msgId="3378455"

brightnessctl "$@" >/dev/null

brightpercent=$(ddcutil -d 1 getvcp 10 | sed 's/^.*current value =    //' | sed 's/, max.*//')

dunstify -i $HOME/.config/hypr/scripts/dunst/icons/brightness.svg -a "changeBrightness" -u low -r "$msgId" \
  -h int:value:"$brightpercent" "Яркость экрана: $brightpercent%"
