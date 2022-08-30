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
run fcitx5 &
run flameshot &
run pamac-tray &
run xfce4-power-manager &
run ./.xrandr_horizontal.sh &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
eww --config $HOME/.config/conkeww/ open conkeww-main &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
nitrogen --random --set-tiled &
