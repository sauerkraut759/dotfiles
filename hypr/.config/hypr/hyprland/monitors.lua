------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
require("hyprland.lib")

local p = get_profile()

-- fallback
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

if p.host_type == "desktop" then
	hl.monitor({
		output = p.main_monitor,
		mode = "1920x1080@144",
		position = "0x0",
		scale = 1,
	})

	hl.monitor({
		output = p.secondary_monitor,
		mode = "1280x1024",
		position = "-1280x0",
		scale = 1,
	})
else
	hl.monitor({
		output = p.main_monitor,
		mode = "1920x1080@144",
		position = "0x0",
		scale = 1.20,
	})
end
