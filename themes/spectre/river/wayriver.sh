#!/usr/bin/env bash

export XDG_CURRENT_DESKTOP=river
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export _JAVA_AWT_WM_NONREPARENTING=1
# export XCURSOR_THEME=Breeze_Obsidian
export XCURSOR_THEME=Oreo_Grey_Cursors

# Runtime Directory
#if test -z "${XDG_RUNTIME_DIR}"; then
	#export XDG_RUNTIME_DIR=/tmp/`id -u`-runtime-dir
	#if ! test -d "${XDG_RUNTIME_DIR}"; then
		#mkdir "${XDG_RUNTIME_DIR}"
		#chmod 0700 "${XDG_RUNTIME_DIR}"
	#fi
#fi

# Start river
exec dbus-launch river
