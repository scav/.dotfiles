-- Default apps
local terminal = "ghostty"
local fileManager = "yazi -e yazi"
local menu = "rofi -show drun"
local reload_waybar = "pkill waybar; waybar &"

local main_mod = "SUPER"

-- Toggle language
hl.bind(main_mod .. " + Control_L", hl.dsp.exec_cmd("hyprctl switchxkblayout current next && pkill -RTMIN+8 waybar"))

-- Workspaces
for i = 1, 4 do
	local key = i % 4
	hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Window management
hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "down" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- General
hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + Q", hl.dsp.window.close(hl.get_active_window()))
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(reload_waybar))

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(
		"wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
	),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(
		"wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%- && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}' > $XDG_RUNTIME_DIR/wob.sock"
	),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)

-- Hyprlock
hl.bind(main_mod .. " + X", hl.dsp.exec_cmd("hyprlock"))
