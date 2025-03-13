#!/bin/bash
# dunstBright

msgId="3378455"

brightnessctl "$@" > /dev/null

#for brightnessctl
#brightpercent=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')

brightpercent=$(ddcutil -d 1 getvcp 10 | sed 's/^.*current value =    //' | sed 's/, max.*//')


dunstify -i $HOME/.config/hypr/scripts/dunst/icons/brightness.svg -a "changeBrightness" -u low -r "$msgId" \
	-h int:value:"$brightpercent" "Яркость экрана: $brightpercent%"
