#!/usr/bin/env bash

killall -q waybar
while pgrep -x waybar >/dev/null; do sleep 1; done
waybar
