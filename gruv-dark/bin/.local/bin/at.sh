#!/bin/bash

xdotool search --sync 10 --limit 1 --class Rofi keyup --delay 0 Tab key --delay 0 Tab &

rofi \
  -theme ~/.config/rofi/Iceburg.rasi \
  -show window -show-icons -window-thumbnail  \
  -kb-cancel "Alt+Escape,Escape" \
  -kb-accept-entry "!Alt-Tab,!Alt+Right,!Alt+Left,Return"\
  -kb-row-down "Alt+Tab,Alt+Right" \
  -kb-row-up "Alt+Shift+Tab,Alt+Left"
