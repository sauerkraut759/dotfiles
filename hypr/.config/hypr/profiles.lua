local function get_hostname()
	local f = io.open("/etc/hostname", "r")
	if not f then return nil end
	local name = f:read("*l")
	f:close()
	return name
end

local desktop_profile = {
	host_type = "desktop",
	main_monitor = "DP-3",
	secondary_monitor = "HDMI-A-1",
}

local laptop_profile = {
	host_type = "laptop",
	main_monitor = "eDP-1",
	secondary_monitor = nil,
}

local hostname = get_hostname()

if hostname == "nitro5" then
	return laptop_profile
else
	return desktop_profile
end

