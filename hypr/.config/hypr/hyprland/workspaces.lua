--------------------
---- WORKSPACES ----
--------------------

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
require("hyprland.lib")

local profile = get_profile()

-- Persistent monitors

if profile.secondary_monitor then
	for i = 5,8 do
		hl.workspace_rule({ workspace = tostring(i), monitor = profile.secondary_monitor, persistent = true })
	end
end

for i = 1,4 do
	hl.workspace_rule({ workspace = tostring(i), monitor = profile.main_monitor, persistent = true })
end
