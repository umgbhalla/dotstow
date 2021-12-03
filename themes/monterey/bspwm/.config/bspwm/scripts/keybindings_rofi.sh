#!/usr/bin/env bash

awk '/^[a-z]/ && last {print "<small>",$0,"\t",last,"</small>"} {last=""} /^#/{last=$0}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -p "keybindings:" -markup-rows \
	-no-show-icons \
	-width 26 \
	-lines 14 \
	-padding 20
