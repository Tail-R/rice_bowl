local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/dat -s"

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end
end

local cat = wibox.widget {
    markup = "<span foreground='" .. beautiful.bg  .. "'>󰧱 </span>",
    font = "azukifontB, 30",
    align = "center",
    widget = wibox.widget.textbox
}

local time = wibox.widget {
    markup = "-- --",
    font = "azukifontB, 30",
    align = "center",
    widget = wibox.widget.textbox
}

local dow = wibox.widget {
    markup = "--",
    font = "azukifontB, Bold 24",
    align = "center",
    widget = wibox.widget.textbox
}

local month_day = wibox.widget {
    markup = "- ?",
    font = "azukifontB 18",
    align = "center",
    widget = wibox.widget.textbox
}

local clock_bg = wibox.widget {
    {
        cat,
        time,
        nil,
        spacing = dpi(6),
        layout = wibox.layout.fixed.horizontal
    },
    fg = beautiful.fg_alt,
    widget = wibox.container.background
}

local clock_fg = wibox.widget {
    {
        {
            dow,
            nil,
            month_day,
            spacing = dpi(6),
            layout = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place
    },
    fg = beautiful.bg_alt,
    widget = wibox.container.background
}

local clock = wibox.widget {
    {
        {
            clock_bg,
            nil,
            clock_fg,
            layout = wibox.layout.align.horizontal
        },
        right = dpi(47),
        left = dpi(47), 
        layout = wibox.container.margin
    },
    bg = beautiful.bg_alt_alt,
    forced_height = dpi(128),
    widget = wibox.container.background
}

local upd_time = function()
    awful.spawn.easy_async(cmd, function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        time.markup = str
    end)
end

local upd_dow = function()
    awful.spawn.easy_async("date +'%A'", function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        dow.markup = str 
    end)
end

local upd_month_day = function()
    awful.spawn.easy_async("date +'%b %d'", function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        month_day.markup = str 
    end)
end

gears.timer {
    timeout = 30,
    call_now = true,
    autostart = true,
    callback = function()
        upd_dow()
        upd_month_day()        
        upd_time() 
    end
}

return clock


