-----------------
---- WINDOWS ----
-----------------

-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- windowrule = match:class kitty, opacity 1.0 override
-- windowrule = match:title .*(mpv).*, float on
-- windowrule = match:title .*(mpv).*, opacity 1.0 override
-- windowrule = match:title .*(YouTube).*, opacity 1.0 override
-- windowrule = match:class steam, float on
-- windowrule = match:class steam, match:title Steam, tile on, size 80% 100%, workspace 2
-- windowrule = match:class steam, match:title .*(Friends List).*, tile on, size 20% 100%, workspace 2
-- windowrule = match:class org.pwmt.zathura, opacity 1.0 override
-- windowrule = match:class swayimg, float on
-- windowrule = match:class PacketTracer, float on

hl.window_rule({
	name = "kitty-rules",
	match = { class = "kitty" },
	opacity = "1.0 override",
})

hl.window_rule({
	name = "mpv-rules",
	match = { title = ".*(mpv).*" },
	opacity = "1.0 override",
	float = true,
})

hl.window_rule({
	name = "youtube-rules",
	match = { title = ".*(YouTube).*" },
	opacity = "1.0 override",
})

hl.window_rule({
	name = "zathura-rules",
	match = { class = "org.pwmt.zathura" },
	opacity = "1.0 override",
})

hl.window_rule({
	name = "swayimg-rules",
	match = { class = "swayimg" },
	float = true,
})
