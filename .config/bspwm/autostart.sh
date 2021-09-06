#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

$HOME/.config/polybar/launch.sh &

run sxhkd -c ~/.config/sxhkd/sxhkdrc &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
nitrogen --random --set-tiled &
