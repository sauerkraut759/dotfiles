local function get_hostname()
	local f = io.open("/etc/hostname", "r")
	if not f then return nil end
	local name = f:read("*l")
	f:close()
	return name
end

local profile = {
	host_type = "desktop"
	main_monitor = "DP-3",
	secondary_monitor = "HDMI-A-1",
}

local hostname = get_hostname()

if hostname == "nitro5" then
	profile.host_type = "laptop"
	profile.main_monitor = "eDP-1"
	profile.secondary_monitor = nil
end

return profile

