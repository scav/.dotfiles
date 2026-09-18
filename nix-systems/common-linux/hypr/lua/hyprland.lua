hl.config({
	misc = {
		force_default_wallpaper = 0, -- Disable anime cringe
		disable_hyprland_logo = true, -- Disable anime cringe
	},
	general = {
		gaps_in = 1,
		gaps_out = 1,
		border_size = 1,
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
		},
		blur = {
			enabled = true,
			size = 6,
			passes = 3,
		},
	},
	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	input = {
		kb_layout = "us,no",
		kb_variant = ",",
		kb_options = "grp:alt_space_toggle",
		follow_mouse = 1,
		sensitivity = 2,
		repeat_rate = 35,
		repeat_delay = 200,
	},

	cursor = {
		inactive_timeout = 30,
		no_hardware_cursors = true,
	},
	master = {
		new_status = "master",
	},
})
