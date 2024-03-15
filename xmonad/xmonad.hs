{--
    ~~~~~ dependencies ~~~~~
    xmobar          - tiny bar that especially made for xmonad
    alacritty       - blazingly fast terminal emulator
    urxvt           - old but gold
    yazi            - CLI file manager
    nemo            - GUI file manager
    rofi            - simple app launcher
    pamixer         - control system volume
    brightnessctl   - increase and decrease the monitor's brightness
    picom           - prevent the Xorg tearing. idk if i like this... ToT
    mpd             - such a nice music daemon
    ncmpcpp         - beautiful mpd client
    fcitx5          - Japanese input method that just working lol
    azukifontB      - my favorite adorable Japanese font 
    dunst           - simple notification daemon
--}

import XMonad
import XMonad.Util.EZConfig
    (
        additionalKeysP,
        removeKeysP
    )

import XMonad.Util.SpawnOnce
import XMonad.Util.Loggers

import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Gaps (
        gaps,
        Direction2D(D, L, R, U)
    )

import XMonad.Layout.Spacing
    (
        spacingRaw,
        Border(Border)
    )

import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

import Graphics.X11.ExtraTypes.XF86
    (
        xF86XK_AudioMute,
        xF86XK_AudioLowerVolume,
        xF86XK_AudioRaiseVolume,
        xF86XK_MonBrightnessDown,
        xF86XK_MonBrightnessUp
    )

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import qualified XMonad.StackSet as W


-- Font
myFontName = "xft:azukifontB:size=12:weight=bold"

-- Colors
black   = "#776677"
red     = "#a77580"
green   = "#aa909a"
blue    = "#909bb0"
white   = "#fff5f5"

-- User settings
myModMask = mod4Mask
myScriptDir = "~/scripts/"

myTerminal = "alacritty"
mySubTerminal = "urxvt"
myAppLauncher = myScriptDir ++ "drun.sh"
myFileManager = "nemo"

myFocusFollowsMouse = True
myBorderWidth = 1
myNormalBorderColor = black
myFocusedBorderColor = red
-- myWorkspaces = ["少", "女", "休", "憩", "中"]
myWorkspaces = ["リ", "ラ", "ち", "ゃ", "ん", "の", "休", "日"]

-- Layouts
myLayoutHook =
    gaps
        [
            (L, gap_left),
            (R, gap_right),
            (U, gap_top),
            (D, gap_bottom)
        ]

    $ spacingRaw True (Border gap_in gap_in gap_in gap_in)
        True (Border gap_in gap_in gap_in gap_in)
        True
    
    $ toggleLayouts Full master
    ||| toggleLayouts Full fancyTabbed
    ||| toggleLayouts Full threeCol
    where
        gap_top     = 0
        gap_right   = 0
        gap_bottom  = 0
        gap_left    = 0
        
        gap_in = 0
        
        master = Tall nmaster delta ratio
        threeCol = ThreeColMid nmaster delta ratio
        fancyTabbed = tabbed shrinkText myTabConfig

        nmaster = 1
        delta = 1/25
        ratio = 1/2

myTabConfig = def
    {
        activeColor         = green,
        inactiveColor       = black,
        urgentColor         = red,
        
        activeBorderColor   = blue,
        inactiveBorderColor = blue,
        urgentBorderColor   = blue,
        
        activeBorderWidth   = 0,
        inactiveBorderWidth = 0,
        urgentBorderWidth   = 0,
        
        activeTextColor     = white,
        inactiveTextColor   = white,
        urgentTextColor     = white,
        
        fontName            = myFontName ,
        decoHeight          = 32
    }

-- Rules
myManageHook = composeOne
    [
        className =? "URxvt"    -?> doCenterFloat,
        className =? "Gimp"     -?> doCenterFloat,
        className =? "Nemo"     -?> doCenterFloat,
        className =? "feh"      -?> doCenterFloat,
        className =? "Sxiv"     -?> doCenterFloat
    ]

-- Autorun
myStartupHook = do
    spawnOnce "xsetroot -cursor_name left_ptr"
    spawnOnce "xrdb merge ~/.Xresources"
    spawnOnce "~/.fehbg"
    spawnOnce "picom"
    spawnOnce "dunst -c ~/.config/dunst/dunstrc"
    spawnOnce "fcitx5"
    spawnOnce (myScriptDir ++ "run_mpd.sh")

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

        -- window operation
        ("M-h", windows W.focusUp),
        ("M-j", windows W.focusDown),
        ("M-k", windows W.focusUp),
        ("M-l", windows W.focusDown),
        ("M-m", windows W.swapMaster),

        -- layout operation
        ("M-f", sendMessage (Toggle "Full")),
        
        -- launch apps
        ("M-<Return>", spawn myTerminal),
        ("M-S-<Return>", spawn mySubTerminal),
        ("M-d", spawn myAppLauncher),
        ("M-n", spawn myFileManager),
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
        ppCurrent = bar_red, -- currently active workspace
        ppVisible = bar_black, -- visible but not focused workspace (xinerama only)
        ppHidden = bar_green, -- occupied workspace
        ppHiddenNoWindows = bar_blue, -- inactive workspace
        ppSep = bar_black " : ",
        ppLayout = bar_black,
        ppTitle = bar_black,
        ppOrder = \[ws, l, w] -> [ws]
    }
    where
        bar_black = xmobarColor black ""
        bar_red = xmobarColor red ""
        bar_green = xmobarColor green ""
        bar_blue = xmobarColor blue ""

-- Main
main :: IO ()
main = xmonad
    $ ewmhFullscreen
    $ ewmh
    -- spawn xmobar with my specified PP
    $ withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig
