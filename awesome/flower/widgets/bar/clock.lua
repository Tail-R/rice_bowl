local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

textclock = wibox.widget.textclock("%H:%M")

local clock = wibox.widget {
    markup = "-- --",
    font = "azukifontB, Bold 20",
    align = "center",
    widget = wibox.widget.textbox
}

local upd_clock = function()
    awful.spawn.easy_async("date +'%H:%M'", function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        clock.markup = str 
    end)
end

gears.timer {
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = function()
        upd_clock() 
    end
}

return clock


