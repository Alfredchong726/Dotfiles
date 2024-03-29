local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

-- Standard awesome library
local gears = require("gears") --Utilities such as color parsing and objects
local awful = require("awful") --Everything related to window managment
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
naughty.config.defaults["icon_size"] = 100

local lain = require("lain")
local freedesktop = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
require("awful.hotkeys_popup.keys")
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end

-- function to increase the backlight
local function backlight_inc()
	current_brightness = io.popen("brightnessctl g"):read("*a")
	new_brightness = current_brightness + current_brightness * 0.1
	os.execute("brightnessctl set " .. new_brightness)
end

-- function to decrease the backlight
local function backlight_dec()
	current_brightness = io.popen("brightnessctl g"):read("*a")
	new_brightness = current_brightness - current_brightness * 0.1
	os.execute("brightnessctl set " .. new_brightness)
end
local function run_once(cmd_arr)
	for _, cmd in ipairs(cmd_arr) do
		awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
	end
end

run_once({ "unclutter -root" }) -- entries must be comma-separated

local themes = {
	"powerarrow-blue", -- 1
	"powerarrow", -- 2
	"multicolor", -- 3
}

-- choose your theme here
local chosen_theme = themes[1]
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

local modkey = "Mod4"
local altkey = "Mod1"
local modkey1 = "Control"

-- personal variables
local browser = "firefox"
local editor = os.getenv("EDITOR") or "vim"
local editorgui = "geany"
local filemanager = "pcmanfm"
local mailclient = "geary"
local mediaplayer = "vlc"
local scrlocker = "slimlock"
local terminal = "alacritty"
local virtualmachine = "virtualbox"

-- awesome variables
awful.util.terminal = terminal
--awful.util.tagnames = {  " ", " ", " ", " ", " ", " ", " ", " ", " ", " "  }
awful.util.tagnames = { " WWW ", " FISH ", " BASH ", " PYTHON ", " PHP ", " C ", " JAVA ", " SYS ", " MUS " }
awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.floating,
	--awful.layout.suit.tile.left,
	--awful.layout.suit.tile.bottom,
	--awful.layout.suit.tile.top,
	--awful.layout.suit.fair,
	--awful.layout.suit.fair.horizontal,
	--awful.layout.suit.spiral,
	--awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	--awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier,
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.corner.ne,
	--awful.layout.suit.corner.sw,
	--awful.layout.suit.corner.se,
	--lain.layout.cascade,
	--lain.layout.cascade.tile,
	--lain.layout.centerwork,
	--lain.layout.centerwork.horizontal,
	--lain.layout.termfair,
	--lain.layout.termfair.center,
}

awful.util.taglist_buttons = my_table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

awful.util.tasklist_buttons = my_table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.center.ncol = 1
lain.layout.cascade.tile.offset_x = 2
lain.layout.cascade.tile.offset_y = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster = 5
lain.layout.cascade.tile.ncol = 2

beautiful.init(string.format(gears.filesystem.get_configuration_dir() .. "/themes/%s/theme.lua", chosen_theme))

local myawesomemenu = {
	{
		"hotkeys",
		function()
			return false, hotkeys_popup.show_help
		end,
	},
	{ "manual", terminal .. " -e 'man awesome'" },
	{ "edit config", "emacsclient -c -a emacs ~/.config/awesome/rc.lua" },
	{ "arandr", "arandr" },
	{ "restart", awesome.restart },
}

awful.util.mymainmenu = freedesktop.menu.build({
	icon_size = beautiful.menu_height or 16,
	before = {
		{ "Awesome", myawesomemenu, beautiful.awesome_icon },
		--{ "Atom", "atom" },
		-- other triads can be put here
	},
	after = {
		{ "Terminal", terminal },
		{
			"Log out",
			function()
				awesome.quit()
			end,
		},
		{ "Sleep", "systemctl suspend" },
		{ "Restart", "systemctl reboot" },
		{ "Exit", "systemctl poweroff" },
		-- other triads can be put here
	},
})
--menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s)
	beautiful.at_screen_connect(s)
end)

root.buttons(my_table.join(
	awful.button({}, 3, function()
		awful.util.mymainmenu:toggle()
	end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
))

-- {{{ Key bindings
globalkeys = gears.table.join(

	awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

	awful.key({ modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),

	-- Applications
	awful.key({ modkey }, "d", function()
		awful.spawn("Thunar")
	end, { description = "open file manager", group = "applications" }),
	awful.key({ modkey }, "v", function()
		awful.spawn("virt-manager")
	end, { description = "open virtual machine", group = "applications" }),
	awful.key({ modkey }, "t", function()
		awful.spawn("xfce4-taskmanager")
	end, { description = "open taskmanager", group = "applications" }),
	awful.key({ modkey, "Shift" }, "q", function()
		awful.spawn("qutebrowser")
	end, { description = "open qutebrowser", group = "applications" }),
	awful.key({ modkey, "Shift" }, "t", function()
		awful.spawn("teams")
	end, { description = "open teams", group = "applications" }),
	awful.key({ modkey }, "x", function()
		awful.spawn("archlinux-logout")
	end, { description = "open archlinux-logout", group = "applications" }),
	awful.key({ modkey, "Shift" }, "o", function()
		awful.spawn("obsidian")
	end, { description = "open obsidian", group = "applications" }),
	awful.key({ modkey, "Shift" }, "t", function()
		awful.spawn("teams")
	end, { description = "open teams", group = "applications" }),
	awful.key({ modkey, "Control" }, "o", function()
		awful.spawn("wps")
	end, { description = "open wps", group = "applications" }),
	awful.key({ modkey }, "w", function()
		awful.spawn("whatsapp-for-linux")
	end, { description = "show main menu", group = "awesome" }),
	awful.key({ modkey }, "n", function()
		awful.spawn("nitrogen")
	end, { description = "show main menu", group = "awesome" }),

	-- HotKey
	awful.key({ modkey, "Shift" }, "s", function()
		awful.spawn(terminal .. " -e shutdown now")
	end, { description = "shutdown", group = "HotKey" }),
	awful.key({ modkey, "Control" }, "r", function()
		awful.spawn("reboot")
	end, { description = "reboot", group = "HotKey" }),
	awful.key({ modkey, "Shift" }, "c", function()
		awful.spawn("./alchanger.sh")
	end, { description = "change alacritty theme", group = "HotKey" }),
	awful.key({ modkey }, "a", function()
		awful.spawn("pavucontrol")
	end, { description = "start pulseaudio", group = "HotKey" }),
	awful.key({ modkey }, "b", function()
		awful.spawn(terminal .. "-e bpytop")
	end, { description = "open bpytop", group = "HotKey" }),
	awful.key({ "Mod1" }, "space", function()
		awful.spawn("nitrogen --random --set-zoom-fill --head=0 && nitrogen --random --set-zoom-fill --head=1")
	end, { description = "change wallpaper", group = "HotKey" }),

	-- Brightness
	awful.key({ modkey }, "=", function()
		backlight_inc()
	end, { description = "Increase brightness", group = "HotKey" }),

	awful.key({ modkey }, "-", function()
		backlight_dec()
	end, { description = "Decrease brightness", group = "HotKey" }),

	-- Layout manipulation
	awful.key({ modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key({ modkey }, "h", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ modkey }, "l", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
	awful.key({ modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),

	-- Standard program
	awful.key({ modkey }, "Return", function()
		awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ modkey, "Shift" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ "Mod1", "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

	awful.key({ modkey }, ".", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ modkey }, ",", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),

	awful.key({ modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "restore minimized", group = "client" }),

	-- Prompt
	awful.key({ modkey, "Shift" }, "Return", function()
		awful.spawn("rofi -show run")
	end, { description = "open rofi", group = "launcher" }),

	-- Special Function
	awful.key({ "Control", "Shift" }, "e", function()
		awful.spawn("edit-configs")
	end, { description = "Open File to Edit", group = "Special Function" }),
	awful.key({ "Control", "Shift" }, "p", function()
		awful.spawn("powermenu")
	end, { description = "Control power in short way", group = "Special Function" }),
	awful.key({ "Control", "Shift" }, "q", function()
		awful.spawn("quick-links")
	end, { description = "Access different website", group = "Special Function" }),
	awful.key({ "Control", "Shift" }, "l", function()
		awful.spawn("lock")
	end, { description = "Lock screen", group = "Special Function" }),
	awful.key({ "Control", "Shift" }, "d", function()
		awful.spawn("dock")
	end, { description = "Open File to Edit", group = "Special Function" }),

	-- Screenshot
	awful.key({ "Control", "Mod1" }, "s", function()
		awful.spawn("xfce4-screenshooter")
	end, { description = "Xfce screenshot", group = "screenshots" }),
	awful.key({ "Control", "Shift" }, "s", function()
		awful.spawn("flameshot gui")
	end, { description = "flameshot screenshooter", group = "screenshots" }),
	-- awful.key({ modkey }, "x",
	--           function ()
	--               awful.prompt.run {
	--                 prompt       = "Run Lua code: ",
	--                 textbox      = awful.screen.focused().mypromptbox.widget,
	--                 exe_callback = awful.util.eval,
	--                 history_path = awful.util.get_cache_dir() .. "/history_eval"
	--               }
	--           end,
	--           {description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" })
)

clientkeys = gears.table.join(
	awful.key({ modkey }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, { description = "toggle fullscreen", group = "client" }),
	awful.key({ modkey }, "q", function(c)
		c:kill()
	end, { description = "close", group = "client" }),
	awful.key(
		{ modkey, "Shift" },
		"f",
		awful.client.floating.toggle,
		{ description = "toggle floating", group = "client" }
	),
	awful.key({ modkey, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, { description = "move to master", group = "client" }),
	awful.key({ modkey }, "o", function(c)
		c:move_to_screen()
	end, { description = "move to screen", group = "client" }),
	awful.key({ modkey }, "t", function(c)
		c.ontop = not c.ontop
	end, { description = "toggle keep on top", group = "client" }),
	awful.key({ modkey }, "n", function(c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	end, { description = "minimize", group = "client" }),
	awful.key({ modkey }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, { description = "(un)maximize", group = "client" }),
	awful.key({ modkey, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, { description = "(un)maximize vertically", group = "client" }),
	awful.key({ modkey, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, { description = "(un)maximize horizontally", group = "client" })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = { description = "view tag #", group = "tag" }
		descr_toggle = { description = "toggle tag #", group = "tag" }
		descr_move = { description = "move focused client to tag #", group = "tag" }
		descr_toggle_focus = { description = "toggle focused client on tag #", group = "tag" }
	end
	globalkeys = my_table.join(
		globalkeys,
		-- View tag only.
		awful.key({ modkey }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				tag:view_only()
			end
		end, descr_view),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, "#" .. i + 9, function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end, descr_toggle),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end, descr_move),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end, descr_toggle_focus)
	)
end

clientbuttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			size_hints_honor = false,
		},
	},

	-- Titlebars
	{ rule_any = { type = { "dialog", "normal" } }, properties = { titlebars_enabled = false } },

	-- Set applications to always map on the tag 1 on screen 1.
	-- find class or role via xprop command
	--{ rule = { class = browser1 },
	--properties = { screen = 1, tag = awful.util.tagnames[1] } },

	--{ rule = { class = editorgui },
	--properties = { screen = 1, tag = awful.util.tagnames[2] } },

	--{ rule = { class = "Geany" },
	--properties = { screen = 1, tag = awful.util.tagnames[2] } },

	-- Set applications to always map on the tag 3 on screen 1.
	--{ rule = { class = "Inkscape" },
	--properties = { screen = 1, tag = awful.util.tagnames[3] } },

	-- Set applications to always map on the tag 4 on screen 1.
	--{ rule = { class = "Gimp" },
	--properties = { screen = 1, tag = awful.util.tagnames[4] } },

	-- Set applications to be maximized at startup.
	-- find class or role via xprop command

	{ rule = { class = editorgui }, properties = { maximized = true } },

	{ rule = { class = "Gimp*", role = "gimp-image-window" }, properties = { maximized = true } },

	{ rule = { class = "inkscape" }, properties = { maximized = true } },

	{ rule = { class = mediaplayer }, properties = { maximized = true } },

	{ rule = { class = "Vlc" }, properties = { maximized = true } },

	{ rule = { class = "VirtualBox Manager" }, properties = { maximized = true } },

	{ rule = { class = "VirtualBox Machine" }, properties = { maximized = true } },

	{ rule = { class = "Xfce4-settings-manager" }, properties = { floating = false } },

	-- Floating clients.
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
			},
			class = {
				"Arandr",
				"Blueberry",
				"Galculator",
				"Gnome-font-viewer",
				"Gpick",
				"Imagewriter",
				"Font-manager",
				"Kruler",
				"MessageWin", -- kalarm.
				"Oblogout",
				"Peek",
				"Skype",
				"System-config-printer.py",
				"Sxiv",
				"Unetbootin.elf",
				"Wpa_gui",
				"pinentry",
				"veromix",
				"xtightvncviewer",
			},

			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
				"Preferences",
				"setup",
			},
		},
		properties = { floating = true },
	},
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- Custom
	if beautiful.titlebar_fun then
		beautiful.titlebar_fun(c)
		return
	end

	-- Default
	-- buttons for the titlebar
	local buttons = my_table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

	awful.titlebar(c, { size = 21 }):setup({
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton(c),
			awful.titlebar.widget.ontopbutton(c),
			awful.titlebar.widget.closebutton(c),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

client.connect_signal("mouse::enter", function(c)
	c:emit_signal("request::activate", "mouse_enter", { raise = true })
end)

-- No border for maximized clients
function border_adjust(c)
	if c.maximized then -- no borders if only 1 client visible
		c.border_width = 0
	elseif #awful.screen.focused().clients > 1 then
		c.border_width = beautiful.border_width
		c.border_color = beautiful.border_focus
	end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)

awful.spawn.with_shell("nitrogen --random --set-zoom-fill --head=0")
awful.spawn.with_shell("nitrogen --random --set-zoom-fill --head=1")
awful.spawn.with_shell(
	"xrandr --output eDP-1 --primary --mode 2160x1440 --pos 1920x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal"
)
awful.spawn.with_shell("picom --config  $HOME/.config/picom/picom.conf")
awful.spawn.with_shell("conky -c  $HOME/.config/conky/awesome/tomorrow-night-01.conkyrc")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("volumeicon")
awful.spawn.with_shell("fcitx5")
awful.spawn.with_shell("flameshot")
awful.spawn.with_shell("eww --config $HOME/.config/conkeww/ open conkeww-main")
