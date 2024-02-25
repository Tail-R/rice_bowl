pcall(require, "luarocks.loader")

local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

require("snow/err_hand")

beautiful.init("~/.config/awesome/flower/themes/arctic/theme.lua")

require("snow/set_wall")
require("snow/user")

require("flower/widgets/menu")
require("flower/widgets/bar")
require("flower/widgets/sidebar")

require("snow/binds")
require("moon/rules")

require("flower/widgets/decor")
require("flower/widgets/notif")

require("moon/signals/mpris")

awful.spawn.with_shell(os.getenv("HOME") .. "/.config/awesome/snow/autostart")


