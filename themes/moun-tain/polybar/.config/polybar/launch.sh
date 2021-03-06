#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs kill

echo "########################################################################"
echo "hideIt killed"

killall -q polybar
echo "########################################################################"
echo "polybars killed"

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch all bars :D

polybar -c ~/.config/polybar/config.ini systray -r &
echo "########################################################################"
echo "systray launched"
polybar -c ~/.config/polybar/config.ini sub -r &
polybar -c ~/.config/polybar/config.ini main -r &
echo "########################################################################"
echo "main and sub bar launched"
hideIt.sh --name '^Polybar tray window$' -w --region 0x1060+55+25  --peek 35 -d left -i 0.1 & 
xdo raise -a "Polybar tray window"
echo "########################################################################"
echo "hiding systray "


sleep 6
while ! pgrep -x polybar >/dev/null; do sleep 1; done
xdo raise -a "polybar-sub_eDP"

# hideIt.sh --name '^polybar-sub_eDP$' -w --region 0x1060+1920+20 --peek 2 -d bottom -i 0.2   & 
hideIt.sh --name '^polybar-sub_eDP$' -w  --peek 4 -d top -i 1  --hover & 
# echo "########################################################################"
echo "hiding bottom bar "


# hideIt.sh --name '^polybar-main_eDP$' -H --peek 6 -d top -i 0.1 &
# echo "########################################################################"
# echo "hiding main bar "


# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# while ! pgrep -x polybar >/dev/null; do sleep 1; done
xdo raise -a "polybar-sub_eDP"
xdo raise -a "Polybar tray window"
# xdo raise -a "polybar-main_eDP"
echo "########################################################################"
echo "raised bar"

