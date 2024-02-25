local gears = require("gears")
local rc_img = gears.color.recolor_image

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_name = "arctic" 
local theme_path = os.getenv("HOME") .. "/.config/awesome/flower/themes/" .. theme_name

local rect = function()
    return function(cr, w, h)
        gears.shape.rectangle(cr, w, h)
    end
end

local rrect = function()
    return function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6) 
    end
end

local theme = {}

-- default font
theme.font = "azukifontB, Bold 16"

-- colors
theme.fg = "#ffffff"
theme.bg = "#c2cce5"
theme.fg_alt = "#8d8d9d"
theme.bg_alt = "#c2c8d5"

theme.fg_alt_alt = "#d2ddf5"
theme.bg_alt_alt = "#f5f5f5"

theme.bg2 = "#b2bcd5"

theme.bg_normal     = theme.bg_alt
theme.bg_focus      = theme.bg
theme.bg_urgent     = theme.bg
theme.bg_minimize   = theme.bg
theme.bg_systray    = theme.bg

theme.fg_normal     = theme.fg
theme.fg_focus      = theme.fg
theme.fg_urgent     = theme.fg
theme.fg_minimize   = theme.fg

-- window
theme.useless_gap   = dpi(6)
theme.border_width  = dpi(0)
theme.border_normal = "#c2c8d5"
theme.border_focus  = "#c2cce5"
theme.border_marked = "#000000"

-- tag module
theme.tag_fg_active = "#8d8d9d"
theme.tag_fg_inactive = "#c2c8d5"
theme.tag_fg_occupied = "#c2cce5"

-- tasklist module
theme.tasklist_fg_normal = theme.bg_alt
theme.tasklist_fg_focus = theme.fg_alt
theme.tasklist_fg_minimize = theme.bg
theme.tasklist_shape = rrect()

-- systray
theme.bg_systray = theme.fg
theme.systray_icon_spacing = dpi(12)

-- notif popup
theme.notification_font = "azukifontB, Bold 16"
-- theme.notification_width = dpi(256)
-- theme.notification_height = dpi(64)
theme.notification_spacing = dpi(20)
theme.notification_border_width = dpi(0)

-- menu
-- theme.menu_submenu_icon =
theme.menu_submenu = "-  "

theme.menu_width  = dpi(178)
theme.menu_height = dpi(32)

theme.menu_fg_normal = theme.bg_alt
theme.menu_bg_normal = theme.fg
theme.menu_fg_focus = theme.fg
theme.menu_bg_focus = theme.bg_alt

-- theme.menu_border_width =
-- theme.menu_border_color =

-- snap
theme.snap_bg = theme.bg
theme.snap_border_width = dpi(12)
theme.snap_shape = rect()
-- theme.snapper_gap =  -- i think it's not working for me...

-- titlebar
theme.titlebar_fg_normal = theme.fg
theme.titlebar_fg_focus = theme.fg

theme.titlebar_bg_normal = theme.bg_alt
theme.titlebar_bg_focus = theme.bg

theme.titlebar_minimize_button_normal_active   = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)
theme.titlebar_minimize_button_normal_inactive = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)

theme.titlebar_close_button_normal = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)
theme.titlebar_close_button_focus  = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)

theme.titlebar_maximized_button_normal_active   = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)
theme.titlebar_maximized_button_normal_inactive = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)
theme.titlebar_maximized_button_focus_inactive  = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)
theme.titlebar_maximized_button_focus_active    = rc_img(theme_path .. "/titlebar/heart.png", theme.fg)

-- border
theme.border_width = dpi(0)
theme.border_normal = theme.fg_alt
theme.border_focus = theme.fg_alt
theme.border_marked = theme.fg_alt

-- layouts module
theme.layout_floating  = rc_img(theme_path .. "/layouts/floatingw.png", theme.fg)
theme.layout_tile      = rc_img(theme_path .. "/layouts/tilew.png", theme.fg)

-- wallpaper
theme.wallpaper = nil

-- pfp
theme.pfp = theme_path .. "/pfp.jpg"

-- default music cover
theme.default_cover = theme_path .. "/player/default_cover.jpg"

-- gen awesome icon
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.fg, theme.bg
)

-- gtk icon
theme.icon_theme = nil
awesome.set_preferred_icon_size(64)

return theme

