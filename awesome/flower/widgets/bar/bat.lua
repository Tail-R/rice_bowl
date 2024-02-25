-- todo: just read the value from /sys/class/power_supply

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local bat = wibox.widget {
    markup = "?",
    font = "azukifontB 20",
    widget = wibox.widget.textbox
}

local cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/bat -l"

local is_int = function(str)
    return not (str == "" or string.find(str, "%D"))
end

local upd_bat = function()
    awful.spawn.easy_async(cmd, function(stdout)
        local val = tonumber(stdout)

        if is_int(val) then
            if val > 80 then
                bat.markup = " "
            elseif val > 60 then
                bat.markup = " "
            elseif val > 40 then
                bat.markup = " "
            elseif val > 20 then
                bat.markup = " "
            else
                bat.markup = " "
            end
        else
            bat.markup = "!"
        end
    end)
end

gears.timer {
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        upd_bat()
    end
}

return bat
