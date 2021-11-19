import os
import re
import socket
import subprocess
from typing import List  # noqa: F401
from libqtile import backend, layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, Rule
from libqtile.command import lazy
from libqtile.widget import Spacer
#import arcobattery

#mod4 or mod = super key
mod = "mod4"
mod1 = "alt"
mod2 = "control"
home = os.path.expanduser('~')
myTerm = 'alacritty'
color_alert = '#ee9900'

@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i + 1].name)

keys = [

# Most of our keybindings are in sxhkd file - except these

# SUPER + FUNCTION KEYS

    # SPAWN APPLICATIONS
    Key([mod], "f", lazy.spawn('firefox')),
    Key([mod], "Return", lazy.spawn(myTerm)),
    Key([mod], "y", lazy.spawn("deadbeef")),
    Key([mod], "n", lazy.spawn("nitrogen")),
    Key([mod], "c", lazy.spawn("galculator")),
    Key([mod], "o", lazy.spawn("wps")),
    Key([mod], "t", lazy.spawn("xfce4-taskmanager")),
    Key([mod], "d", lazy.spawn("thunar")),
    Key([mod], "v", lazy.spawn("VirtualBox")),
    Key([mod], "w", lazy.spawn("whatsapp-for-linux")),
    Key([mod], "a", lazy.spawn("pavucontrol")),
    Key([mod], "x", lazy.spawn("arcolinux-logout")),
    Key([mod, 'shift'], "o", lazy.spawn("obsidian-insider")),
    Key([mod, "shift"], "t", lazy.spawn("teams-for-linux")),
    Key([mod, "shift"], "c", lazy.spawn("./alchanger.sh")),
    Key([mod, "shift"], "Return", lazy.spawn("rofi -show run")),
    Key([mod, "shift"], "w", lazy.spawn("rofi -show window")),
    Key([mod], "e", lazy.spawn("rofi -show emoji -modi emoji")),
    Key([mod], "Escape", lazy.spawn("xkill")),
    Key([mod, "shift"], "d", lazy.spawn("dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'NotoMonoRegular:bold:pixelsize=14'")),

    # QTILE FUNCTION
    Key([mod], "q", lazy.window.kill()),
    Key([mod, "shift"], "q", lazy.shutdown()),
    Key([mod, "shift"], "r", lazy.restart()),

    Key([mod, "shift"], "s", lazy.spawn(myTerm+" -e shutdown now")),
    Key([mod, "control"],"r", lazy.spawn(myTerm+" -e reboot")),
    
# CHANGE SCREEN 
    Key([mod,], "comma", lazy.prev_screen()),
    Key([mod,], "period", lazy.next_screen()),

# FUNCTION KEY
    Key([], "F4", lazy.spawn("~/.config/qtile/qtile_keys.sh")),
    Key([], "F3", lazy.spawn("xfce4-settings-manager")),
    Key([], "F2", lazy.spawn("xfce4-appfinder")),
    Key([], "F1", lazy.spawn("xfce4-find-cursor")),

# SUPER + SHIFT KEYS
    Key([mod, "shift"], "q", lazy.window.kill()),
    Key([mod, "shift"], "r", lazy.restart()),

# QTILE LAYOUT KEYS
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "Tab", lazy.prev_layout()),

# CHANGE FOCUS
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

# RESIZE UP, DOWN, LEFT, RIGHT
    Key([mod, "control"], "h",
        lazy.layout.grow_right(),
        lazy.layout.grow(),
        lazy.layout.increase_ratio(),
        lazy.layout.delete(),
        ),
    Key([mod, "control"], "l",
        lazy.layout.grow_left(),
        lazy.layout.shrink(),
        lazy.layout.decrease_ratio(),
        lazy.layout.add(),
        ),
    Key([mod, "control"], "k",
        lazy.layout.grow_up(),
        lazy.layout.grow(),
        lazy.layout.decrease_nmaster(),
        ),
    Key([mod, "control"], "j",
        lazy.layout.grow_down(),
        lazy.layout.shrink(),
        lazy.layout.increase_nmaster(),
        ),

    Key(["control" + 'mod1'], "s", lazy.spawn("xfce4-screenshooter")),
    Key([mod,], "m", lazy.window.toggle_minimize()),
    Key([mod, "shift"], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "n", lazy.layout.normalize()),
    Key([mod, "shift"], "m", lazy.layout.maximize()),

# FLIP LAYOUT FOR MONADTALL/MONADWIDE
    Key([mod, "control"], "f", lazy.layout.flip()),

# FLIP LAYOUT FOR BSP
    Key([mod, "mod1"], "k", lazy.layout.flip_up()),
    Key([mod, "mod1"], "j", lazy.layout.flip_down()),
    Key([mod, "mod1"], "l", lazy.layout.flip_right()),
    Key([mod, "mod1"], "h", lazy.layout.flip_left()),

# MOVE WINDOWS UP OR DOWN BSP LAYOUT
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

# CHANGE WALLPAPER
    Key(["mod1"], "space", lazy.spawn("nitrogen --random --set-tiled")),
    ]
# END_KEYS
group_names = [("WWW", {'layout': 'max'}),
               ("FISH", {'layout': 'monadtall'}),
               ("BASH", {'layout': 'monadtall'}),
               ("PYTHON", {'layout': 'monadtall'}),
               ("PHP", {'layout': 'monadtall'}),
               ("JAVA", {'layout': 'monadtall'}),
               ("LUA", {'layout': 'monadtall'}),
               ("SYS", {'layout': 'monadtall'}),
               ("MUS", {'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group


def init_layout_theme():
    return {"margin":5,
            "border_width":2,
            "border_focus": "#5e81ac",
            "border_normal": "#4c566a"
            }

layout_theme = init_layout_theme()


layouts = [
    layout.MonadTall(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.MonadWide(margin=8, border_width=2, border_focus="#5e81ac", border_normal="#4c566a"),
    layout.Matrix(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.Floating(**layout_theme),
    layout.RatioTile(**layout_theme),
    layout.Max(**layout_theme)
]

# COLORS FOR THE BAR
#Theme name : ArcoLinux Default
def init_colors():
    return [["#282c34", "#282c34"],# color 0
           ["#3d3f4b", "#434758"],# color 1
           ["#ffffff", "#ffffff"],# color 2
           ["#ff5555", "#ff5555"],# color 3
           ["#74438f", "#74438f"],# color 4
           ["#4f76c7", "#4f76c7"],# color 5
           ["#e1acff", "#e1acff"],# color 6
           ["#ecbbfb", "#ecbbfb"]]# color 7

class Battery(widget.Battery):
    def _get_text(self):
        info = self._get_info()
        if info is False:
            return '---'
        if info['full']:
            no = int(info['now'] / info['full'] * 9.999)
        else:
            no = 0
        if info['start'] == 'Discharging':
            char = self.discharge_char
            if no < 2 :
                self.layout.color = self.low_foreground
            else:
                self.layout.color = self.foreground
        elif info['start'] == 'Charging':
            char =  self.charge.char
        else:
            char = '■'

        return '{}{}{}'.format(char, no, 'B')

colors = init_colors()


# WIDGETS FOR THE BAR

def init_widgets_defaults():
    return dict(font="Noto Sans",
                fontsize = 12,
                padding = 2,
                background=colors[1])

widget_defaults = init_widgets_defaults()

def init_widgets_list():
    prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())
    widgets_list = [
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
                widget.Image(
                       filename = "~/.config/qtile/icons/python-white.png",
                       scale = "False",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm)}
                       ),
                widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[2],
                       background = colors[0]
                       ),
                widget.GroupBox(
                       font = "Ubuntu Bold",
                       fontsize = 15,
                       margin_y = 3,
                       margin_x = 0,
                       padding_y = 5,
                       padding_x = 3,
                       borderwidth = 3,
                       active = colors[2],
                       inactive = colors[7],
                       rounded = False,
                       highlight_color = colors[1],
                       highlight_method = "line",
                       this_current_screen_border = colors[6],
                       this_screen_border = colors [4],
                       other_current_screen_border = colors[6],
                       other_screen_border = colors[4],
                       foreground = colors[2],
                       background = colors[0]
                       ),
                widget.Prompt(
                       prompt = prompt,
                       font = "Ubuntu Mono",
                       padding = 10,
                       foreground = colors[3],
                       background = colors[1]
                       ),
               widget.Sep(
                        linewidth = 1,
                        padding = 10,
                        foreground = colors[2],
                        background = colors[0]
                        ),
                widget.WindowName(
                       foreground = colors[6],
                       background = colors[0],
                       padding = 0
                       ),
              widget.Systray(
                       background = colors[0],
                       padding = 5
                       ),
              widget.Sep(
                       linewidth = 0,
                       padding = 6,
                       foreground = colors[0],
                       background = colors[0]
                       ),
              widget.TextBox(
                       text = '',
                       background = colors[0],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
             widget.Net(
                       interface = "enp6s0",
                       format = '{down} ↓↑ {up}',
                       foreground = colors[2],
                       background = colors[5],
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       background = colors[5],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.TextBox(
                       text = " 🖬",
                       foreground = colors[2],
                       background = colors[4],
                       padding = 0,
                       fontsize = 14
                       ),
              widget.Memory(
                       foreground = colors[2],
                       background = colors[4],
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(myTerm + ' -e htop')},
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.TextBox(
                      text = " Vol:",
                       foreground = colors[2],
                       background = colors[5],
                       padding = 0
                       ),
              widget.Volume(
                       foreground = colors[2],
                       background = colors[5],
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       background = colors[5],
                       foreground = colors[4],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.CurrentLayoutIcon(
                       custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                       foreground = colors[0],
                       background = colors[4],
                       padding = 0,
                       scale = 0.7
                       ),
              widget.CurrentLayout(
                       foreground = colors[2],
                       background = colors[4],
                       padding = 5
                       ),
              widget.TextBox(
                       text = '',
                       background = colors[4],
                       foreground = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
              widget.Clock(
                       foreground = colors[2],
                       background = colors[5],
                       format = "%A, %B %d - %H:%M "
                       ),
              widget.TextBox(
                       text = '',
                       foreground = colors[4],
                       background = colors[5],
                       padding = 0,
                       fontsize = 37
                       ),
                Battery(
                        font = "Ubuntu Bold",
                        foreground = colors[7],
                        background = colors[4],
                        fontsize = 15,
                        charge_char = u'▲',
                        discharge_char = u'▼',
                        low_foreground = color_alert,
                        ),
              ]
    return widgets_list

widgets_list = init_widgets_list()


def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    return widgets_screen2

widgets_screen1 = init_widgets_screen1()
widgets_screen2 = init_widgets_screen2()


def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), size=26, opacity=0.8)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), size=26, opacity=0.8))]
screens = init_screens()


# MOUSE CONFIGURATION
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size())
]

dgroups_key_binder = None
dgroups_app_rules = []


main = None

@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])

@hook.subscribe.startup
def start_always():
    # Set the cursor to something sane in X
    subprocess.Popen(['xsetroot', '-cursor_name', 'left_ptr'])

@hook.subscribe.client_new
def set_floating(window):
    if (window.window.get_wm_transient_for()
            or window.window.get_wm_type() in floating_types):
        window.floating = True

floating_types = ["notification", "toolbar", "splash", "dialog"]


follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules, 
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    Match(wm_class='Arcolinux-welcome-app.py'),
    Match(wm_class='Arcolinux-tweak-tool.py'),
    Match(wm_class='Arcolinux-calamares-tool.py'),
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='Arandr'),
    Match(wm_class='feh'),
    Match(wm_class='Galculator'),
    Match(wm_class='arcolinux-logout'),
    Match(wm_class='xfce4-terminal'),

],  fullscreen_border_width = 0, border_width = 0)
auto_fullscreen = True

focus_on_window_activation = "focus" # or smart

wmname = "LG3D"
