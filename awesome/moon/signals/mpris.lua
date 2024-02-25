local awful = require("awful")
local naughty = require("naughty")

local status = [[ bash -c "
    playerctl --follow metadata
"]];

local split = function(str)
    local T = {} 
    
    for elem in str:gmatch("%a+") do
        table.insert(T, elem)
    end

    return T
end

local get_cover  = os.getenv("HOME") .. "/.config/awesome/moon/bin/parse_arturl"
local get_title  = "playerctl metadata --format '{{ title }}'" 
local get_artist = "playerctl metadata --format '{{ artist }}'"

awful.spawn.with_line_callback(status, {
    stdout = function(line)
        local metadata = split(line)

        -- emit song cover
        awful.spawn.easy_async_with_shell(get_cover, function(stdout)
            awesome.emit_signal("custom::mpris::cover", stdout)
        end)

        -- emit song title
        awful.spawn.easy_async_with_shell(get_title, function(stdout)
            awesome.emit_signal("custom::mpris::title", stdout)
        end)
        
        -- emit song artist
        awful.spawn.easy_async_with_shell(get_artist, function(stdout)
            awesome.emit_signal("custom::mpris::artist", stdout)
        end)
    end
})
