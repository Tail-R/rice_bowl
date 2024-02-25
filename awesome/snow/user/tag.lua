local awful = require("awful")

local T = { "1", "2", "3", "4", "5" }

awful.screen.connect_for_each_screen(function(s)
    awful.tag(T, s, awful.layout.layouts[1])
end)
