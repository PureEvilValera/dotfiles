#!/bin/bash

mmsg watch keyboardlayout 2>/dev/null | while IFS= read -r line; do
    layout=${line#*\"layout\":\"}
    layout=${layout%%\"*}

    case "$layout" in
        English*|english*|US|us)
            echo "en"
            ;;
        Russian*|russian*|RU|ru)
            echo "<span color='#e0211f'>ru</span>"
            ;;
        *)
            echo "$layout"
            ;;
    esac
done
