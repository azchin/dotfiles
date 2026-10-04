-- Hyprland Lua config (converted from hyprland.conf for Hyprland 0.56)
-- https://wiki.hypr.land/Configuring/Start/


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- 4K safe setup
-- hl.monitor({ output = "DP-1", mode = "preferred", position = "auto",      scale = 1.5 })
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto-left", scale = 1.25, transform = 3 })

-- Dell 2K vert + Dell 4K
-- (1440 / 1.25) x (2560 / 1.25 - 2160 / 1.5)
hl.monitor({ output = "DP-1", mode = "preferred", position = "1152x608", scale = 1.5 })
hl.monitor({ output = "DP-2", mode = "preferred", position = "0x0",      scale = 1.25, transform = 3 })

-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto-left", scale = 1.0, transform = 1 })

-- Home setup
-- hl.monitor({ output = "DP-1", mode = "preferred",         position = "1080x480", scale = 1.5 })
-- hl.monitor({ output = "DP-2", mode = "1920x1080@100",     position = "0x0",      scale = 1, transform = 1 })


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = [[alacritty -e tmux new-session \; set-option destroy-unattached on]]
local fileManager = "pcmanfm"
local apps        = [[rofi -show drun -show-icons -theme-str 'element-icon { size: 32; }']]
local menu        = "~/bin/dmenu_run_history.sh ~/bin/drofi"
local commands    = "~/bin/launch.sh ~/bin/drofi"
local browser     = "firefox"
local editor      = "emacsclient -c -a emacs"

local animationMs     = 4
local animationMsFast = 1


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("$HOME/.config/hypr/autostart.sh")
    -- hl.exec_cmd("hyprpaper")
    hl.exec_cmd(browser)
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "capitaine-cursors-white")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "capitaine-cursors-white")
hl.env("GDK_SCALE", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_ENABLE_HIGHDPI_SCALING", "1")
hl.env("MOZ_GTK_TITLEBAR_DECORATION", "client")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt6ct:qt5ct")
-- hl.env("XDG_MENU_PREFIX", "arch-")
-- hl.env("QT_SCALE_FACTOR", "2")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 4,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = false,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        -- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
    master = {
        new_status  = "master",
        orientation = "right",
        mfact       = 0.5,
        -- allow_small_split = true,
    },

    misc = {
        force_default_wallpaper  = 2,     -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo    = false, -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
    },

    binds = {
        allow_workspace_cycles = true,
    },

    cursor = {
        warp_on_change_workspace = true,
        -- no_hardware_cursors = true,
        -- no_warps = true,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    debug = {
        disable_logs = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "global",           enabled = false, speed = animationMs,     bezier = "default" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = animationMs,     bezier = "default" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = animationMs,     bezier = "default", style = "popin 80%" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 10,              bezier = "default" })
-- hl.animation({ leaf = "borderangle",   enabled = true,  speed = 8,               bezier = "default" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = animationMs,     bezier = "default", style = "fade" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = animationMs,     bezier = "default" })
-- hl.animation({ leaf = "fadeLayers",    enabled = false, speed = animationMs,     bezier = "default" })
hl.animation({ leaf = "workspaces",       enabled = true,  speed = animationMsFast, bezier = "default", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = animationMs,     bezier = "default", style = "slidevert" })


---------------
---- INPUT ----
---------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        repeat_rate  = 32,
        repeat_delay = 400,

        -- 0 to not change focus under cursor
        follow_mouse = 1,

        sensitivity = -0.5, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- hl.device({
--     name        = "mx-master-4-mouse",
--     sensitivity = -0.7,
-- })


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

local function key(k)  return mainMod .. " + " .. k end
local function skey(k) return mainMod .. " + SHIFT + " .. k end

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
hl.bind(key("G"),        hl.dsp.exec_cmd(terminal))
hl.bind(key("return"),   hl.dsp.exec_cmd(terminal))
hl.bind(skey("G"),       hl.dsp.exec_cmd("alacritty"))
hl.bind(key("B"),        hl.dsp.exec_cmd(browser))
hl.bind(key("V"),        hl.dsp.exec_cmd(editor))
hl.bind(skey("V"),       hl.dsp.exec_cmd("emacs"))
hl.bind(skey("Q"),       hl.dsp.window.close())
hl.bind(skey("C"),       hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(skey("E"),       hl.dsp.exit())
hl.bind(key("E"),        hl.dsp.exec_cmd(fileManager))
hl.bind(key("D"),        hl.dsp.window.float({ action = "toggle" }))
hl.bind(key("M"),        hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(key("F"),        hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(key("T"),        hl.dsp.window.pin())
hl.bind(key("Q"),        hl.dsp.cursor.move_to_corner({ corner = 3 }))
hl.bind(key("space"),    hl.dsp.exec_cmd(apps))
hl.bind(skey("space"),   hl.dsp.exec_cmd(menu))
hl.bind(key("C"),        hl.dsp.exec_cmd(commands))
hl.bind(key("Tab"),      hl.dsp.focus({ workspace = "previous_per_monitor" }))
hl.bind(key("W"),        hl.dsp.layout("orientationcycle right bottom left"))
hl.bind(key("A"),        hl.dsp.focus({ monitor = "+1" }))
hl.bind(skey("A"),       hl.dsp.window.move({ monitor = "+1" }))
hl.bind(key("I"),        hl.dsp.focus({ monitor = "+1" }))
hl.bind(skey("I"),       hl.dsp.window.move({ monitor = "+1" }))
-- hl.bind(key("P"),     hl.dsp.window.pseudo())       -- dwindle
-- hl.bind(key("J"),     hl.dsp.layout("togglesplit")) -- dwindle

-- Master layout navigation: arrow keys and vim keys share the same actions
local masterBinds = {
    { "up",    "k", "cycleprev",        "swapprev" },
    { "down",  "j", "cyclenext",        "swapnext" },
    { "left",  "h", "mfact +0.05",      "removemaster" },
    { "right", "l", "mfact -0.05",      "addmaster" },
}
for _, b in ipairs(masterBinds) do
    local arrow, vim, msg, shiftMsg = b[1], b[2], b[3], b[4]
    hl.bind(key(arrow),  hl.dsp.layout(msg))
    hl.bind(key(vim),    hl.dsp.layout(msg))
    hl.bind(skey(arrow), hl.dsp.layout(shiftMsg))
    hl.bind(skey(vim),   hl.dsp.layout(shiftMsg))
end
hl.bind(key("equal"), hl.dsp.layout("mfact exact 0.5"))

hl.bind(key("S"),  hl.dsp.layout("swapwithmaster"))
hl.bind(key("R"),  hl.dsp.workspace.toggle_special("special"))
-- TODO bind to script, if current workspace is special then move to prev.
hl.bind(skey("R"), hl.dsp.window.move({ workspace = "special", follow = false }))
-- hl.bind(key("R"), hl.dsp.layout("rollprev"))
-- hl.bind(key("T"), hl.dsp.layout("rollnext"))
-- hl.bind(key("A"), hl.dsp.layout("orientationright"))

-- Media keys
local notifyVolume = [[ && ~/bin/notify.sh "Volume: $(pamixer --get-volume-human)" audio-volume-high]]
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5" .. notifyVolume))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5" .. notifyVolume))
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pamixer -t"   .. notifyVolume))
hl.bind("XF86AudioPlay",        hl.dsp.exec_cmd("~/bin/playerctl.sh play-pause"))
hl.bind("XF86AudioPrev",        hl.dsp.exec_cmd("~/bin/playerctl.sh previous"))
hl.bind("XF86AudioNext",        hl.dsp.exec_cmd("~/bin/playerctl.sh next"))
hl.bind("XF86AudioRewind",      hl.dsp.exec_cmd("~/bin/playerctl.sh rewind"))
hl.bind("XF86AudioForward",     hl.dsp.exec_cmd("~/bin/playerctl.sh forward"))

-- Screenshots
hl.bind("Print",      hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))
hl.bind(key("Print"), hl.dsp.exec_cmd("grim - | wl-copy"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace (silently) with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local k = tostring(i % 10) -- 10 maps to key 0
    hl.bind(key(k),  hl.dsp.focus({ workspace = i }))
    hl.bind(skey(k), hl.dsp.window.move({ workspace = i, follow = false }))
end

-- hl.bind("ALT + TAB", hl.dsp.layout("cyclenext"),      { repeating = true })
-- hl.bind("ALT + TAB", hl.dsp.layout("swapwithmaster"), { release = true })

-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(key("mouse_down"), hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(key("mouse_up"),   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(key("mouse:272"), hl.dsp.window.drag(),   { mouse = true })
hl.bind(key("mouse:273"), hl.dsp.window.resize(), { mouse = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- FIXME
hl.window_rule({ name = "float-gamescope", match = { class = "^gamescope$" },             float = true })
hl.window_rule({ name = "float-digikam",   match = { class = "^org\\.kde\\.digikam$" },   float = true })
hl.window_rule({
    name  = "nextcloud",
    match = { class = "^com\\.nextcloud\\.desktopclient\\.nextcloud$" },
    float = true,
    move  = "monitor_w-window_w monitor_h*0.01", -- was: 100%-w-0 1%
})
hl.window_rule({ name = "keepassxc-ws5", match = { class = "^org\\.keepassxc\\.KeePassXC$" }, workspace = "5" })

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

hl.workspace_rule({ workspace = "f[1]",       gaps_in = 0, gaps_out = 0, decorate = false, no_border = true })
hl.workspace_rule({ workspace = "w[tv5-100]", gaps_in = 0, gaps_out = 0 })

for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1", default = (i == 1) })
end
for i = 6, 10 do
    hl.workspace_rule({
        workspace   = tostring(i),
        monitor     = "DP-2",
        default     = (i == 6),
        layout_opts = { orientation = "bottom" },
    })
end

-- hl.workspace_rule({ workspace = "2", on_created_empty = "~/.config/hypr/focus-wrapper.sh " .. terminal })
