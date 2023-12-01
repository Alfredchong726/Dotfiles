from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from extras import float_to_front
from utils import config

mod, alt = "mod4", "mod1"
terminal = config["terminal"]

myTerm = 'alacritty'

if not terminal["main"]:
    terminal["main"] = guess_terminal()

keys = [Key(*key) for key in [  # type: ignore
    ### Application
    ([mod], "Return", lazy.spawn(myTerm),),
    ([mod], "y", lazy.spawn('audacious'),),
    ([mod], "o", lazy.spawn('wps'),),
    ([mod], "t", lazy.spawn('xfce4-task-manager'),),
    ([mod], "d", lazy.spawn('thunar'),),
    ([mod], "v", lazy.spawn('virt-manager'),),
    ([mod], "w", lazy.spawn('whatsapp-for-linux'),),
    ([mod], "a", lazy.spawn('pavucontrol'),),
    ([mod], "x", lazy.spawn('archlinux-logout'),),
    ([mod, "shift"], "Return", lazy.spawn("rofi -show run"),),
    ([mod, "shift"], "o", lazy.spawn("obsidian"),),
    ([mod, "shift"], "t", lazy.spawn("teams"),),
    ([mod, "shift"], "c", lazy.spawn("./alchanger.sh"),),
    ([mod, "Escape"], "xkill", lazy.spawn("teams"),),
    ([mod, "shift"], "t", lazy.spawn(dm),),
### QTILE Function
    ([mod], "Tab", lazy.next_layout(),),
    ([mod], "q", lazy.window.kill(),),
    ([mod, "shift"], "r", lazy.restart(),),
    ([mod, "shift"], "q", lazy.shutdown(),),
    ([mod, "shift"], "s", lazy.spawn(myTerm+" -e shutdown now"),),
    ([mod, "control"], "r", lazy.spawn(myTerm+" -e reboot"),),
    ### Switch focus to specific monitor (out of three)
    ([mod], "w", lazy.to_screen(0),),
    ([mod], "e", lazy.to_screen(1),),
    ([mod], "r", lazy.to_screen(2),),
    ### Switch focus of monitors
    ([mod], "period", lazy.next_screen(),),
    ([mod], "comma", lazy.prev_screen(),),
    ### Treetab controls
    ([mod, "shift"], "h", lazy.layout.move_left(),),
    ([mod, "shift"], "l", lazy.layout.move_right(),),
    ### Window controls
    ([mod], "j", lazy.layout.down(),),
    ([mod], "k", lazy.layout.up(),),
    ([mod, "shift"], "j", lazy.layout.shuffle_down(), lazy.layout.section_down(),),
    ([mod, "shift"], "k", lazy.layout.shuffle_up(), lazy.layout.section_up(),),
    ([mod], "h", lazy.layout.shrink(), lazy.layout.decrease_nmaster(),),
    ([mod], "l", lazy.layout.grow(), lazy.layout.increase_nmaster(),),
    ([mod], "n", lazy.layout.normalize(),),
    ([mod], "m", lazy.layout.maximize(),),
    ([mod, "shift"], "f", lazy.window.toggle_floating(),),
    ([mod], "f", lazy.window.toggle_fullscreen(),),
    ### Stack controls
    ([mod, "shift"], "Tab", lazy.layout.rotate(), lazy.layout.flip(),),
    ([mod], "space", lazy.layout.next(),),
    ([mod, "shift"], "space", lazy.layout.toggle_split()),
    # switch between windows
    ([mod], "h", lazy.layout.left()),
    ([mod], "l", lazy.layout.right()),
    ([mod], "j", lazy.layout.down()),
    ([mod], "k", lazy.layout.up()),

    # move windows between columns
    ([mod, "shift"], "h", lazy.layout.shuffle_left()),
    ([mod, "shift"], "l", lazy.layout.shuffle_right()),
    ([mod, "shift"], "j", lazy.layout.shuffle_down()),
    ([mod, "shift"], "k", lazy.layout.shuffle_up()),

    # increase/decrease window size
    ([mod], "i", lazy.layout.grow()),
    ([mod], "m", lazy.layout.shrink()),

    # window management
    ([mod, "shift"], "space", lazy.layout.flip()),
    ([mod], "o", lazy.layout.maximize()),
    ([mod], "n", lazy.layout.normalize()),
    ([mod], "a", lazy.window.kill()),
    ([], "F11", lazy.window.toggle_fullscreen()),

    # floating window management
    ([mod], "space", lazy.window.toggle_floating()),
    ([mod], "c", lazy.window.center()),
    ([mod], "f", lazy.function(float_to_front)),

    # toggle between layouts
    ([mod], "Tab", lazy.next_layout()),

    # qtile stuff
    ([mod, "control"], "b", lazy.hide_show_bar()),
    ([mod, "control"], "s", lazy.shutdown()),
    ([mod, "control"], "r", lazy.reload_config()),
    ([mod, alt], "r", lazy.restart()),

    # kill x11 session
    ([mod, alt], "s", lazy.spawn("kill -9 -1")),

    # terminal
    ([mod], "Return", lazy.spawn(terminal["main"])),
    ([mod, "shift"], "Return", lazy.spawn(terminal["floating"])),

    # app launcher
    ([mod, "shift"], "r", lazy.spawn("rofi -show window")),
    ([mod], "r", lazy.spawn("rofi -show drun")),

    # web browser
    ([mod], "b", lazy.spawn(config["browser"])),

    # screenshot tool
    ([], "Print", lazy.spawn("gnome-screenshot -i")),

    # backlight
    ([mod], "XF86AudioLowerVolume", lazy.spawn("brightnessctl set 5%-")),
    ([mod], "XF86AudioRaiseVolume", lazy.spawn("brightnessctl set +5%")),

# Media
    ([], "XF86AudioRaiseVolume", lazy.spawn("python .config/scripts/notify-main.py volume inc 5")),
    (["shift"], "XF86AudioRaiseVolume", lazy.spawn("python .config/scripts/notify-main.py volume set 70")),
    ([], "XF86AudioLowerVolume", lazy.spawn("python .config/scripts/notify-main.py volume dec 5")),
    (["shift"], "XF86AudioLowerVolume", lazy.spawn("python .config/scripts/notify-main.py volume set 20")),
    ([], "XF86AudioMute", lazy.spawn("python .config/scripts/notify-main.py volume set toggle")),
    ([], "XF86AudioPlay", lazy.spawn("sh .config/scripts/notify-song.sh play")),
    (["shift"], "XF86AudioPlay", lazy.spawn("systemctl --user stop mpd")),
    ([], "XF86AudioNext", lazy.spawn("sh .config/scripts/notify-song.sh next")),
    ([], "XF86AudioPrev", lazy.spawn("sh .config/scripts/notify-song.sh prev")),

    # player
    ([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    ([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    ([], "XF86AudioNext", lazy.spawn("playerctl next")),
]]  # fmt: skip
