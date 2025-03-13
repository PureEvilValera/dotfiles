#!/bin/bash

asusctl profile -n

dunstify -i $HOME/.config/hypr/scripts/dunst/icons/performance.svg -u low -r "3378455" "$(asusctl profile -p | sed 's/^.*is //')"

