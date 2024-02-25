local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local beautiful = require("beautiful")
local xres = require("beautiful.xresources")

local dpi = xres.apply_dpi

local tag_prop = {
    active = {
        icon = "花",
        color = beautiful.tag_fg_active
    },
    inactive = {
        icon = "雪",
        color = beautiful.tag_fg_inactive
    },
    occupied = {
        icon = "月",
        color = beautiful.tag_fg_occupied
    }
}

local update_tag = function(self, t)
    self:get_children_by_id("tag_fg")[1].markup = tag_prop.inactive.icon
    self.fg = tag_prop.inactive.color
    
    if #t:clients() > 0 then
        self:get_children_by_id("tag_fg")[1].markup = tag_prop.occupied.icon
        self.fg = tag_prop.occupied.color

    end
    
    if t.selected then
        self:get_children_by_id("tag_fg")[1].markup = tag_prop.active.icon
        self.fg = tag_prop.active.color
    end
end


local buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end)
                )
    
local gen_taglist = function(s)
    local taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = buttons,
        
        layout = {
            spacing = dpi(20),
            layout = wibox.layout.fixed.horizontal
        },
        
        widget_template = {
            {
                id = "tag_fg",
                font = beautiful.font,
                widget = wibox.widget.textbox
            },
            id = "tag_bg",
            widget = wibox.container.background,

            create_callback = function(self, t, _, _)
                update_tag(self, t)
            end,
            
            update_callback = function(self, t, _, _)
                update_tag(self, t)
            end
        }
    }
    
    return taglist
end

return gen_taglist
