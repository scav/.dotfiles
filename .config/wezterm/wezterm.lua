local wezterm = require 'wezterm'
local config = {}

-- Set up fonts
config.font = wezterm.font('JetBrains Mono', { weight = 'ExtraBold' })
config.font_size = 14
config.color_scheme = 'Tokyo Night Storm'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

-- MacOS keyboard fix
config.send_composed_key_when_left_alt_is_pressed = true

return config
