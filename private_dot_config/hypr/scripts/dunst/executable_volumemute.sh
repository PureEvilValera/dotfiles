#!/bin/bash
# dunstBright

msgId="3378455"

station=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume://' | tr -d [:digit:] | tr -d ' .[]')

if [ $station = 'MUTED' ]
then
	dunstify -i "$HOME/.config/hypr/scripts/dunst/icons/volume mute.svg" -u low -r "$msgId" "Звук выключен"
else
	dunstify -i "$HOME/.config/hypr/scripts/dunst/icons/volume.svg" -u low -r "$msgId" "Звук включен"
fi
