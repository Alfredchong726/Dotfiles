#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}
#starting utility applications at boot time
run nm-applet &
run fcitx5 &
run flameshot &
run pamac-tray &
run xfce4-power-manager &
run ./.xrandr_horizontal.sh &
numlockx off &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
eww --config $HOME/.config/conkeww/ open conkeww-main &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &

#starting user applications at boot time
run volumeicon &
nitrogen --random --set-zoom-fill --head=0 && nitrogen --random --set-zoom-fill --head=1 &
