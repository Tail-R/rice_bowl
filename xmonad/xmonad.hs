{--

    ~~~~~ dependencies ~~~~~
    xmobar          - tiny bar that especially made for xmonad
    alacritty       - blazing fast terminal
    urxvt           - i use it since alacritty does not support img preview
    nemo            - gui filemanager
    dmenu           - simple app launcher
    pamixer         - control system volume
    brightnessctl   - increase and decrease the monitor's brightness
    picom           - prevent the Xorg tearing. idk if i like this... ToT
    mpd             - such a nice music daemon
    ncmpcpp         - beautiful mpd client
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
import XMonad.Layout.Grid

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

-- Colors
fg_normal = "#776677"
fg_dark = "#a77580"
fg_light = "#909bb0"

-- User settings
myModMask = mod4Mask
myHomeDir = "/home/tailr"
myScriptDir = myHomeDir ++ "/.config/xmonad/scripts/" -- literally goes hard

myTerminal = "urxvt"
mySubTerminal = "alacritty"
myFileManager = "nemo"

myFocusFollowsMouse = True
myBorderWidth = 1
myNormalBorderColor = fg_dark
myFocusedBorderColor = fg_light
myWorkspaces = ["少", "女", "休", "憩", "中"]
-- myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Layouts
myLayoutHook = tiled ||| threeCol ||| Grid ||| Full
    where
        tiled = Tall nmaster delta ratio
        threeCol = ThreeColMid nmaster delta ratio
        nmaster = 1
        delta = 1/25
        ratio = 1/2

-- Rules
myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat,
        className =? "Nemo" --> doFloat,
        className =? "feh" --> doFloat,
        className =? "Sxiv" --> doFloat
    ]

-- Autorun
myStartupHook = do
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "xrdb merge ~/.Xresources"
    spawnOnce "~/.fehbg"
    spawnOnce "picom"
    spawnOnce "fcitx5"
    spawnOnce "mpd"

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

        layoutHook = myLayoutHook,
        manageHook = myManageHook,
        startupHook = myStartupHook
    }
    `removeKeysP`
    [
        ("M-S-c")
    ]
    `additionalKeysP`
    [
        -- general
        ("M-q", kill),
        ("M-r", spawn "xmonad --recompile && xmonad --restart"),
        
        -- my apps
        ("M-<Return>", spawn myTerminal),
        ("M-S-<Return>", spawn mySubTerminal),
        ("M-f", spawn myFileManager),
        ("M-d", spawn $ myScriptDir ++ "run.sh"),
        ("M-s", spawn $ myScriptDir ++ "ss.sh -f"),
        ("M-S-s", spawn $ myScriptDir ++ "ss.sh -s"),
       
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
        ppCurrent = bar_fg_dark,
        ppHidden = bar_fg_normal,
        ppHiddenNoWindows = bar_fg_light,
        ppSep = bar_fg_normal " | ",
        ppLayout = bar_fg_normal . wrap "" "",
        ppOrder = \[ws, l, _] -> [ws, l]
    }
    where
        bar_fg_dark = xmobarColor fg_dark ""
        bar_fg_normal = xmobarColor fg_normal ""
        bar_fg_light = xmobarColor fg_light ""

-- Main
main :: IO ()
main = xmonad
    $ ewmhFullscreen
    $ ewmh
    -- spawn xmobar with my specified PP
    $ withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
