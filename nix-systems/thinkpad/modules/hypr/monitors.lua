-- Use integrated GPU as primary renderer
hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")

-- Built in
hl.monitor({
	output = "",
	mode = "3200x2000@120.00",
	position = "auto-right",
	scale = "1.6",
})
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
