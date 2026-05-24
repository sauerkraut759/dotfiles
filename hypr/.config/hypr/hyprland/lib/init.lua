local function get_hostname()
	local f = io.open("/etc/hostname", "r")
	if not f then return nil end
	local name = f:read("*l")
	f:close()
	return name
end

function get_profile()
	local hostname = get_hostname()

	if hostname == "nitro5" then
		-- Laptop Profile
		return {
			host_type = "laptop",
			main_monitor = "eDP-1",
			secondary_monitor = nil,
		}
	else
		-- Deskop Profile
		return {
			host_type = "desktop",
			main_monitor = "DP-3",
			secondary_monitor = "HDMI-A-1",
		}
	end
end

