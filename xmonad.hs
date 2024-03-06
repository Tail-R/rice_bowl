{--

    ~~~~~ dependencies ~~~~~
    xmobar          - tiny bar that especially made for xmonad
    alacritty       - blazing fast terminal
    urxvt           - i use it since alacritty does not support img preview
    dmenu           - simple app launcher
    pamixer         - control system volume
    brightnessctl   - increase and decrease the monitor's brightness
    picom           - prevent the Xorg tearing. idk if i like this... ToT
    fcitx5          - japanese imput method that just working lol
    azukifontB      - my favorit adrable japanese font

--}

import XMonad
import XMonad.Util.EZConfig
    (
        additionalKeysP,
        removeKeysP
    )

import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers

import XMonad.Layout.ThreeColumns

import Graphics.X11.ExtraTypes.XF86
    (
        xF86XK_AudioMute,
        xF86XK_AudioLowerVolume,
        xF86XK_AudioRaiseVolume,
        xF86XK_MonBrightnessDown,
        xF86XK_MonBrightnessUp
    )

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

-- User settings
myModMask = mod4Mask
myTerminal = "alacritty"
myFocusFollowsMouse = True
myBorderWidth = 1
myNormalBorderColor = "#a77580"
myFocusedBorderColor = "#ff0000"
-- myWorkspaces = ["少", "女", "休", "憩", "中"]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Layouts
myLayout = tiled ||| threeCol ||| Full
    where
        tiled = Tall nmaster delta ratio
        threeCol = ThreeColMid nmaster delta ratio
        nmaster = 1
        delta = 1/25
        ratio = 1/2

-- Autorun
myStartupHook = do
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "~/.fehbg"
    spawnOnce "fcitx5"

-- Glue settings as a var
myConfig = def
    {
        modMask = myModMask,
        terminal = myTerminal,
        focusFollowsMouse = myFocusFollowsMouse,
        borderWidth = myBorderWidth,
        normalBorderColor = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        workspaces = myWorkspaces,

        layoutHook = myLayout,
        startupHook = myStartupHook
    }
    `removeKeysP`
    [
        ("M-S-c"),
        ("M-S-<Return>")
    ]
    `additionalKeysP`
    [
        ("M-q", kill),
        ("M-r", spawn "xmonad --recompile && xmonad --restart"),
        ("M-<Return>", spawn myTerminal),
        ("M-d", spawn "dmenu_run"),
       
        -- volume
        ("<XF86AudioMute>", spawn "pamixer --toggle-mute"),
        ("<XF86AudioLowerVolume>", spawn "pamixer --decrease 2"),
        ("<XF86AudioRaiseVolume>", spawn "pamixer --increase 2"),
        
        -- brightness
        ("<XF86MonBrightnessDown>", spawn "brightnessctl set 2-%"),
        ("<XF86MonBrightnessUp>", spawn "brightnessctl set +2%")
    ]

-- XMobar
myXmobarPP :: PP
myXmobarPP = def
    {
        ppCurrent = bar_fg_normal . wrap "[" "]",
        ppHidden = bar_fg_normal,
        ppHiddenNoWindows = bar_fg_light,
        ppSep = bar_fg_normal " : ",
        ppLayout = bar_fg_normal,
        ppOrder = \[ws, l, _] -> [ws, l]
    }
    where
        bar_fg_normal = xmobarColor "#776677" ""
        bar_fg_light = xmobarColor "#aa909a" ""

-- Main
main :: IO ()
main = xmonad
    $ ewmhFullscreen
    $ ewmh
    -- spawn xmobar with my specified PP
    $ withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

