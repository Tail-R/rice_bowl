local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 16)
    end
end

awful.rules.rules = {
    -- any
    {
        rule = { },
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    {
        rule_any = {
            type = { "normal" }
        },
        properties = { titlebars_enabled = true }
    }
}

require("awful.autofocus")

-- -- rounded corner
-- client.connect_signal("manage", function(c)
--     c.shape = rrect()
-- end)


-- enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

