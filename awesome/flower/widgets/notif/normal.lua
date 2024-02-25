local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local ruled = require("ruled")
local naughty = require("naughty")
local beautiful = require("beautiful")

local cairo = require("lgi").cairo

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local rrect = function(n)
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
end

local scale_sf = function(sf, size)
    local new_sf = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local cr = cairo.Context(new_sf)
    local w = sf.width
    local h = sf.height

    if w >= h then
        local ratio = size / h
        cr:scale(ratio, ratio)
        cr:set_source_surface(sf, 0, 0)
    else
        local ratio = size / w
        cr:scale(ratio, ratio)
        cr:set_source_surface(sf, 0, 0)
    end

    cr:paint()

    return new_sf
end

ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule {
        rule = nil,
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n,

        fg = beautiful.fg_alt,
        bg = beautiful.fg,
        
        -- minimum_width = 300,
        -- maximum_width = 300,
        -- maximum_height = 150,
    
        widget_template = {
            {
                {
                    {
                        naughty.widget.title, 
                        naughty.widget.message,
                        spacing = 6,
                        layout = wibox.layout.fixed.vertical
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(22), 
                widget = wibox.container.margin 
            },
            fg = beautiful.bg_alt,
            forced_width = 360,
            forced_height = 100,
            widget = wibox.container.background 
        }
    }
end)

