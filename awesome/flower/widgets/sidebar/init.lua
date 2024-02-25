local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local clock = require("flower/widgets/sidebar/clock")
local prof = require("flower/widgets/sidebar/prof")
local music = require("flower/widgets/sidebar/music")
local sysinfo = require("flower/widgets/sidebar/sysinfo")

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end
end

box_top = wibox.widget {
    bg = beautiful.bg,
    widget = wibox.container.background
}

box_center = wibox.widget {
    bg = beautiful.bg,
    widget = wibox.container.background
}

box_bottom = wibox.widget {
    bg = beautiful.bg,
    widget = wibox.container.background
}

separator = wibox.widget {     
    {
        {
            widget = wibox.container.place
        },
        bg = beautiful.bg,
        forced_height = dpi(3),
        shape = rrect(),
        widget = wibox.container.background
    },
    right = dpi(32),
    bottom = dpi(0),
    left = dpi(32),
    widget = wibox.container.margin
}

sidebar = wibox {
    visible = false,
    ontop = true,
    
    width = 460,
    height = 1200 - 100,
    x = dpi(20),
    y = dpi(20),
    
    bg = beautiful.fg
}

local title = wibox.widget {
    {
        widget = wibox.container.place
    },
    forced_height = dpi(58),
    bg = beautiful.bg,
    widget = wibox.container.background
}

sidebar : setup {
    {
        title,
        {
            clock,
            prof,
            {
                music,
                top = dpi(6),
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.vertical
        },
        sysinfo,
        layout = wibox.layout.align.vertical
    },
    margins = dpi(0),
    widget = wibox.container.margin
}

sidebar.toggle = function(self)
    self.visible = not self.visible
end

return sidebar
