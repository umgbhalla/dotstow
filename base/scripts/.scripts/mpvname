#!/bin/sh

if [[ $(pidof mpv) ]]; then
	METADATA=$(echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | awk -F '"' '{print $4}')
	echo "$METADATA"
    else
	    exit
fi
