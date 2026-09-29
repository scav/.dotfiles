hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd([[
brightnessctl -s set +10% && \
brightnessctl get | awk -v max="$(brightnessctl max)" '{print int($1 / max * 100)}' > "$XDG_RUNTIME_DIR/wob.sock"
]]),
    { locked = true, repeating = true }
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd([[
brightnessctl -s set 10%- && \
brightnessctl get | awk -v max="$(brightnessctl max)" '{print int($1 / max * 100)}' > "$XDG_RUNTIME_DIR/wob.sock"
]]),
    { locked = true, repeating = true }
)
