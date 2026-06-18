local vars = require("variables")

hl.bind(vars.main_mod .. " + T", hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.main_mod .. " + Q", hl.dsp.window.close())
hl.bind(vars.main_mod .. " + M", hl.dsp.exit())
hl.bind(vars.main_mod .. " + G", hl.dsp.exec_cmd(vars.file_manager))
hl.bind(vars.main_mod .. " + L", hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.main_mod .. " + return", hl.dsp.exec_cmd(vars.menu))
hl.bind(vars.main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(vars.main_mod .. " + B", hl.dsp.exec_cmd(vars.browser))

hl.bind(vars.main_mod .. " + C", hl.dsp.send_shortcut({ mods = "CTRL", key = "C" }))
hl.bind(vars.main_mod .. " + X", hl.dsp.send_shortcut({ mods = "CTRL", key = "X" }))
hl.bind(vars.main_mod .. " + V", hl.dsp.send_shortcut({ mods = "CTRL", key = "V" }))
hl.bind(vars.main_mod .. " + Z", hl.dsp.send_shortcut({ mods = "CTRL", key = "Z" }))
hl.bind(vars.main_mod .. " + A", hl.dsp.send_shortcut({ mods = "CTRL", key = "A" }))
hl.bind(vars.main_mod .. " + F", hl.dsp.send_shortcut({ mods = "CTRL", key = "F" }))

hl.bind(vars.main_mod .. " + E", hl.dsp.exec_cmd("hyprshot -m region -o " .. vars.path_hyprshot))

hl.bind(vars.main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(vars.main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(vars.main_mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(vars.main_mod .. " + j", hl.dsp.focus({ direction = "down" }))

for workspace = 1, 10 do
	local key = workspace % 10

	hl.bind(vars.main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
end

hl.bind(vars.main_mod .. " + tab", hl.dsp.focus({ workspace = "e+1" }))

hl.bind(vars.main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(vars.main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.define_submap("dragwindow", function()
	for workspace = 1, 10 do
		local key = workspace % 10

		hl.bind(vars.main_mod .. " + " .. key, hl.dsp.window.move({ workspace = workspace }))
	end

	hl.bind(vars.main_mod .. " + tab", hl.dsp.window.move({ workspace = "e+1" }))
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("mouse:272", hl.dsp.submap("reset"), { release = true, ignore_mods = true })
end)

hl.bind(vars.main_mod .. " + mouse:272", hl.dsp.submap("dragwindow"))

hl.bind("SUPER + V", hl.dsp.exec_cmd("uwsm app -- ghostty --class clipse -e clipse"))
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
