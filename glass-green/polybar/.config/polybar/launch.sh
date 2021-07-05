#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs kill

killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars :D
polybar -c ~/.config/polybar/config.ini main -r &

polybar -c ~/.config/polybar/config.ini systray -r &




# while ! pgrep -x polybar >/dev/null; do sleep 1; done
sleep 1

hideIt.sh --name '^Polybar tray window$' --region 0x0+20+-40  --peek 1 -d left -i 0.2  & 
hideIt.sh --name '^polybar-main_eDP$' -H --peek 4 -d bottom -i 0.1 &

sleep 6
# while ! pgrep -x polybar >/dev/null; do sleep 1; done
xdo raise -N Polybar 



