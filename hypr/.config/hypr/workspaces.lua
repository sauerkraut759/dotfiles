--------------------
---- WORKSPACES ----
--------------------

-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local profile = require("profiles")

-- Persistent monitors
hl.workspace_rule({ workspace = "r[1-4]", monitor = profile.main_monitor, persistent = true })

if profile.secondary_monitor then
	hl.workspace_rule({ workspace = "r[5-8]", monitor = profile.secondary_monitor, persistent = true })
end
