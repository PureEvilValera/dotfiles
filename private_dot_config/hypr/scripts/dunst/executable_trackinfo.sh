
#!/bin/bash
# dunstBright

sleep 0.7

msgId="3378455"

artist=$(playerctl metadata artist)
title=$(playerctl metadata title)
image=$(playerctl metadata mpris:artUrl)

dunstify -u low -r "$msgId" "$artist" "$title" -i "$image"
