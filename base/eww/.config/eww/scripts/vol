#!/bin/bash

getmic() {
    amixer -D pulse get Capture | grep 'Left:'| cut -d '[' -f 2 | cut -d ']' -f 1 | sed 's/%/ /g'
}

getvol() {
    amixer -D pulse get Master | grep 'Left:'| cut -d '[' -f 2 | cut -d ']' -f 1 | sed 's/%/ /g'
}

getvolstats() {
    if [[ $(getvol) -le 0 ]]; then
        echo ""
    elif [[ $(getvol) -le 25 ]]; then
        echo ""
    elif [[ $(getvol) -le 100 ]]; then
        echo ""
    fi
}

case $1 in
    vol)
        echo $(getvol)
        ;;
    mic)
        echo $(getmic)
        ;;
    stats)
        getvolstats
        ;;
esac
