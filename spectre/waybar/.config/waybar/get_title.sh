#!/usr/bin/env bash

title=$(tail -1 $HOME/ristate.log | jq '.title' -r)

if [[ "$title" = "" ]]; then
	echo -e "${USER} in ${HOSTNAME}"
else
	echo -e "$title"
fi
