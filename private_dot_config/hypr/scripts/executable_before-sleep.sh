#!/bin/bash

hyprctl keyword monitor "eDP-1, 1920x1080@120, 0x0, 1, vrr, 1"
brightnessctl --device="asus::kbd_backlight" set 0
uwsm app -- hyprlock; hyprctl keyword monitor "desc:Huawei Technologies Co. Inc. SSN-24, disable"; sleep 3; hyprctl reload
