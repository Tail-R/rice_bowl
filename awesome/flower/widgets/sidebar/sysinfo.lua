local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local cairo = require("lgi").cairo

local xres = require("beautiful.xresources")
local dpi = xres.apply_dpi

local bat_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/bat -v"
local vol_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/vol -v"
local vol_icon_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/vol -i"
local disp_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/disp -v"
local weat_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/weather -t"
local weat_con_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/weather -c"
local weat_locale_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/weather -l"
local disc_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/disc"
local wifi_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/network.sh -ssid"
local blue_cmd = os.getenv("HOME") .. "/.config/awesome" .. "/moon/bin/bluetooth.sh -d"

local disc_usage = 32

local is_int = function(str)
    return not (str == "" or string.find(str, "%D"))
end

local rrect = function(n)
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, n)
    end
end

local ifbubble = function()
    return function(cr, w, h, r, as, ap)
        gears.shape.transform(gears.shape.infobubble)
        : translate(10, 5) (cr, 380, 80, 8, 12, 32)
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

local bat = wibox.widget {
    markup = "?",
    font = "azukifontB 20",
    align = "center",
    forced_width = dpi(30),
    widget = wibox.widget.textbox
}

local bat_num = wibox.widget {
    markup = "?",
    font = "azukifontB 18",
    widget = wibox.widget.textbox
}

local vol = wibox.widget {
    markup = "?",
    font = "azukifontB 20",
    align = "center",
    forced_width = dpi(30),
    widget = wibox.widget.textbox
}

local vol_num = wibox.widget {
    markup = "?",
    font = "azukifontB 18",
    widget = wibox.widget.textbox
}

local disp = wibox.widget {
    markup = "󰖨 ",
    font = "azukifontB 20",
    align = "center",
    forced_width = dpi(30),
    widget = wibox.widget.textbox
}

local disp_num = wibox.widget {
    markup = "?",
    font = "azukifontB 18",
    widget = wibox.widget.textbox
}

local weat_num = wibox.widget {
    markup = "?",
    font = "Inconsolata, Bold 47",
    align = "center",
    widget = wibox.widget.textbox
}

local weat_icon = wibox.widget {
    markup = "󰔄 ",
    font = "Inconsolata 42",
    align = "center",
    widget = wibox.widget.textbox
}

local weat_con = wibox.widget {
    markup = "?",
    font = "azukifontB, 18",
    align = "center",
    widget = wibox.widget.textbox
}

local weat_locale = wibox.widget {
    markup = "?",
    font = "azukifontB, Bold 18",
    align = "center",
    widget = wibox.widget.textbox
}

local gen_box = function(box, box_num)
    return wibox.widget {
        {
            {
                {
                    {
                        {
                            box,
                            nil,
                            nil,
                            layout = wibox.layout.align.vertical
                        },
                        nil,
                        {
                            nil,
                            nil,
                            box_num,
                            layout = wibox.layout.align.vertical 
                        },
                        layout = wibox.layout.align.horizontal 
                    },
                    top = dpi(6),
                    right = dpi(8),
                    bottom = dpi(6),
                    left = dpi(6),
                    widget = wibox.container.margin
                },
                fg = beautiful.fg_alt,
                -- bg = beautiful.bg_alt_alt,
                bg = beautiful.fg,
                shape = rrect(9),
                widget = wibox.container.background,
            },
            margins = dpi(3),
            widget = wibox.container.margin
        },
        bg = beautiful.fg_alt_alt,
        shape = rrect(12),
        forced_width = dpi(100),
        forced_height = dpi(100),
        widget = wibox.container.background
    }
end

local gen_grad = function(size)
    local new_sf = cairo.ImageSurface.create(cairo.Format.ARGB32, size, size)

    pttr = gears.color.create_pattern {
        type = "linear",
        from = { 0, 0 },
        to = { 0, size },
        stops = {
            { 0,    beautiful.bg_alt_alt .. "44" },
            { 0.25, beautiful.bg_alt_alt .. "66" },
            { 0.5,  beautiful.bg_alt_alt .. "88" },
            { 0.75, beautiful.bg_alt_alt .. "cc" },
            { 1,    beautiful.bg_alt_alt .. "cc" }
        }
    }
    
    local cr = cairo.Context(new_sf)

    cr:set_source(pttr)
    cr:paint()

    return new_sf
end

local wifi = wibox.widget {
    markup = "offline",
    font = "azukifontB, Bold 16",
    align = "left",
    widget = wibox.widget.textbox
}

local blue = wibox.widget {
    markup = "offline",
    font = "azukifontB, Bold 16",
    align = "left",
    widget = wibox.widget.textbox
}

local waifu_widget = wibox.widget {
    {
        {
            {
                {
                    image = scale_sf(
                        gears.surface.load_uncached(
                            os.getenv("HOME") .. "/Pictures/artworks" .. "/sroll.jpg"
                        ), dpi(274 - 12)
                    ),
                    clip_shape = rrect(8),
                    forced_width = dpi(274 - 12),
                    forced_height = dpi(274 - 12),
                    opacity = 0.75,
                    widget = wibox.widget.imagebox
                },
                {
                    image = gen_grad(dpi(274 - 12)),
                    clip_shape = rrect(8),
                    forced_width = dpi(274 - 12),
                    forced_height = dpi(274 - 12),
                    widget = wibox.widget.imagebox,
                },
                {
                    {
                        nil,
                        nil,
                        {
                            {
                                {
                                    {
                                        {
                                            {
                                                markup = "lan",
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
                                    halign = "left",
                                    widget = wibox.container.place
                                },
                                wifi,
                                nil,
                                spacing = dpi(12),
                                layout = wibox.layout.fixed.horizontal
                            },
                            {
                                {
                                    {
                                        {
                                            {
                                                markup = "bth",
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
                                    halign = "left",
                                    widget = wibox.container.place
                                },
                                blue,
                                nil,
                                spacing = dpi(12),
                                layout = wibox.layout.fixed.horizontal
                            },
                            spacing = dpi(18),
                            layout = wibox.layout.fixed.vertical
                        },
                        layout = wibox.layout.align.vertical
                    },
                    margins = dpi(16),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.stack
            },
            fg = beautiful.fg_alt,
            bg = beautiful.fg,
            shape = rrect(8),
            widget = wibox.container.background
        },
        margins = dpi(6),
        widget = wibox.container.margin
    },
    bg = beautiful.bg_alt_alt,
    shape = rrect(12),
    forced_width = dpi(274),
    forced_height = dpi(274),
    widget = wibox.container.background
}

local wether_widget = wibox.widget {
    {
        {
            {
                {
                    {
                        {
                            markup = "<span foreground = '" .. beautiful.fg_alt_alt .. "'>󰅟 </span>",
                            font = "azukifontB, 74",
                            align = "center",
                            widget = wibox.widget.textbox
                        },
                        top = dpi(0),
                        right = dpi(128),
                        bottom = dpi(0),
                        widget = wibox.container.margin
                    },
                    {
                        nil,
                        nil,
                        {
                            {
                                {
                                    nil,
                                    nil,
                                    weat_locale,
                                    layout = wibox.layout.align.horizontal
                                },
                                {
                                    nil,
                                    nil,
                                    weat_con,
                                    layout = wibox.layout.align.horizontal
                                },
                                spacing = dpi(3),
                                layout = wibox.layout.fixed.vertical
                            },
                            nil,
                            {
                                nil,
                                nil,
                                {
                                    weat_num,
                                    weat_icon,
                                    nil,
                                    spacing = dpi(3),
                                    layout = wibox.layout.fixed.horizontal
                                },
                                layout = wibox.layout.align.horizontal
                            },
                            layout = wibox.layout.align.vertical
                        },
                        layout = wibox.layout.align.horizontal
                    },
                    layout = wibox.layout.stack
                },
                top = dpi(12),
                right = dpi(12),
                bottom = dpi(0),
                widget = wibox.container.margin
            },
            fg = beautiful.fg_alt_alt,
            bg = beautiful.bg_alt_alt,
            -- bg = beautiful.fg, 
            shape = rrect(6),
            widget = wibox.container.background
        },
        margins = dpi(0),
        widget = wibox.container.margin
    },
    bg = beautiful.fg_alt_alt,
    shape = rrect(8),
    forced_width = dpi(260),
    forced_height = dpi(140),
    widget = wibox.container.background
}

local disc = wibox.widget {
    {
        {
            {
                value = disc_usage,
                max_value = 100,
                min_value = 0,
                thickness = dpi(10),
                start_angle = 0,
                bg = beautiful.fg,
                colors = {
                    beautiful.fg_alt_alt
                },
                rounded_edge = true,
                widget = wibox.container.arcchart
            },
            {
                {
                    markup = "<span foreground = '" .. beautiful.bg .. "'>" .. "󰉚 </span>",
                    font = "azukifontB 18",
                    align = "center",
                    widget = wibox.widget.textbox
                },
                widget = wibox.container.place
            },
            layout = wibox.layout.stack
        },
        bottom = dpi(6),
        widget = wibox.container.margin
    },
    forced_width = dpi(80),
    forced_height = dpi(80),
    bg = beautiful.bg_alt_alt,
    widget = wibox.container.background
}

local sysinfo = wibox.widget {
    {   
        {
            { -- hard info
                nil,
                nil,
                {
                    disc,
                    gen_box(vol, vol_num),
                    gen_box(disp, disp_num),
                    gen_box(bat, bat_num),
                    spacing = dpi(16), 
                    layout = wibox.layout.fixed.vertical
                },
                layout = wibox.layout.align.vertical
            },
            {
                {
                    nil,
                    nil,
                    {
                        nil,
                        {
                            wether_widget,
                            nil,
                            nil,
                            layout = wibox.layout.align.horizontal
                        },
                        waifu_widget,
                        spacing = dpi(16),
                        layout = wibox.layout.fixed.vertical
                    },
                    -- {
                    --     nil,
                    --     {
                    --         gen_box(bat, bat_num),
                    --         {
                    --             gen_box(bat, bat_num),
                    --             nil,
                    --             nil,
                    --             layout = wibox.layout.align.horizontal
                    --         },
                    --         nil,
                    --         spacing = dpi(16),
                    --         layout = wibox.layout.fixed.horizontal
                    --     },
                    --     nil,
                    --     spacing = dpi(16), 
                    --     layout = wibox.layout.fixed.vertical
                    -- },
                    layout = wibox.layout.align.vertical
                },
                nil,
                nil,
                layout = wibox.layout.align.horizontal
            },
            nil,
            spacing = dpi(16), 
            layout = wibox.layout.fixed.horizontal
        },
        right = dpi(32),
        bottom = dpi(32),
        left = dpi(32), 
        widget = wibox.container.margin
    },
    -- bg = beautiful.fg,
    bg = beautiful.bg_alt_alt,
    forced_height = dpi(480),
    widget = wibox.container.background
}

local upd_bat = function()
    awful.spawn.easy_async(bat_cmd, function(stdout)
        local val = tonumber(stdout)

        if is_int(val) then
            if val > 80 then
                bat.markup = " "
            elseif val > 60 then
                bat.markup = " "
            elseif val > 40 then
                bat.markup = " "
            elseif val > 20 then
                bat.markup = " "
            else
                bat.markup = " "
            end
            bat_num.markup = "<span foreground ='" .. beautiful.bg_alt .. "'>" .. val .. "%</span>"
        else
            bat.markup = "!"
            bat_num.markup = "!"
        end
    end)
end

local upd_vol = function()
    awful.spawn.easy_async(vol_cmd, function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        if str ~= "" then
            vol_num.markup = "<span foreground ='" .. beautiful.bg_alt .. "'>" .. str .. "%</span>"
        end
    end)
end

local upd_vol_icon = function()
    awful.spawn.easy_async(vol_icon_cmd, function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        if str ~= "" then
            vol.markup = str .. " "
        end
    end)
end

local upd_disp = function()
    awful.spawn.easy_async(disp_cmd, function(stdout)
        local str = stdout
        str = str:gsub("\n", "")
        
        if str ~= "" then
            disp_num.markup = "<span foreground ='" .. beautiful.bg_alt .. "'>" .. str .. "%</span>"
        end
    end)
end

local upd_disc = function()
    awful.spawn.easy_async(disc_cmd, function(stdout)
        local val = stdout:gsub("\n", "")
        
        if str ~= "" then
            disc_usage = val 
        end
    end)
end

local upd_weat = function()
    awful.spawn.easy_async(weat_cmd, function(temp)
        temp = temp:gsub("\n", "")
        weat_num.markup = temp
    end)
    
    awful.spawn.easy_async(weat_con_cmd, function(con)
        con = con:gsub("\n", "")
        weat_con.markup = "<span foreground='" .. beautiful.bg_alt .. "'>" .. con .. "</span>"
    end)
    
    awful.spawn.easy_async(weat_locale_cmd, function(locale)
        locale = locale:gsub("\n", "")
        weat_locale.markup = "<span foreground='" .. beautiful.fg_alt .. "'>" .. locale .. "</span>"
    end)
end

local upd_wifi = function()
    awful.spawn.easy_async(wifi_cmd, function(stdout)
        stdout = stdout:gsub("\n", "")
        wifi.markup = stdout
    end)
end

local upd_blue = function()
    awful.spawn.easy_async(blue_cmd, function(stdout)
        stdout = stdout:gsub("\n", "")
        blue.markup = stdout
    end)
end

gears.timer {
    timeout = 2,
    call_now = true,
    autostart = true,
    callback = function()
        upd_bat()
        upd_vol()
        upd_vol_icon()
        upd_disp()
        upd_wifi()
        upd_blue()
    end
}

gears.timer {
    timeout = 3600,
    call_now = true,
    autostart = true,
    callback = function()
        upd_weat()
        -- upd_disc()
    end
}

return sysinfo
