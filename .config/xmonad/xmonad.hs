import XMonad hiding ( (|||) )
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import Data.Ratio ( (%) )

import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Themes
import XMonad.Util.WorkspaceCompare

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.RefocusLast
import XMonad.Hooks.InsertPosition
-- import XMonad.Hooks.ServerMode
-- import XMonad.Layout.Fullscreen

import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Grid
import XMonad.Layout.Master
import qualified XMonad.Layout.ToggleLayouts as Tog
import XMonad.Layout.Reflect 
import XMonad.Layout.MultiToggle
import XMonad.Layout.TwoPanePersistent
import XMonad.Layout.ThreeColumns
import XMonad.Layout.IndependentScreens

import XMonad.Actions.WithAll
-- import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import qualified XMonad.Actions.FlexibleResize as Flex
import XMonad.Actions.RotSlaves
import XMonad.Actions.FocusNth
import XMonad.Actions.CycleSelectedLayouts
import XMonad.Actions.FloatKeys
import XMonad.Actions.CycleWS
import XMonad.Actions.Commands
-- import XMonad.Actions.LinkWorkspaces

-- check out later
-- https://hackage.haskell.org/package/xmonad-contrib
-- import XMonad.Hooks.Script (autostart script)
-- import XMonad.Hooks.UrgencyHook
-- import XMonad.Actions.LinkWorkspaces 
-- import XMonad.Actions.CopyWindow (alternative to link)
-- import XMonad.Actions.CycleRecentWS (super tab)
-- import XMonad.Actions.CycleWindows (alt tab)
-- import XMonad.Hooks.WorkspaceHistory (super tab?)
-- import XMonad.Actions.GroupNavigation
-- import XMonad.Layout.Groups (extra func?)
-- import XMonad.Actions.PerWorkspaceKeys
-- import XMonad.Actions.WorkspaceNames
--

myTerminal = "st"
myNormalBorderColor  = "#31363b"
myFocusedBorderColor = "#ffd866"
myBorderWidth   = 1
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"] 
-- myWorkspaces    = clickable $ ["0","1","2","3","4","5","6","7","8","9"] 
--    where clickable l = ["<action=`/home/andrew/bin/xmonad/focusdesktop.sh " ++ show (i) ++ "`>" ++ ws ++ "</action>" | (i,ws) <- zip [0..9] l] 
myModMask       = mod4Mask
myFocusFollowsMouse = True


myLayout = refocusLastLayoutHook $ avoidStruts $ lessBorders Screen $ lnorm
           -- Tog.toggleLayouts monocle $ onWorkspaces["2"] l2 $ lnorm
    where
        lnorm = tile ||| mtile ||| two ||| three ||| grid ||| monocle
        -- l2 = two ||| tile ||| mtile ||| three ||| grid 
        gaps = spacingRaw False screenb True windowb True
        gs = 8
        screenb = (Border gs gs gs gs)
        windowb = (Border gs gs gs gs)
        delta = (5/100)
        frac = (1/2)
        rt = ResizableTall 1 delta frac []
        -- rt = Tall 1 delta frac
        -- tile = renamed [Replace "[]=="] $ modWorkspaces["1","6"] gaps $ rt
        tile = renamed [Replace "[]=="] $ rt
        mtile = renamed [Replace "TTTT"] $ Mirror rt
        grid = renamed [Replace "===="] $ GridRatio (4/3)
        two = renamed [Replace "[][]"] $ TwoPanePersistent Nothing delta frac
        three = renamed [Replace "=[]="] $ ThreeColMid 1 delta frac
        monocle = renamed [Replace "[  ]"] $ noBorders Full 

myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    -- , className =? "mpv" --> doFloat
    , className =? "Gimp" --> doFloat
    , className =? "guvcview" --> doFloat
    , className =? "Xephyr" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    -- , insertPosition End Newer
    , insertPosition Master Newer
    ]

myEventHook = composeAll
    [ fullscreenEventHook
    , ewmhDesktopsEventHook
    , docksEventHook
    -- , serverModeEventHook
    -- , serverModeEventHookCmd
    ]

myStartupHook = do
    return()
    spawnOnce "~/bin/core.sh"
    -- spawnOnce "/home/andrew/bin/xmonad/autostart.sh" []
    -- spawnOnce "xmobar"

-- myPP = xmobarPP { ppSep    = " | "
--                 , ppCurrent = xmobarColor "#ffd866" "" . wrap "[" "]"
--                 -- , ppVisible = xmobarColor "#ff5c57" "" . wrap "[" "]"
--                 , ppVisible = xmobarColor "#ffd866" ""
--                 , ppHidden = xmobarColor "#e5e5e5" ""
--                 , ppTitle = xmobarColor "#e5e5e5" "#2b2b2b"
--                 -- , ppHiddenNoWindows = xmobarColor "#a2a2a2" ""
--                 , ppOrder  = \(ws:l:t:_) -> [ws,l,t]
--                 , ppSort = getSortByXineramaRule
--                 }
myPP h s = marshallPP s xmobarPP { ppSep    = " | "
                , ppCurrent = xmobarColor "#ffd866" "" . wrap "[" "]"
                , ppVisible = xmobarColor "#ffd866" "" . wrap "(" ")"
                , ppHidden = xmobarColor "#e5e5e5" ""
                , ppTitle = xmobarColor "#e5e5e5" "#2b2b2b"
                -- , ppHiddenNoWindows = xmobarColor "#a2a2a2" ""
                , ppOrder  = \(ws:l:t:_) -> [ws,l,t]
                , ppSort = getSortByXineramaRule
                , ppOutput = hPutStrLn h
                }

myConfig = ewmh $ docks $ defaultConfig {
    -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,
        keys               = myKeys,
    
    -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        -- logHook            = dynamicLogString myPP >>= xmonadPropLog,
        startupHook        = myStartupHook
    }
    `removeKeysP`
    [ "M-<Space>"
    , "M-n"
    , "M-x"
    , "M-b"
    , "M-<Return>"
    , "M-S-<Return>"
    , "M-S-c"
    , "M-w"
    , "M-e"
    , "M-r"
    , "M-S-w"
    , "M-S-e"
    , "M-S-r"
    , "M-<Tab>"
    , "M-S-<Tab>"
    ]
    `additionalKeysP`
    [ ("M-S-e", io (exitWith ExitSuccess))
    , ("M-S-q", kill) 
    -- , ("M-<Return>", safeSpawn myTerminal [])
    , ("M-S-r", unsafeSpawn "xmonad --recompile; xmonad --restart")
    , ("M-S-h", promote)
    , ("M-<Space>", promote)
    -- , ("M-r", refresh) -- unused
    , ("M-q", refresh) -- unused
    , ("C-M-S-q", killAll)
    , ("M-o", sendMessage NextLayout)
    , ("M-j", windows W.focusDown)
    , ("M-k", windows W.focusUp)
    , ("M-h", windows W.focusMaster)
    , ("M-l", toggleFocus) -- TODO create special hook to ignore master
    , ("M-<Down>", windows W.focusDown)
    , ("M-<Up>", windows W.focusUp)
    , ("M-<Left>", windows W.focusMaster)
    , ("M-<Right>", toggleFocus) 
    , ("M-S-j", windows W.swapDown)
    , ("M-S-k", windows W.swapUp)
    -- , ("M-t", cycleThroughLayouts ["[]==", "[][]"])
    -- , ("M-t", withFocused $ windows . W.sink)
    , ("M-t", withFocused toggleFloat)
    , ("M-S-t", sinkAll)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-f", sendMessage $ JumpToLayout "[  ]")
    , ("M-e", sendMessage $ JumpToLayout "[]==")
    , ("M-d", sendMessage $ JumpToLayout "[][]")
    , ("M-r", sendMessage $ JumpToLayout "TTTT")
    , ("M-<Tab>", toggleWS) -- workspace
    , ("C-M4-<Left>", prevWS)
    , ("C-M4-<Right>", nextWS)
    , ("M-m", nextScreen)
    , ("M-S-m", shiftNextScreen)
    , ("M4-M1-h", sendMessage Shrink)
    , ("M4-M1-l", sendMessage Expand)
    , ("M4-M1-j", sendMessage MirrorShrink)
    , ("M4-M1-k", sendMessage MirrorExpand)
    , ("C-M-S-h", withFocused $ keysResizeWindow (-64, 0) (1%2, 1%2))
    , ("C-M-S-l", withFocused $ keysResizeWindow (64, 0) (1%2, 1%2))
    , ("C-M-S-j", withFocused $ keysResizeWindow (0, -64) (1%2, 1%2))
    , ("C-M-S-k", withFocused $ keysResizeWindow (0, 64) (1%2, 1%2))
    , ("C-M-h", withFocused $ keysMoveWindow (-64, 0))
    , ("C-M-l", withFocused $ keysMoveWindow (64, 0))
    , ("C-M-j", withFocused $ keysMoveWindow (0, 64))
    , ("C-M-k", withFocused $ keysMoveWindow (0, -64))

    -- applications
    , ("M-<Return>", unsafeSpawn "urxvtc || urxvt")
    , ("M-n", safeSpawn "alacritty" [])
    , ("M-p", safeSpawn "/home/andrew/bin/dmenu_run_history.sh" ["dmenu"])
    , ("M-c", safeSpawn "/home/andrew/bin/launch.sh" [])
    , ("M-v", safeSpawn "emacsclient" ["-c", "-a", "emacs"])
    , ("M-S-p", safeSpawn "sudo" ["dmenu_run"])
    , ("M-S-x", safeSpawn "/home/andrew/bin/lock.sh" [])
    , ("M-S-s", safeSpawn "systemctl" ["suspend"])
    , ("M-x M-a", safeSpawn "alacritty" [])
    , ("M-x M-b", safeSpawn "brave" [])
    , ("M-x M-f", safeSpawn "firefox" [])
    , ("M-x M-c", safeSpawn "code" [])
    , ("M-x M-d", safeSpawn "pcmanfm" [])
    , ("M-x M-e", unsafeSpawn "pkill emacs; emacs --daemon")
    , ("M-x M-q", safeSpawn "tabbed" ["-c", "vimb", "-e"])
    , ("M-x M-r", safeSpawn "st" ["-e", "ranger"])
    , ("M-x M-u", safeSpawn "urxvt" [])
    , ("M-x M-z", safeSpawn "/home/andrew/bin/zathura.sh" [])
    , ("<Print>", unsafeSpawn "maim -s | xclip -sel clip -t image/png")
    , ("M-<Print>", unsafeSpawn "maim ~/images/screenshots/$(date +%+4Y-%m-%d_%H%M%S).png")
    , ("S-<Print>", unsafeSpawn "maim -s ~/images/screenshots/$(date +%+4Y-%m-%d_%H%M%S).png")
    , ("M-w M-s", safeSpawn "/home/andrew/bin/wallpaper.sh" [])
    , ("M-w M-a", safeSpawn "/home/andrew/bin/wallpaper.sh"  ["-r"])
    , ("<XF86AudioLowerVolume>", safeSpawn "/home/andrew/bin/volume.sh" ["-5"])
    , ("<XF86AudioRaiseVolume>", safeSpawn "/home/andrew/bin/volume.sh" ["+5"])
    , ("S-<XF86AudioLowerVolume>", safeSpawn "/home/andrew/bin/volume.sh" ["-1"])
    , ("S-<XF86AudioRaiseVolume>", safeSpawn "/home/andrew/bin/volume.sh" ["+1"])
    , ("<XF86AudioMute>", safeSpawn "/home/andrew/bin/volume.sh" ["mute"])
    , ("<XF86AudioPlay>", safeSpawn "/home/andrew/bin/media.sh" ["play"])
    , ("<XF86AudioPrev>", safeSpawn "/home/andrew/bin/media.sh" ["prev"])
    , ("<XF86AudioNext>", safeSpawn "/home/andrew/bin/media.sh" ["next"])
    ]
    `additionalKeys`
    [ ((myModMask, xK_comma), sendMessage (IncMasterN 1))
    , ((myModMask, xK_period), sendMessage (IncMasterN (-1)))
    , ((myModMask, xK_grave), rotAllUp)
    , ((myModMask .|. shiftMask, xK_grave), rotAllDown)
    -- , ((myModMask, xK_0), moveTo Next EmptyWS)
    -- , ((myModMask .|. shiftMask, xK_0), shiftTo Next EmptyWS)
    -- , ((myModMask, xK_0), toggleLinkWorkspaces message)
    -- , ((myModMask .|. shiftMask, xK_0), removeAllMatchings message)
    ]
    `additionalMouseBindings`
    [ ((myModMask, button1), (\w -> focus w >> mouseMoveWindow w))
    , ((myModMask, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((myModMask, button3), (\w -> focus w >> Flex.mouseResizeWindow w))
    ]


toggleFloat w = windows (\s -> if M.member w (W.floating s)
                    then W.sink w s
                    else (W.float w (W.RationalRect (1/8) (1/8) (3/4) (3/4)) s))

xmobarCommand (S s) = "xmobar -x " ++ show s

main = do
    -- xmonad $ myConfig
    nScreens <- countScreens
    hs <- mapM (spawnPipe . xmobarCommand) [0 .. nScreens-1]
    xmonad $ myConfig {
        workspaces = withScreens nScreens myWorkspaces,
        logHook = mapM_ dynamicLogWithPP $ zipWith myPP hs [0 .. nScreens-1]
        -- logHook = mapM_ (dynamicLogWithPP . myPP) hs
    }

-- Default keybindings + some modifications
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    --  Reset the layouts on the current workspace to default
    [ ((modm , xK_i     ), setLayout $ XMonad.layoutHook conf)
    ]
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    ++
    [((m .|. modm, k), windows $ onCurrentScreen f i)
        | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    -- [((m .|. modm, k), windows $ f i)
        -- | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
        -- | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]

    -- [((modm .|. m, k), a i)
    --     | (a, m) <- [ (switchWS (\y -> windows $ W.view y) message, 0)
    --                 , (switchWS (\x -> windows $ W.shift x . W.view x) message, shiftMask)
    --                 ]
    --     , (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]]


    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    -- ++
    -- [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

