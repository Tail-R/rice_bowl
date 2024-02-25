local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local cairo = require("lgi").cairo

local beautiful = require("beautiful")
local xres = require("beautiful.xresources")

local dpi = xres.apply_dpi

local is_int = function(str)
    return not (str == "" or string.find(str, "%D"))
end

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end
end

local get_cover = os.getenv("HOME") .. "/.config/awesome/moon/bin/mpris -c"
local get_title = "playerctl metadata --format '{{ title }}'"
local get_artist = "playerctl metadata --format '{{ artist }}'"

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end
end

local scale_sf = function(sf)
    local size = 256
    local new_sf = cairo.ImageSurface(cairo.Format.ARGB32, size, size)
    local cr = cairo.Context(new_sf)
    local w = sf.width
    local h = sf.height

    if w >= h then
        local ratio = size / h
        cr:translate((w - h) * -0.5, 0)
        cr:scale(ratio, ratio)
        cr:set_source_surface(sf, 0, 0)
    else
        local ratio = size / w
        cr:translate(0, (h - w) * -0.5)
        cr:scale(ratio, ratio)
        cr:set_source_surface(sf, 0, 0)
    end

    cr:paint()

    return new_sf
end

local move_to_up = function(sf)
    local old_w, old_h = gears.surface.get_size(surf)

    local new_sf = cairo.ImageSurface(cairo.Format.ARGB32, 256, 256)
    local cr_new_sf = cairo.Context(new_sf)

    cr_new_sf:set_source_surface(sf, 0, -100)
    cr_new_sf:paint()

    return new_sf
end

local cover_widget = wibox.widget {
    image = scale_sf(gears.surface.load_uncached(beautiful.default_cover)),
    opacity = 0.25,
    resize = false,
    clip_shape = rrect(),
    forced_width = dpi(256),
    widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
    markup = "󰝚  offline",
    align = "center",
    forced_height = dpi(30),
    forced_width = dpi(220),
    widget = wibox.widget.textbox
}

local toggle_widget = wibox.widget {
    markup = "󰏥 ",
    font = "azukifontB 20",
    widget = wibox.widget.textbox 
}

local player = wibox.widget {
    {
        cover_widget,
        {
            title_widget,
            -- right = dpi(6), 
            -- left = dpi(6),
            widget = wibox.container.margin
        },
        layout = wibox.layout.stack
    },
    bg = beautiful.bg,
    forced_width = dpi(256),
    widget = wibox.container.background
}

local upd_cover = function()
    awful.spawn.easy_async_with_shell(get_cover, function(stdout)
        local img_path = stdout
        
        img_path = img_path:gsub("\n", "")
        
        if img_path ~= "" then
            local sf = gears.surface.load_uncached(img_path)
            cover_widget.image = scale_sf(sf)
        else
            cover_widget.image = scale_sf(
                gears.surface.load_uncached(
                    beautiful.default_cover
                )
            )
        end 
    end)
end

local upd_title = function()
    awful.spawn.easy_async_with_shell(get_title, function(stdout)
        local str = stdout
        
        str = str:gsub("%s+", "")
        
        if str ~= "" then
            title_widget.markup = str
        end
    end)
end

gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        upd_cover()
        upd_title()
    end
}

return player
