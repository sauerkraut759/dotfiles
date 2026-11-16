-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function () 
  hl.exec_cmd("noctalia")
  hl.exec_cmd("waydoodle")
end)


