local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")
local xres = require("beautiful.xresources")

local dpi = xres.apply_dpi

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end
end

local buttons = gears.table.join(
                    awful.button({ }, 1, function (c)
                        if c == client.focus then
                            c.minimized = true
                        else
                            c:emit_signal(
                                "request::activate",
                                "tasklist",
                                {raise = true}
                            )
                        end
                    end))
    
local gen_tasklist = function(s)
    local tasklist = awful.widget.tasklist {
        screen = s,
        
        -- filter = awful.widget.tasklist.filter.currenttags,
        filter = awful.widget.tasklist.filter.allscreen,
        
        buttons = buttons,
 
        layout = {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(0)
        },

        widget_template = {
            {
                {
                    {
                        -- {
                            { -- icon
                                id = "icon_role",
                                opacity = 0.75,
                                widget = wibox.widget.imagebox
                            },
                            -- { -- text
                            --     id = "text_role",
                            --     widget = wibox.widget.textbox
                            -- },
                            -- layout = wibox.layout.fixed.horizontal,
                            -- spacing = dpi(12),
                        -- },
                        widget = wibox.container.margin,
                        margins = dpi(6), 
                    },
                    id = "background_role",
                    widget = wibox.container.background
                },
                widget = wibox.container.background 
            },
            top = dpi(14),
            right = dpi(0),
            bottom = dpi(14),
            left = dpi(20), 
            widget = wibox.container.margin
        }
    }

    return tasklist
end

return gen_tasklist
