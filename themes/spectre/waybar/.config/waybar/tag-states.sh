#!/usr/bin/env bash


export RISTATE_LOG="$HOME/ristate.log"
while true
do
    #if [[ $(pgrep -x ristate) -eq null ]]; then
    ristate -vt -t -w > $RISTATE_LOG &
    sleep 30s
    killall -q ristate
    #else
        #RISTATE_LOG_LINES=$(wc -l $RISTATE_LOG | awk '{ print $1 }')
        #[[ $RISTATE_LOG_LINES -ge 1000 ]] && killall -q ristate

done
