#!/usr/bin/env sh
## Add this to your wm startup file.


# Terminate already running bar instances
ps -ef | grep hideIt | grep -v grep | awk '{print $2}' | xargs kill
echo "########################################################################"
notify-send "hideIt killed"
killall -q polybar
echo "########################################################################"
notify-send "polybars killed"
# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



# Launch all bars :D
polybar -c ~/.config/polybar/config.ini main -r &
echo "########################################################################"
notify-send "main bar launched"
polybar -c ~/.config/polybar/config.ini sub -r &
echo "########################################################################"
notify-send "sub bar launched"
polybar -c ~/.config/polybar/config.ini systray -r &
echo "########################################################################"
notify-send "systray launched"


xdo raise -a "Polybar tray window"
xdo raise -a "polybar-sub_eDP"
xdo raise -a "polybar-main_eDP-1"


sleep 3
# # hiding some bars
hideIt.sh --name '^polybar-sub_eDP-1$' -w  --peek 4 -d top -i 1  --hover &
echo "########################################################################"
# notify-send "hiding sub bar "
hideIt.sh --name '^polybar-main_eDP-1$' -w  --peek 4 -d bottom -i 1  --hover &
# echo "########################################################################"
# echo "hiding main bar "
hideIt.sh --name '^Polybar tray window$' -w --region 0x1060+55+55  --peek 4 -d bottom -i 0.1 &
# hideIt.sh --name '^Polybar tray window$' -w  --peek 4 -d bottom -i 0.1 --hover &
echo "########################################################################"
# notify-send "hiding systray "


# Wait wait until all bars are loaded and hidden

while ! pgrep -x polybar >/dev/null; do sleep 1; done
# just making sure
sleep 20



# Raise all bars
xdo raise -a "Polybar tray window"
xdo raise -a "polybar-sub_eDP-1"
xdo raise -a "polybar-main_eDP-1"

echo "########################################################################"
notify-send " raised all bars"

xdo raise -a "polybar-sub_eDP-1"
