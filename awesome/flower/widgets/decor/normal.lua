local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local beautiful = require("beautiful")
local naughty = require("naughty")

local cairo = require("lgi").cairo
local math = require("math")

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { position = "top", size = 58 }) : setup {
        { -- Left
            {
                {
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                left = dpi(28), 
                widget = wibox.container.margin
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
            buttons = buttons,
            widget = wibox.container.background
        },
        { -- Right
            {
                {
                    awful.titlebar.widget.minimizebutton(c),
                    top = dpi(2),
                    right = dpi(6),
                    bottom = dpi(2),
                    left = dpi(6),
                    widget = wibox.container.margin
                },
                { 
                    awful.titlebar.widget.maximizedbutton(c),
                    top = dpi(2),
                    right = dpi(6),
                    bottom = dpi(2),
                    left = dpi(6),
                    widget = wibox.container.margin
                },
                {
                    awful.titlebar.widget.closebutton(c),
                    top = dpi(2),
                    right = dpi(6),
                    bottom = dpi(2),
                    left = dpi(6),
                    widget = wibox.container.margin
                }, 
                layout = wibox.layout.fixed.horizontal()
            },
            widget = wibox.container.margin,
            margins = dpi(16)
        },
        layout = wibox.layout.align.horizontal
    }
end)
