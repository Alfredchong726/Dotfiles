function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run nm-applet &
run pamac-tray &
run xfce4-power-manager &
run volumeicon &
run ./.xrandr-ext-mon &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/picom/picom.conf &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
nitrogen --random --set-tiled &
