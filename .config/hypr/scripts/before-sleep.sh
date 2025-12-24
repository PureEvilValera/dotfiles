#!/bin/bash

wlr-randr --output eDP-1 --on 
wlr-randr --output HDMI-A-1 --off
brightnessctl --device="asus::kbd_backlight" set 0
uwsm app -- hyprlock
