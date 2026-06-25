hl.config({
	general = {
		gaps_in  = 5,
		gaps_out = 10,
		border_size = 2,

		col = {
			active_border	= { colors = {"rgba(aee2eaee)", "rgba(81a1c1ee)"}, angle = 20 },
			inactive_border = "rgba(808080aa)",
		},

		resize_on_border = false,

		-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/
		allow_tearing = true,

		layout = "dwindle",
	},
	xwayland = {
		force_zero_scaling = true,
	},
})
