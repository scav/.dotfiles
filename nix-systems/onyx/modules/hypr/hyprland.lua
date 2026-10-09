hl.monitor({
    output = "",
    mode = "5120x1440@240",
    position = "auto",
    scale = "1.0",
})

-- Toggle all binds when gaming
hl.bind("ALT + G", hl.dsp.submap("gaming"))
hl.define_submap("gaming", function()
    hl.bind("ALT + G", hl.dsp.submap("reset"))
end)
