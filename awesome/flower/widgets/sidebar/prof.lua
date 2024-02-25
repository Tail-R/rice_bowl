local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local cairo = require("lgi").cairo

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/dat -s"
local uptime = require("snow/user/age") * 8760

local rrect = function(n)
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, n)
    end
end

local ifbubble = function()
    return function(cr, w, h, r, as, ap)
        gears.shape.transform(gears.shape.infobubble)
        : translate(10, 5) (cr, 380, 80, 8, 12, 320)
    end
end

local scale = function(sf, opt)
    local old_sf = sf
    local new_sf = cairo.ImageSurface(cairo.Format.ARGB32, 100, 100)
    
    local cr_old_sf = cairo.Context(old_sf)
    local cr_new_sf = cairo.Context(new_sf)

    cr_new_sf:scale(opt, opt)

    cr_new_sf:set_source_surface(old_sf, -80, 0)
    cr_new_sf:paint()

    return new_sf
end

local pfp = wibox.widget {
    {
        {
            image = scale(gears.surface.load_uncached(beautiful.pfp), 0.15),
            clip_shape = rrect(100), 
            forced_width = dpi(100),
            forced_height = dpi(100),
            widget = wibox.widget.imagebox
        },
        margins = dpi(3),
        widget = wibox.container.margin
    },
    bg = beautiful.fg_alt_alt,
    shape = rrect(100),
    forced_width = dpi(106),
    forced_height = dpi(106),
    widget = wibox.container.background
}

local gen_love = function(color)
    return wibox.widget {
        markup = "<span foreground='" .. color .. "'>󰣐  </span>",
        font = "azukifontB 14",
        widget = wibox.widget.textbox
    }
end

-- hard coding !!!???? wtf
local user_widget = wibox.widget {
    markup = "Welcome, Tail-R!",
    font = "azukifontB 18",
    widget = wibox.widget.textbox
}

local host_widget = wibox.widget {
    markup = "<span foreground='" .. beautiful.bg_alt .. "'>@candy </span>",
    font = "azukifontB 16",
    widget = wibox.widget.textbox
}

-- !!!!??????????
local hpbd_widget = wibox.widget {
    markup = "<span foreground='" .. beautiful.bg_alt .. "'>up " .. uptime .. " hours </span>",
    font = "azukifontB 16",
    -- forced_height = dpi(42),
    widget = wibox.widget.textbox
}

local fet = wibox.widget {
    {
        {
            user_widget,
            host_widget, 
            -- hpbd_widget,
            {
                -- use loop stupid...
                gen_love(beautiful.bg),
                gen_love(beautiful.fg_alt_alt),
                gen_love(beautiful.bg_alt),
                gen_love(beautiful.bg),
                gen_love(beautiful.fg_alt_alt),
                gen_love(beautiful.bg_alt),
                forced_height = dpi(46),
                layout = wibox.layout.fixed.horizontal
            },
            widget = wibox.layout.fixed.vertical
        },
        widget = wibox.container.place
    },
    fg = beautiful.fg_alt,
    widget = wibox.container.background
}

local quotes = wibox.widget {
    {
        markup = "tell the computer what you\nwant, not what to do.",
        align = "center",
        widget = wibox.widget.textbox
    },
    shape = ifbubble(),
    bg = beautiful.bg_alt,
    forced_width = dpi(400),
    forced_height = dpi(100),
    widget = wibox.container.background
}

local prof = wibox.widget {
    {
        {
            {
                {
                    {
                        fet,
                        nil,
                        pfp,
                        spacing = dpi(20),
                        layout = wibox.layout.align.horizontal
                    },
                    right = dpi(32),
                    left = dpi(16),
                    widget = wibox.container.margin
                },
                quotes,
                spacing = dpi(6),
                layout = wibox.layout.fixed.vertical
            },
            top = dpi(24),
            right = dpi(24),
            left = dpi(24), 
            widget = wibox.container.margin
        },
        widget = wibox.container.place
    },
    bg = beautiful.fg,
    forced_height = dpi(250),
    widget = wibox.container.background
}

return prof
