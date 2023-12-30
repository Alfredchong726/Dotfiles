#!/bin/bash

function run {
	if ! pgrep $1; then
		$@ &
	fi
}

$HOME/.config/polybar/launch.sh &

run sxhkd -c ~/.config/sxhkd/sxhkdrc &
run nm-applet &
run fcitx5 &
run flameshot &
run pamac-tray &
run xfce4-power-manager &
run xrandr --output eDP1 --mode 2160x1440 --pos 1920x0 --rotate normal --output DP1 --off --output HDMI1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --off --output VIRTUAL1 --off
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
eww --config $HOME/.config/conkeww/ open conkeww-main &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
nitrogen --random --set-tiled &
