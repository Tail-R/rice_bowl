local awful = require("awful")
local gears = require("gears")
local beautiful = require ("beautiful")

local menubar = require("menubar")

local A = require("snow/user/apps")

myawesomemenu = {
   { "manual", A.terminal .. " -e man awesome" },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

myfilemenu = {
    { "cli", A.cli_fm },
    { "gui", A.gui_fm }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu },
                                    { "terminal", A.terminal },
                                    { "open file", myfilemenu }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

menubar.utils.terminal = A.terminal
