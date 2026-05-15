hl.monitor({
    ouput = "",
    -- mode = "5120x1440@240,",
    mode = "preferred",
    position = "auto",
    scale = "1",
})

-- Default apps
local terminal = "ghostty"
local fileManager = "yazi"
local menu = "rofi -show drun"
local reload_waybar = "pkill waybar; waybar &"
local snip = "snip"

hl.env("GTK_THEME,Tokyo-Night-Dark")
hl.env("GTK_ICON_THEME,Adwaita")
hl.env("XCURSOR_THEME,Adwaita")
hl.env("XCURSOR_SIZE,24")
hl.env("HYPRCURSOR_SIZE,24")
hl.env("XDG_CURRENT_DESKTOP,Hyprland")
hl.env("XDG_SESSION_TYPE,wayland")

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")

    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Tokyo-Night-Dark'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
end)

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 1,
        border_size = 1,
        col = {
            active_border = "rgba(bb9af7ff)",
            inactive_border = "rgba(565f89ff)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    group = {
        col = {
            border_active = "rgba(bb9af7ff) rgba(b4f9f8ff) 45deg",
            border_inactive = "rgba(565f89cc) rgba(9aa5cecc) 45deg",
            border_locked_active = "rgba(bb9af7ff) rgba(b4f9f8ff) 45deg",
            border_locked_inactive = "rgba(565f89cc) rgba(9aa5cecc) 45deg",
        },
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
        pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },

    input = {
        kb_layout = "us,no",
        kb_variant = ",",
        kb_options = "grp:alt_space_toggle",
        follow_mouse = 1,
        sensitivity = 2,
        repeat_rate = 35,
        repeat_delay = 200,
        touchpad = {
            natural_scroll = false,
        },
    },

    cursor = {
        inactive_timeout = 30,
        no_hardware_cursors = true,
    },
    master = {
        new_status = "master",
    },
})

local mainMod = "SUPER"
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Move workspaces and move windows
for i = 1, 4 do
    local key = i % 4
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Create the binds based on input
local function populateBinds(binds)
    for _, b in ipairs(binds) do
        local command_str = b.disp
        if b.arg ~= "" then
            command_str = b.disp .. " " .. b.arg
        end

        local trigger = b.mod and (b.mod .. ", " .. b.key) or b.key
        hl.bind(trigger, hl.dsp.exec_cmd(command_str), b.opts)
    end
end

-- Register all binds here to avoid repeating myself
local keybinds = {
    {
        mod = mainMod,
        key = "Return",
        disp = "exec",
        arg = terminal,
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "Q",
        disp = "killactive",
        arg = "",
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "M",
        disp = "exit",
        arg = "",
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "E",
        disp = "exec",
        arg = fileManager,
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "V",
        disp = "togglefloating",
        arg = "",
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "SPACE",
        disp = "exec",
        arg = menu,
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "R",
        disp = "exec",
        arg = reload_waybar,
        opts = { locked = false, repeating = false },
    },
    {
        mod = mainMod,
        key = "S",
        disp = "exec",
        arg = snip,
        opts = { locked = false, repeating = false },
    },
    {
        mod = nil,
        key = "XF86AudioPlay",
        disp = "exec",
        arg = "playerctl play-pause",
        opts = { locked = true, repeating = false },
    },
    {
        mod = nil,
        key = "XF86AudioNext",
        disp = "exec",
        arg = "playerctl next",
        opts = { locked = true, repeating = false },
    },
    {
        mod = nil,
        key = "XF86AudioPrev",
        disp = "exec",
        arg = "playerctl previous",
        opts = { locked = true, repeating = false },
    },

    -- Volume Controls (wpctl)
    {
        mod = nil,
        key = "XF86AudioRaiseVolume",
        disp = "exec",
        arg = "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+",
        opts = { locked = true, repeating = true },
    },
    {
        mod = nil,
        key = "XF86AudioLowerVolume",
        disp = "exec",
        arg = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
        opts = { locked = true, repeating = true },
    },
    {
        mod = nil,
        key = "XF86AudioMute",
        disp = "exec",
        arg = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
        opts = { locked = true, repeating = true },
    },
}
populateBinds(keybinds)
