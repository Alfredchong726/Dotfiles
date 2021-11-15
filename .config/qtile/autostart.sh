#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}
#starting utility applications at boot time
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
run ./.xrandr-ext-mon &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
conky -c ~/.config/conky/qtile/monokai-pro-01.conkyrc &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
run volumeicon &
nitrogen --random --set-tiled &
