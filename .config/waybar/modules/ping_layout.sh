#!/bin/bash

while true; do
    new_layout=$(mmsg -k | cut -d" " -f3 | head -n 1)
    
    if [ "$new_layout" != "$current_layout" ]; then
        current_layout="$new_layout"
        if [ "$current_layout" == "us" ]; then
            echo "en"
        else
            echo "<span color='#e0211f'>$current_layout</span>"
        fi
    fi
    
    sleep 1
done
