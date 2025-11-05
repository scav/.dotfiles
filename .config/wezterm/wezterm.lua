local wezterm = require("wezterm")
local action = wezterm.action
local config = {}

--
config.max_fps = 120
config.animation_fps = 120
config.front_end = "WebGpu"
config.window_background_opacity = 1.0
-- Set up fonts
config.font = wezterm.font("JetBrains Mono", { weight = "ExtraBold" })
config.font_size = 14
config.color_scheme = "Tokyo Night Storm"
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.use_resize_increments = false
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}

-- MacOS keyboard fix
config.send_composed_key_when_left_alt_is_pressed = true

-- Multiplexing
config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

-- CMD-click to open url under mouse pointer
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}
-- Keybinds
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "t",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	-- splitting
	{
		mods = "LEADER",
		key = "-",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		mods = "LEADER",
		key = "=",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },
	{ key = "s", mods = "LEADER", action = action.PaneSelect },
	{ key = "t", mods = "LEADER", action = action.ShowTabNavigator },

	-- Set pane resizing and switching to vim-like keys
	{ key = "k", mods = "ALT", action = action.AdjustPaneSize({ "Up", 1 }) },
	{ key = "K", mods = "ALT", action = action.AdjustPaneSize({ "Up", 10 }) },
	{ key = "j", mods = "ALT", action = action.AdjustPaneSize({ "Down", 1 }) },
	{ key = "J", mods = "ALT", action = action.AdjustPaneSize({ "Down", 10 }) },
	{ key = "h", mods = "ALT", action = action.AdjustPaneSize({ "Left", 1 }) },
	{ key = "H", mods = "ALT", action = action.AdjustPaneSize({ "Left", 10 }) },
	{ key = "l", mods = "ALT", action = action.AdjustPaneSize({ "Right", 1 }) },
	{ key = "L", mods = "ALT", action = action.AdjustPaneSize({ "Right", 10 }) },
	{ key = "k", mods = "CMD", action = action.ActivatePaneDirection("Up") },
	{ key = "j", mods = "CMD", action = action.ActivatePaneDirection("Down") },
	{ key = "h", mods = "CMD", action = action.ActivatePaneDirection("Left") },
	{ key = "l", mods = "CMD", action = action.ActivatePaneDirection("Right") },

	{
		key = "w",
		mods = "LEADER",
		action = action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}

-- Config elements I dont fully understand yet
-- 
wezterm.on("update-right-status", function(window)
	local hostname = " " .. wezterm.hostname() .. " "
	local cwd = window:active_workspace()

	window:set_right_status(wezterm.format({
		{ Text = "  " },
		{ Text = cwd },
		{ Text = "  " },
		{ Text = hostname },
	}))
end)

return config
