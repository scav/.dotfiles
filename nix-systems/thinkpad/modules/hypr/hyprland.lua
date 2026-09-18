hl.config({
    -- Disable animations to draw less power
    decoration = {
        blur = {
            enabled = false,
        },
        shadow = {
            enabled = false,
        },
    },

    input = {
        touchpad = {
            natural_scroll = true,
            clickfinger_behavior = true,
        },
    },
})

hl.device({
    name = "snsl002d:00-2c2f:002d-touchpad",
    sensitivity = 0.5,
    scroll_factor = 0.5,
})
