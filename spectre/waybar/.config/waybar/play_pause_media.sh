#!/usr/bin/env bash
player_status=$(playerctl -p spotify status)
if [[ $player_status = "Paused" ]]
then
    playerctl -p spotify play
elif [[ $player_status = "Playing" ]]
then
    playerctl -p spotify pause
else
    echo -e "Spotify not running"
fi

