-- Use integrated GPU as primary renderer
hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")

-- Built in
local built_in = {
    output = "desc: Samsung Display Corp. ATNA60KA02-0",
    mode = "3200x2000@120.00",
    position = "auto-right",
    scale = "1.6",
    disabled = false,
}
hl.monitor(built_in)

-- Home
hl.monitor({
    output = "desc: Samsung Electric Company LS49AG95 HNTTA00056",
    mode = "5120x1440@240",
    position = "auto",
    scale = "1.0",
})

-- Work
hl.monitor({
    output = "desc: HP Inc. HP E34m G4 CNC4413HB",
    mode = "3440x1440@75",
    position = "auto",
    scale = "1.0",
})

hl.bind("switch:on:Lid Switch", function()
    hl.monitor({ output = built_in.output, disabled = true })
end, { locked = true })
hl.bind("switch:off:Lid Switch", function()
    hl.monitor(built_in)
end, { locked = true })
