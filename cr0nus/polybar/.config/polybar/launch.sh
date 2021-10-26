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
echo "########################################################################"
echo "sub bar launched"
polybar -c ~/.config/polybar/config.ini main -r &
echo "########################################################################"
echo "main bar launched"



# hiding some bars
hideIt.sh --name '^polybar-sub_eDP$' -w  --peek 4 -d top -i 1  --hover & 
echo "########################################################################"
echo "hiding sub bar "
hideIt.sh --name '^polybar-main_eDP$' -w  --peek 4 -d bottom -i 1  --hover & 
echo "########################################################################"
echo "hiding main bar "
hideIt.sh --name '^Polybar tray window$' -w --region 0x1060+55+25  --peek 35 -d left -i 0.1 & 
echo "########################################################################"
echo "hiding systray "


# Wait wait until all bars are loaded and hidden
while ! pgrep -x polybar >/dev/null; do sleep 1; done

# just making sure
sleep 6
# Raise all bars
xdo raise -a "polybar-main_eDP"
xdo raise -a "polybar-sub_eDP"
xdo raise -a "Polybar tray window"
echo "########################################################################"
echo "raised all bars"
