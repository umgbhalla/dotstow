#!/bin/env bash

# Options for powermenu
lock="   Lock"
logout="   Logout"
shutdown="   Shutdown"
reboot="    Reboot"
sleep="   Sleep"

# Get answer from user via rofi
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | fzf )

# Do something based on selected option
if [ "$selected_option" == "$lock" ]
then
  /home/$USER/.config/bspwm/scripts/i3lock-fancy/i3lock-fancy.sh
elif [ "$selected_option" == "$logout" ]
then
  ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs killall
  bspc quit
  pkill touchegg
elif [ "$selected_option" == "$shutdown" ]
then
  systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
  systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
  amixer set Master mute
  systemctl hybrid-sleep
else
  echo "No match"
fi
