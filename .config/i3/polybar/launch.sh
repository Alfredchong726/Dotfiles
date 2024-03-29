#!/usr/bin/env bash

# Add this script to your wm startup file.
DIR="$HOME/.config/i3/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar -q top -c "$DIR"/config.ini & 
    MONITOR=$m polybar -q bottom -c "$DIR"/config.ini &

  done
else
polybar --reload mainbar-i3 -c ~/.config/polybar/config &
fi

# IPC settings and test
ln -sf /tmp/polybar_mqueue.$! /tmp/ipc-main
echo message >/tmp/ipc-main
