local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local cairo = require("lgi").cairo

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local get_cover = os.getenv("HOME") .. "/.config/awesome/moon/bin/mpris -c"
local get_title = "playerctl metadata --format '{{ title }}'"
local get_artist = "playerctl metadata --format '{{ artist }}'"
local get_player = os.getenv("HOME") .. "/.config/awesome/moon/bin/mpris -p"

local rrect = function(n)
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
end

local scale_sf = function(sf)
    local size = 50
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

local gen_grad = function(width, height)
    local new_sf = cairo.ImageSurface.create(cairo.Format.ARGB32, width, height)

    pttr = gears.color.create_pattern {
        type = "linear",
        from = { 0, 0 },
        to = { width, 0 },
        stops = {
            { 0,    beautiful.bg_alt_alt .. "ff" },
            { 0.25, beautiful.bg_alt_alt .. "dd" },
            { 0.5,  beautiful.bg_alt_alt .. "bb" },
            { 0.75, beautiful.bg_alt_alt .. "99" },
            { 1,    beautiful.bg_alt_alt .. "77" }
        }
    }
    
    local cr = cairo.Context(new_sf)

    cr:set_source(pttr)
    cr:paint()

    return new_sf
end

local scale_sf_bg = function(sf)
    local size = 360
    local new_sf = cairo.ImageSurface(cairo.Format.ARGB32, size, 149)
    local cr = cairo.Context(new_sf)
    local w = sf.width
    local h = sf.height

    local ratio = size / h
    cr:scale(ratio, ratio)
    cr:set_source_surface(sf, 0, -50)
    cr:paint()

    return new_sf
end

local title_widget = wibox.widget {
    markup = "󰝚  offline",
    font = "azukifontB, Bold 14",
    align = "left",
    forced_height = dpi(25),
    forced_width = dpi(240),
    widget = wibox.widget.textbox
}

local cover_widget = wibox.widget {
    image = scale_sf(gears.surface.load_uncached(beautiful.default_cover)),
    opacity = 1,
    resize = true,
    forced_width = dpi(50),
    forced_height = dpi(50),
    clip_shape = rrect(8),
    widget = wibox.widget.imagebox
}

local cover_widget_bg = wibox.widget {
    image = scale_sf_bg(gears.surface.load_uncached(beautiful.default_cover)),
    clip_shape = rrect(8),
    opacity = 0.095, 
    widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
    markup = "󰝚  offline",
    font = "azukifontB, Bold 14",
    align = "left",
    forced_height = dpi(25),
    forced_width = dpi(240),
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = "unknown",
    font = "azukifontB 12",
    align = "left",
    forced_height = dpi(25),
    forced_width = dpi(240),
    widget = wibox.widget.textbox
}

local player_widget = wibox.widget {
    markup = "󰝚  no player",
    font = "azukifontB, Bold 16",
    align = "center",
    widget = wibox.widget.textbox
}

local probar_widget = wibox.widget {
    max_value = 1,
    value = 0.33,
    color = beautiful.bg,
    background_color = beautiful.fg,
    forced_height = dpi(10),
    forced_width = dpi(100),
    widget = wibox.widget.progressbar
}

local toggle_widget = wibox.widget {
    markup = "󰏤",
    font = "azukifontB 26",
    align = "center",
    widget = wibox.widget.textbox
}

local prev_widget = wibox.widget {
    markup = "󰒮",
    font = "azukifontB 26",
    align = "center",
    widget = wibox.widget.textbox
}

local next_widget = wibox.widget {
    markup = "󰒭",
    font = "azukifontB 26",
    align = "center",
    widget = wibox.widget.textbox
}

local music = wibox.widget {
    {
        {
            {
                {
                    {
                        layout = wibox.layout.align.vertical
                    },
                    bg = beautiful.bg_alt_alt,
                    shape = rrect(),
                    widget = wibox.container.background
                },
                cover_widget_bg,
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            {
                                                markup = "player",
                                                widget = wibox.widget.textbox
                                            },
                                            top = dpi(6),
                                            right = dpi(12),
                                            bottom = dpi(6),
                                            left = dpi(12),
                                            widget = wibox.container.margin
                                        },
                                        fg = beautiful.bg_alt,
                                        bg = beautiful.fg,
                                        shape = rrect(),
                                        widget = wibox.container.background
                                    },
                                    spacing = dpi(12),
                                    player_widget,
                                    layout = wibox.layout.fixed.horizontal
                                },
                                nil,
                                nil,
                                layout = wibox.layout.align.horizontal
                            },
                            nil,
                            {
                                cover_widget,
                                {
                                    {
                                        title_widget,
                                        artist_widget,
                                        nil,
                                        -- {
                                        --     forced_height = dpi(20),
                                        --     layout = wibox.layout.align.vertical
                                        -- },
                                        widget = wibox.layout.fixed.vertical
                                    },
                                    widget = wibox.container.place
                                },
                                nil,
                                spacing = dpi(12),
                                widget = wibox.layout.fixed.horizontal
                            },
                            spacing = dpi(12),
                            widget = wibox.layout.fixed.vertical
                        },
                        top = dpi(24),
                        right = dpi(12),
                        bottom = dpi(24),
                        left = dpi(32), 
                        widget = wibox.container.margin 
                    },
                    forced_width = dpi(360),
                    -- bg = beautiful.bg_alt_alt,
                    shape = rrect(6),
                    widget = wibox.container.background 
                },
                layout = wibox.layout.stack
            },
            halign = "left",
            valign = "center",
            widget = wibox.container.place
        },
        left = dpi(50),
        widget = wibox.container.margin
    },
    fg = beautiful.fg_alt,
    -- bg = beautiful.bg,
    forced_height = dpi(149),
    widget = wibox.container.background
}

-- stupid polling timer section... i dont have time to improve it yet...
local upd_cover = function()
    awful.spawn.easy_async_with_shell(get_cover, function(stdout)
        local img_path = stdout
        
        img_path = img_path:gsub("%s+", "")
        
        if img_path ~= "" then
            local sf = gears.surface.load_uncached(img_path)
            cover_widget.image = scale_sf(sf)
            cover_widget_bg.image = scale_sf_bg(sf)
        else
            local sf = gears.surface.load_uncached(beautiful.default_cover)
            cover_widget.image = scale_sf(sf)
            cover_widget_bg.image = scale_sf_bg(sf)
        end 
    end)
end

local upd_title = function()
    awful.spawn.easy_async_with_shell(get_title, function(stdout)
        local str = stdout
        
        if str ~= "" then
            title_widget.markup = str
        end
    end)
end

local upd_artist = function()
    awful.spawn.easy_async_with_shell(get_artist, function(stdout)
        local str = stdout
        
        if str ~= "" then
            artist_widget.markup = "<span foreground='" .. beautiful.fg_alt .. "'>" .. str .. "</span>"
        end
    end)
end

local upd_player = function()
    awful.spawn.easy_async_with_shell(get_player, function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        if str ~= "" then
            player_widget.markup = "<span foreground='" .. beautiful.fg_alt .. "'>" .. str .. "</span>"
        end
    end)
end

awesome.connect_signal("custom::mpris::cover", function(arturl)
    arturl = arturl:gsub("\n", "")

    if arturl ~= "" then
        local sf = gears.surface.load_uncached(arturl)
        cover_widget.image = scale_sf(sf)
        cover_widget_bg.image = scale_sf_bg(sf)
    else
        local sf = gears.surface.load_uncached(beautiful.default_cover)
        cover_widget.image = scale_sf(sf)
        cover_widget_bg.image = scale_sf_bg(sf)
    end 
end)

awesome.connect_signal("custom::mpris::title", function(title)
    title_widget.markup = title
end)

awesome.connect_signal("custom::mpris::artist", function(artist)
    artist_widget.markup = artist
end)

-- gears.timer {
--     timeout = 2,
--     call_now = true,
--     autostart = true,
--     callback = function()
--         -- upd_cover()
--         -- upd_title()
--         -- upd_artist()
--         upd_player()
--     end
-- }

return music
