local awful = require("awful")
local gears = require("gears")

local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

local modkey = require("snow/user/mod")
local bin_dir = os.getenv("HOME") .. "/.config/awesome/moon/bin/"
local A = require("snow/user/apps")


globalkeys = gears.table.join(
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    
    awful.key({ modkey,           }, "s", function () awful.spawn.easy_async(bin_dir .. "ss -f") end,
              {description = "screenshot", group = "script"}),
    
    awful.key({ modkey,           }, "n", function () awful.spawn(A.music) end,
              {description = "music", group = "launcher"}),
    
    awful.key({ modkey,           }, "o", function () sidebar:toggle() end,
              {description = "launch sidebar", group = "summon_widget"}),
   
    awful.key({ modkey,           }, "m", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    awful.key({ modkey,           }, "Return", function () awful.spawn(A.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    
    awful.key({ modkey,           }, "t", function () awful.spawn(A.gui_fm) end,
              {description = "open a terminal", group = "launcher"}),
    
    awful.key({ modkey            }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    
    awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
     
    awful.key({ modkey }, "d", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    
    awful.key({ modkey            }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    

    awful.key({}, "XF86AudioMute",
        function ()
            awful.spawn.with_shell("pamixer --toggle-mute")
        end),
    
    awful.key({}, "XF86AudioLowerVolume",
        function ()
            awful.spawn.with_shell("pamixer --decrease 2")
        end),

    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            awful.spawn.with_shell("pamixer --increase 2")
        end),

    awful.key({}, "XF86MonBrightnessDown",
        function ()
            awful.spawn.with_shell("brightnessctl s 5-%")
        end),
    
    awful.key({}, "XF86MonBrightnessUp",
        function ()
            awful.spawn.with_shell("brightnessctl s +5%")
        end)
)

-- client, focus movement
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})    
    )
end

root.keys(globalkeys)


