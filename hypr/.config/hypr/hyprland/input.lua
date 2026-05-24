---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,latam",
        kb_variant = "",
        kb_model   = "",
        kb_options = "lv3:ralt_alt",
        kb_rules   = "",

        follow_mouse = 1,

	accel_profile = "flat",
        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "special",
})
