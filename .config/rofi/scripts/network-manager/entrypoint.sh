#!/bin/bash
dir=$(dirname "$0")
rofi -combi-modes " "," " -modes " ":$dir/network-manager.sh," ":$dir/vpn-manager.sh -show " "
