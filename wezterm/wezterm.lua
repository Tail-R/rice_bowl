local wezterm = require 'wezterm'
local act = wezterm.action

local C = {}

C.base = {}
C.base[1] = '#776677'
C.base[2] = '#a77580'
C.base[3] = '#aa909a'
C.base[4] = '#ada9a9'
C.base[5] = '#909bb0'
C.base[6] = '#eabcbc'
C.base[7] = '#9f9ebe'
C.base[8] = '#fff5f5'
C.fg = C.base[1]
C.bg = C.base[8]

local config = {}

-- general
config.window_close_confirmation = 'NeverPrompt'

-- key binds
config.keys = {
    -- open new tab
    {
        key = 't',
        mods = 'CTRL',
        action = act.SpawnTab 'CurrentPaneDomain',
    },
    -- close tab
    {
        key = 'w',
        mods = 'CTRL',
        action = act.CloseCurrentTab { confirm = false },
    },
}

-- tab switching 
for i = 1, 4 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'CTRL',
        action = act.ActivateTab(i - 1),
    })
end

-- font
config.font = wezterm.font 'azukifontB'

config.font_size = 13

-- padding
config.window_padding = {
    left    = 32,
    right   = 32,
    top     = 32,
    bottom  = 32,
}

-- theme
config.colors = {
    foreground = C.fg,
    background = C.bg,
    
    cursor_fg = C.base[8],
    cursor_bg = C.base[2],
    
    -- this will appear when the terminal become inactive
    cursor_border = C.base[2],

    selection_fg = 'black',
    selection_bg = 'yellow',

    ansi = C.base,
    brights = C.base,

    -- tab bar theme
    tab_bar = {
        inactive_tab_edge = C.fg,
        
        background = C.bg,

        active_tab = {
            fg_color = C.base[8],
            bg_color = C.base[3],
        },

        inactive_tab = {
            fg_color = C.base[8],
            bg_color = C.base[1],
        },
        
        inactive_tab_hover = {
            fg_color = C.base[8],
            bg_color = C.base[2],
        },

        new_tab = {
            fg_color = C.base[8],
            bg_color = C.base[3],
        },

        new_tab_hover = {
            fg_color = C.base[8],
            bg_color = C.base[2],
        },
    },
}

-- tab bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.show_tabs_in_tab_bar = true
config.tab_bar_at_bottom = false
config.tab_max_width = 16 -- it will be disabled when i using fancy tab bar
config.use_fancy_tab_bar = true

-- window frame
config.window_frame = {
    -- title bar
    font = wezterm.font { family = 'azukifontB', weight = 'Bold' },
    font_size = 12.0,

    active_titlebar_bg = C.fg,
    inactive_titlebar_bg = C.fg,

    -- borders
    border_top_height = '3',
    border_right_width = '3',
    border_bottom_height = '3',
    border_left_width = '3',

    border_top_color = C.fg,
    border_right_color = C.fg,
    border_bottom_color = C.fg,
    border_left_color = C.fg,
}

return config
