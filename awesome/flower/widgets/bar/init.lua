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

local ifbubble = function()
    return function(cr, w, h, r, as, ap)
        gears.shape.transform(gears.shape.infobubble)
        : rotate_at(35, 35, math.pi)
        : translate(20, 20) (cr, 48, 48, 10, 10, 20)
    end
end

local bat = require("flower/widgets/bar/bat")

local systray = wibox.widget {
    -- {
    --     wibox.widget.systray(true),
    --     layout = wibox.layout.fixed.horizontal
    -- },
    margins = dpi(12),
    widget = wibox.container.margin
}

local clock = require("flower/widgets/bar/clock")
local player = require("flower/widgets/bar/player")
local layoutbox = awful.widget.layoutbox(s)

layoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end))
)

awful.screen.connect_for_each_screen(function(s)
    s.layoutbox = layoutbox
    s.taglist = require("flower/widgets/bar/tag")(s)
    s.mytasklist = require("flower/widgets/bar/task")(s)

    s.mywibox = awful.wibar({
        screen = s,
        position = "bottom",
        ontop = true,
        height = 64,
        
        bg = beautiful.fg,    
    })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- left
            layout = wibox.layout.fixed.horizontal,
            { -- launcher
                {
                    {
                        mylauncher,
                        margins = dpi(18),
                        widget = wibox.container.margin
                    },
                    bg = beautiful.bg2,
                    -- shape = rrect(),
                    widget = wibox.container.background
                },
                margins = dpi(0),
                widget = wibox.container.margin
            },
            { -- taglist
                {
                    {
                        s.taglist,
                        margins = dpi(0), 
                        widget = wibox.container.margin
                    },
                    widget = wibox.container.background
                },
                left = dpi(28),
                right = dpi(22), 
                widget = wibox.container.margin
            }
        },
        { -- center
            layout = wibox.layout.align.horizontal,
            { -- separator
                {
                    {
                        forced_width = dpi(4),
                        widget = wibox.container.background
                    },
                    bg = beautiful.bg,
                    shape = rrect(), 
                    widget = wibox.container.background
                },
                margins = dpi(12),
                widget = wibox.container.margin
            },
            { -- tasklist
                {
                    s.mytasklist,
                    margins = dpi(0),
                    halign = "center",
                    widget = wibox.container.margin
                },
                halign = "left",
                widget = wibox.container.place
            },
            systray,
        },
        { -- right
            layout = wibox.layout.fixed.horizontal,
            
            -- { -- battery
            --     {
            --         {
            --             bat,
            --             right = dpi(16),
            --             left = dpi(16),
            --             widget = wibox.container.margin
            --         },
            --         bg = beautiful.bg,
            --         shape = rrect(), 
            --         widget = wibox.container.background
            --     },
            --     margins = dpi(6),
            --     widget = wibox.container.margin
            -- },
            { -- clock
                {
                    {
                        {
                            clock,
                            -- {
                            --     markup = "|",
                            --     widget = wibox.widget.textbox
                            -- },
                            -- bat,
                            nil,
                            -- spacing = dpi(12),
                            layout = wibox.layout.fixed.horizontal
                        },
                        top = dpi(8),
                        right = dpi(22),
                        bottom = dpi(8),
                        left = dpi(22),
                        widget = wibox.container.margin
                    },
                    fg = beautiful.fg,
                    bg = beautiful.bg,
                    -- shape = rrect(),
                    widget = wibox.container.background
                },
                margins = dpi(0),
                widget = wibox.container.margin
            },
            -- { -- music player
            --     player,
            --     margins = dpi(0),
            --     widget = wibox.container.margin
            -- },
            nil,
            { -- layoutbox
                {
                    {
                        s.layoutbox,
                        margins = dpi(18),
                        widget = wibox.container.margin
                    },
                    bg = beautiful.bg2,
                    -- shape = rrect(),
                    widget = wibox.container.background
                },
                margins = dpi(0),
                widget = wibox.container.margin
            }
        }
    }
end)




