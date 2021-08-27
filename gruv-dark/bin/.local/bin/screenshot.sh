#!/usr/bin/env bash

p="/tmp/$(date +"%d-%m-%y-%M").png"
c=$(echo -en "Window\0icon\x1fappointment-new\nSelection\0icon\x1fimage-crop\nScreen\0icon\x1fvideo-display\n" \
	| rofi -dmenu -theme screenshot -p "")
sleep 0.2

case $c in
  "Window")
  maim -u -o -s $p
    ;;
  "Selection")
  maim -u -o -s $p
    ;;
  "Screen")
   maim -u -o $p
    ;;
  *)
    exit
    ;;
esac

xclip -selection clipboard -target image/png -i $p

notify-send "Screenshot copied to clipboard!"

