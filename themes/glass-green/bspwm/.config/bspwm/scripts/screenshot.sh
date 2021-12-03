##!/bin/bash

## options to be displayed
#option0="screen"
#option1="area"
#option2="window"

## options to be displyed
#options="$option0\n$option1\n$option2"

#selected="$(echo -e "$options" | rofi -lines 3 -dmenu -p "scrot")"
#case $selected in
#    $option0)
#        cd ~/Pictures/ && sleep 1 && scrot;;
#    $option1)
#        cd ~/Pictures/ && scrot -s;;
#    $option2)
#        cd ~/Pictures/ && sleep 1 && scrot -u;;
#esac




#!/usr/bin/env bash

p="$HOME/$(date +"%d-%m-%y-%M").png"
c=$(echo -en "Window\0icon\x1fappointment-new\nSelection\0icon\x1fimage-crop\nScreen\0icon\x1fvideo-display\n" \
	| rofi -dmenu -theme screenshot -p "")
sleep 0.2

case $c in
  "Window")
    import -window $(xwininfo | grep -Po "Window id: \K\w+") $p
    ;;
  "Selection")
    import $p 
    ;;
  "Screen")
    import -window root $p
    ;;
  *)
    exit
    ;;
esac

xclip -selection clipboard -target image/png -i $p


notify-send "Screenshot copied to clipboard!"

