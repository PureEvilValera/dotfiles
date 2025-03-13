#!/bin/bash
# dunstBright

msgId="3378455"

station=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | sed 's/Volume://' | tr -d [:digit:] | tr -d ' .[]')

if [ $station = 'MUTED' ]
then
	dunstify -i "$HOME/.config/hypr/scripts/dunst/icons/mic off.svg" -u low -r "$msgId" "Микрофон выключен"
else
	dunstify -i "$HOME/.config/hypr/scripts/dunst/icons/mic on.svg" -u low -r "$msgId" "Микрофон включен"
fi
