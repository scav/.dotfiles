local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

--
config.max_fps = 120
config.animation_fps = 60
config.front_end = "WebGpu"

-- Set up fonts
config.font = wezterm.font('JetBrains Mono', { weight = 'ExtraBold' })
config.font_size = 14
config.color_scheme = 'Tokyo Night Storm'
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"

-- MacOS keyboard fix
config.send_composed_key_when_left_alt_is_pressed = true

-- Multiplexing
config.unix_domains = {
    {
        name = 'unix',
    },
}
config.default_gui_startup_args = { 'connect', 'unix' }

-- CMD-click to open url under mouse pointer
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CMD',
        action = wezterm.action.OpenLinkAtMouseCursor,
    },
}
-- Keybinds
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
    {
        key = 't',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    -- splitting
    {
        mods   = "LEADER",
        key    = "-",
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = "LEADER",
        key    = "=",
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    { key = 'l', mods = 'LEADER', action = wezterm.action.ShowLauncher },
    { key = 's', mods = 'LEADER', action = act.PaneSelect },
    { key = 't', mods = 'LEADER', action = act.ShowTabNavigator },

    -- Set pane resizing and switching to vim-like keys
    { key = 'k', mods = 'ALT',    action = act.AdjustPaneSize { "Up", 1 } },
    { key = 'K', mods = 'ALT',    action = act.AdjustPaneSize { "Up", 10 } },
    { key = 'j', mods = 'ALT',    action = act.AdjustPaneSize { "Down", 1 } },
    { key = 'J', mods = 'ALT',    action = act.AdjustPaneSize { "Down", 10 } },
    { key = 'h', mods = 'ALT',    action = act.AdjustPaneSize { "Left", 1 } },
    { key = 'H', mods = 'ALT',    action = act.AdjustPaneSize { "Left", 10 } },
    { key = 'l', mods = 'ALT',    action = act.AdjustPaneSize { "Right", 1 } },
    { key = 'L', mods = 'ALT',    action = act.AdjustPaneSize { "Right", 10 } },
    { key = 'k', mods = 'CMD',    action = act.ActivatePaneDirection("Up") },
    { key = 'j', mods = 'CMD',    action = act.ActivatePaneDirection("Down") },
    { key = 'h', mods = 'CMD',    action = act.ActivatePaneDirection("Left") },
    { key = 'l', mods = 'CMD',    action = act.ActivatePaneDirection("Right") },

    {
        key = 'w',
        mods = 'LEADER',
        action = act.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:perform_action(
                        act.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
    },
}

-- Config elements I dont fully understand yet
wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

return config
