local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")

local HOME = os.getenv("HOME")

local w_dir = HOME .. "/Pictures/wallpapers/"
local w_name = "quartz.jpg"
-- local w_name = "white.png"
-- local w_name = "FADEE1.png"

local w_off = {
    x = 0,
    y = 0
}

local function set_wallpaper(s)
    local wallpaper = w_dir .. w_name or beautiful.wallpaper
    
    -- gears.wallpaper.maximized(wallpaper, s, false, w_off)
    gears.wallpaper.tiled(wallpaper, s, w_off)
end

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)



