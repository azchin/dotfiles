-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- local naughty = require("naughty")
package.loaded["naughty.dbus"] = {}
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             -- Make sure we don't go into an endless error loop
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, an error happened!",
                                              text = tostring(err) })
                             in_error = false
   end)
end
-- }}}

-- {{{ Autostart
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format("%s/.config/awesome/gtk-theme.lua", os.getenv("HOME"))
beautiful.init(theme_path)
-- beautiful.init(gears.filesystem.get_themes_dir() .. "gtk/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
terminal_class = "Alacritty"
browser = "firefox"
browser_class = "firefox"
visual = "emacs"
visual_class = "Emacs"
terminal_tag = "6"
browser_tag = "7"
visual_tag = "8"
other_tag = "9"
class_to_tag = {
   [terminal_class] = terminal_tag,
   [browser_class] = browser_tag,
   [visual_class] = visual_tag,
}

local function reverse_layout_negate(n)
   if awful.screen.focused().selected_tag.layout == awful.layout.suit.tile.left then
      return -n
   end
   return n
end

local function push_to_master(c)
   local master = awful.client.getmaster()
   if master == c then
      local next_ = awful.client.next(1, c)
      client.focus = next_
      next_:raise()
      awful.client.setmaster(client.focus)
   else
      awful.client.setmaster(c)
   end
end

local function not_fixed_tag(tag)
   local t = tag.name
   return t ~= terminal_tag and t ~= browser_tag and t ~= visual_tag and t~= other_tag
end

local function not_other_class(c)
   return c.class ~= visual_class and c.class ~= terminal_class and c.class ~= browser_class
end

local function spawn_activate(cmd, class)
   if not client.focus or client.focus.class ~= class then
      for k, v in ipairs(awful.screen.focused().selected_tag:clients()) do
         if v.class == class then
            client.focus = v
            v:raise()
            return
         end
      end
      if class_to_tag[class] then
         local t = awful.tag.find_by_name(awful.screen.focused(), class_to_tag[class])
         if t then
            if #t:clients() == 1 then
               local something = t:clients()[1]
               if something then
                  something:toggle_tag(awful.screen.focused().selected_tag)
                  client.focus = something
                  something:raise()
                  return
               end
            elseif #t:clients() > 1 then
               t:view_only()
               return
            end
         end
      end
      awful.spawn(cmd)
      return
   end
   
   local track = nil
   local first = nil
   for k, v in ipairs(awful.screen.focused().selected_tag:clients()) do
      if v.class == class then
         local loopprev = track
         track = v
         if not first then
            first = v
         end
         if loopprev == client.focus then
            break
         end
      end
   end

   if track and track ~= client.focus then -- if we have the one after focused
      client.focus = track
      track:raise()
   elseif first then -- if we have the one before focused
      client.focus = first
      first:raise()
   end
   -- awful.spawn.with_shell(string.format("xdo activate -d -N %s || %s", class, cmd))
end

local function spawn_activate_master(cmd, class)
   spawn_activate(cmd, class)
   if client.focus and client.focus ~= awful.client.getmaster() then
      awful.client.setmaster(client.focus)
   end
   -- awful.spawn.easy_async_with_shell(string.format("xdo activate -d -N %s || %s", class, cmd), function(out)
   --                                      if client.focus ~= awful.client.getmaster() then
   --                                         awful.client.setmaster(client.focus)
   --                                      end
   -- end)
end

local function spawn_activate_smart(cmd, class)
   local a = {}
   for k, v in ipairs(awful.screen.focused().selected_tag:clients()) do
      if v.class == class then
         table.insert(a, v)
      end
   end
   if #a == 1 then
      client.focus = a[1]
      a[1]:raise()
      if client.focus and client.focus ~= awful.client.getmaster() then
         awful.client.setmaster(client.focus)
      end
   elseif #a == 0 then
      spawn_activate_master(cmd, class)
   else
      spawn_activate(cmd, class)
   end
end

local function floating_above_rule(c)
   if not c.fullscreen then
      if c.floating then
         c.ontop = true
      else
         c.ontop = false
      end
   end
end

local function client_manage_common(c)
   -- Set the windows at the slave,
   -- i.e. put it at the end of others instead of setting it master.
   -- if not awesome.startup then awful.client.setslave(c) end
   -- if not awesome.startup then awful.client.setmaster(c) end
   -- awful.client.setmaster(c)

   if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
   end

   floating_above_rule(c)
end

local function client_manage(c)
   -- NOTE commented auto-tagging
   -- -- put on other
   -- if not_other_class(c) then
   --    local t = awful.screen.focused().selected_tag
   --    local g = awful.tag.find_by_name(awful.screen.focused(), other_tag)
   --    if t and t ~= g then
   --       c:toggle_tag(g)
   --    end
   -- end

   client_manage_common(c)
end

local function retag(c)
   local t = awful.screen.focused().selected_tag
   if not_fixed_tag(t) then
      c:toggle_tag(t)
   else
      awful.tag.history.restore()
      local p = awful.screen.focused().selected_tag
      local found = false
      for k, v in ipairs(c:tags()) do
         if v == p then
            found = true
         end
      end
      if not_fixed_tag(p) and not found then
         c:toggle_tag(p)
      end
   end
end

local function move_mouse_onto_client(c)
   if mouse.object_under_pointer() ~= c then
      local geometry = c:geometry()
      local x = geometry.x + geometry.width/2
      local y = geometry.y + geometry.height/2
      mouse.coords({x = x, y = y}, true)
   end
end

local function move_floating_client(c, x_offset, y_offset)
   if c.floating then
      local geometry = c:geometry()
      geometry.x = geometry.x + x_offset
      geometry.y = geometry.y + y_offset
      c:geometry(geometry)
   end
end

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.tile.left,
   awful.layout.suit.tile.top,
   awful.layout.suit.max,
   awful.layout.suit.fair,
   awful.layout.suit.floating,
   -- awful.layout.suit.tile,
   -- awful.layout.suit.hiding,
   -- awful.layout.suit.magnifier,
   -- awful.layout.suit.tile.left,
   -- awful.layout.suit.tile.top,
   -- awful.layout.suit.fair.horizontal,
   -- awful.layout.suit.spiral,
   -- awful.layout.suit.spiral.dwindle,
   -- awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.corner.nw,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                             { "open terminal", terminal }
}
                       })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.show_categories = false
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            c:emit_signal(
               "request::activate",
               "tasklist",
               {raise = true}
            )
         end
   end),
   awful.button({ }, 3, function()
         awful.menu.client_list({ theme = { width = 250 } })
   end)
   -- awful.button({ }, 4, function ()
   --       awful.client.focus.byidx(1)
   -- end),
   -- awful.button({ }, 5, function ()
   --       awful.client.focus.byidx(-1)
   -- end)
)

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      set_wallpaper(s)

      -- Each screen has its own tag table.
      awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
      -- s.tags[3].layout = awful.layout.suit.floating
      -- for _, tag in ipairs(s.tags) do
      -- end

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
      -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist {
         screen  = s,
         filter  = awful.widget.taglist.filter.all,
         buttons = taglist_buttons
      }

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist {
         screen  = s,
         filter  = awful.widget.tasklist.filter.currenttags,
         buttons = tasklist_buttons
      }

      -- Create the wibox
      s.mywibox = awful.wibar({ position = "top", screen = s })

      -- Add widgets to the wibox
      s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
         },
         s.mytasklist, -- Middle widget
         { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
         },
      }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
                awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- TODO
-- rm maximize, rebind minimize, shift-bind restore minimized
-- experiment with state: save prev layout, retag to last non-fixed tag

-- {{{ Key bindings
globalkeys = gears.table.join(
   awful.key({ modkey,           }, "z",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   -- awful.key({ modkey, "Shift"   }, "Tab",   awful.tag.viewprev,
   --    {description = "view previous", group = "tag"}),
   -- awful.key({ modkey,           }, "Tab",  awful.tag.viewnext,
   --    {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "Tab", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

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
   awful.key({ modkey,           }, "Down",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "Up",
      function ()
         awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
   --    {description = "show main menu", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey, "Shift"   }, "Down", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "Up", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey, "Control" }, "Down", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "Up", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey,           }, "i", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   -- awful.key({ modkey,           }, "w",
   --    function ()
   --       awful.client.focus.history.previous()
   --       if client.focus then
   --          client.focus:raise()
   --       end
   --    end,
   --    {description = "go back", group = "client"}),

   -- Standard program
   -- awful.key({ modkey,           }, "g", function () spawn_activate_smart(terminal, terminal_class) end,
   --    {description = "focus the terminal", group = "launcher"}),
   -- awful.key({ modkey,           }, "b", function () spawn_activate_smart(browser, browser_class) end,
   --    {description = "focus the browser", group = "launcher"}),
   -- awful.key({ modkey,           }, "v", function () spawn_activate_smart(visual, visual_class) end,
   --    {description = "focus the editor", group = "launcher"}),

   awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey,           }, "g", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey,           }, "b", function () awful.spawn(browser) end,
      {description = "open the browser", group = "launcher"}),
   awful.key({ modkey, "Shift"   }, "v", function () awful.spawn(visual) end,
      {description = "open editor", group = "launcher"}),
   awful.key({ modkey,           }, "v", function () awful.spawn.with_shell("emacsclient -c -a emacs") end,
      {description = "open emacs client", group = "launcher"}),

   awful.key({ }, "XF86AudioLowerVolume", function () awful.spawn.with_shell("pamixer -d 5 && ~/bin/notify.sh \"Volume: $(pamixer --get-volume-human)\" audio-volume-high") end,
      {description = "Lower volume", group = "system"}),
   awful.key({ }, "XF86AudioRaiseVolume", function () awful.spawn.with_shell("pamixer -i 5 && ~/bin/notify.sh \"Volume: $(pamixer --get-volume-human)\" audio-volume-high") end,
      {description = "Raise volume", group = "system"}),
   awful.key({ }, "XF86AudioMute", function () awful.spawn.with_shell("pamixer -t && ~/bin/notify.sh \"Volume: $(pamixer --get-volume-human)\" audio-volume-high") end,
      {description = "Mute", group = "system"}),
   awful.key({ }, "XF86AudioPlay", function () awful.spawn.with_shell("playerctl.sh play-pause") end,
      {description = "Play/Pause", group = "system"}),
   awful.key({ }, "XF86AudioPrev", function () awful.spawn.with_shell("playerctl.sh previous") end,
      {description = "Previous", group = "system"}),
   awful.key({ }, "XF86AudioNext", function () awful.spawn.with_shell("playerctl.sh next") end,
      {description = "Next", group = "system"}),
   awful.key({ }, "XF86AudioRewind", function () awful.spawn.with_shell("playerctl.sh rewind") end,
      {description = "Rewind", group = "system"}),
   awful.key({ }, "XF86AudioForward", function () awful.spawn.with_shell("playerctl.sh forward") end,
      {description = "Fast Forward", group = "system"}),
   awful.key({ }, "Print", function () awful.spawn.with_shell("maim | xclip -sel clip -t image/png") end,
      {description = "Screenshot", group = "system"}),
   awful.key({ modkey,             }, "Print", function () awful.spawn.with_shell("maim -s | xclip -sel clip -t image/png") end,
      {description = "Screenshot rectangular select", group = "system"}),

   awful.key({ modkey, "Shift" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "e", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact(reverse_layout_negate(0.05))          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(reverse_layout_negate(-0.05))          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster(reverse_layout_negate(1), nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(reverse_layout_negate(-1), nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol(reverse_layout_negate(1), nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(reverse_layout_negate(-1), nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "Right",     function () awful.tag.incmwfact(reverse_layout_negate(0.05))          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "Left",     function () awful.tag.incmwfact(reverse_layout_negate(-0.05))          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "Left",     function () awful.tag.incnmaster(reverse_layout_negate(1), nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "Right",     function () awful.tag.incnmaster(reverse_layout_negate(-1), nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "Left",     function () awful.tag.incncol(reverse_layout_negate(1), nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "Right",     function () awful.tag.incncol(reverse_layout_negate(-1), nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   -- awful.key({ modkey,           }, "Tab", function () awful.layout.inc( 1)                end,
   --    {description = "select next", group = "layout"}),
   -- awful.key({ modkey, "Shift"   }, "Tab", function () awful.screen.focused().selected_tag.layout = awful.layout.layouts[1] end,
   --    {description = "select first", group = "layout"}),
   awful.key({ modkey,           }, "m",  function ()
         local current = awful.screen.focused().selected_tag
         if current.layout ~= awful.layout.suit.max then
            current.layout = awful.layout.suit.max
         else
            current.layout = awful.layout.layouts[1]
         end
   end,
   {description = "toggle monocle", group = "layout"}),
   awful.key({ modkey,           }, "a",  function ()
         local current = awful.screen.focused().selected_tag
         if current.layout ~= awful.layout.suit.floating then
            current.layout = awful.layout.suit.floating
         else
            current.layout = awful.layout.layouts[1]
         end
   end,
   {description = "toggle floating", group = "layout"}),
   awful.key({ modkey,           }, "w",  function ()
         local current = awful.screen.focused().selected_tag
         if current.layout ~= awful.layout.layouts[1] then
            current.layout = awful.layout.layouts[1]
         else
            current.layout = awful.layout.layouts[2]
         end
   end,
   {description = "switch between top two layouts", group = "layout"}),
   awful.key({ modkey, "Control" }, "n",
      function ()
         local c = awful.client.restore()
         -- Focus restored client
         if c then
            c:emit_signal(
               "request::activate", "key.unminimize", {raise = true}
            )
         end
      end,
      {description = "restore minimized", group = "client"}),

   -- Prompt
   -- awful.key({ modkey },            "c",     function () awful.screen.focused().mypromptbox:run() end,
   --    {description = "run command", group = "launcher"}),
   awful.key({ modkey },            "p",     function () awful.spawn.with_shell("dmenu_run_history.sh drofi") end,
      {description = "run dmenu", group = "launcher"}),
   awful.key({ modkey },            "space",     function () awful.spawn.with_shell("rofi -show drun -show-icons -theme-str '* { font: \"DejaVu Sans 14\"; }'") end,
      {description = "run rofi dmenu", group = "launcher"}),
   awful.key({ modkey },            "c",     function () awful.spawn.with_shell("launch.sh drofi") end,
      {description = "run rofi launcher", group = "launcher"})

   -- awful.key({ modkey }, "x",
   --    function ()
   --       awful.prompt.run {
   --          prompt       = "Run Lua code: ",
   --          textbox      = awful.screen.focused().mypromptbox.widget,
   --          exe_callback = awful.util.eval,
   --          history_path = awful.util.get_cache_dir() .. "/history_eval"
   --       }
   --    end,
   --    {description = "lua execute prompt", group = "awesome"}),
   -- Menubar
   -- awful.key({ modkey }, "space", function()
   --       local s = awful.screen.focused()
   --       menubar.geometry["x"] = s.mywibox.x
   --       menubar.geometry["y"] = s.mywibox.y
   --       menubar.geometry["width"] = s.mywibox.width
   --       menubar.geometry["height"] = s.mywibox.height
   --       menubar.show()
   -- end,
   --    {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
   -- awful.key({ modkey,           }, "f",
   --    function (c)
   --       c.fullscreen = not c.fullscreen
   --       c:raise()
   --    end,
   --    {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ modkey,           }, "d",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey,         }, "s", push_to_master,
      {description = "move to master", group = "client"}),
   awful.key({ modkey, "Shift"   }, "i",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey,           }, "t",      function (c) c.sticky = not c.sticky            end,
      {description = "toggle sticky", group = "client"}),
   awful.key({ modkey, "Shift"   }, "t",      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "n",
      function (c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "f",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
   awful.key({ modkey, "Control" }, "f",
      function (c)
         c.maximized_vertical = not c.maximized_vertical
         c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
   awful.key({ modkey, "Shift"   }, "f",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"}),
   -- awful.key({modkey }, "o",
   --    function (c)
   --       local t = awful.screen.focused().selected_tag
   --       if not_fixed_tag(t) then
   --          for _, o in ipairs(t:clients()) do
   --             if o ~= c then
   --                o:toggle_tag(t)
   --             end
   --          end
   --       end
   --    end,
   --    {description = "retag other clients", group = "client"}),
   -- TODO awful.placement move floating relative
   awful.key({ modkey, "Mod1"    }, "Up", function (c) move_floating_client(c, 0, -50) end,
      {description = "move client up", group = "client"}),
   awful.key({ modkey, "Mod1"    }, "Down", function (c) move_floating_client(c, 0, 50) end,
      {description = "move client down", group = "client"}),
   awful.key({ modkey, "Mod1"    }, "Left", function (c) move_floating_client(c, -50, 0) end,
      {description = "move client left", group = "client"}),
   awful.key({ modkey, "Mod1"    }, "Right", function (c) move_floating_client(c, 50, 0) end,
      {description = "move client right", group = "client"}),
   awful.key({ modkey,           }, "e", move_mouse_onto_client,
      {description = "move pointer to focus", group = "client"})
   -- https://www.reddit.com/r/awesomewm/comments/gehk1g/cursor_follows_focus_possible/ 
   -- awful.key({ modkey,           }, "r", retag,
   --    {description = "untag or retag", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
                                 -- View tag only.
                                 awful.key({ modkey }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag #"..i, group = "tag"}),
                                 -- Toggle tag display.
                                 awful.key({ modkey, "Control" }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          awful.tag.viewtoggle(tag)
                                       end
                                    end,
                                    {description = "toggle tag #" .. i, group = "tag"}),
                                 -- Move client to tag.
                                 awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          local ftag = awful.screen.focused().selected_tag
                                          if tag and not_fixed_tag(tag) then
                                             if not_fixed_tag(ftag) then
                                                client.focus:move_to_tag(tag)
                                             else
                                                client.focus:toggle_tag(tag)
                                                tag:view_only()
                                             end
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag #"..i, group = "tag"}),
                                 -- Toggle tag on focused client.
                                 awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag and not_fixed_tag(tag) then
                                             client.focus:toggle_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
   end),
   awful.button({ modkey }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.move(c)
   end),
   awful.button({ modkey }, 3, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.resize(c)
   end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    size_hints_honor = false,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },

   -- Floating clients.
   { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll.
           "copyq",  -- Includes session name in class.
           "pinentry",
        },
        class = {
           "Arandr",
           "Blueman-manager",
           "Gpick",
           "Kruler",
           "MessageWin",  -- kalarm.
           "Sxiv",
           "Nsxiv",
           "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
           "Wpa_gui",
           "veromix",
           "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
           "Event Tester",  -- xev.
        },
        role = {
           "AlarmWindow",  -- Thunderbird's calendar.
           "ConfigManager",  -- Thunderbird's about:config.
           "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
                }, properties = { titlebars_enabled = true }
   },

   { rule = { class = terminal_class },
     properties = {
        titlebars_enabled = false,
     },
   },

   -- NOTE commented auto-tagging
   -- -- Set Firefox to always map on the tag named "2" on screen 1.
   -- { rule = { class = browser_class },
   --   -- properties = {
   --   --    titlebars_enabled = false,
   --   -- },
   --   callback = function(c)
   --      local t = awful.screen.focused().selected_tag
   --      local g = awful.tag.find_by_name(awful.screen.focused(), browser_tag)
   --      if t and t ~= g then
   --         -- for _, v in ipairs(g:clients()) do
   --         --    if v == c then
   --         --       return
   --         --    end
   --         -- end
   --         c:toggle_tag(g)
   --      end
   --      client_manage_common(c)
   --   end
   -- },

   -- { rule = { class = terminal_class },
   --   callback = function(c)
   --      local t = awful.screen.focused().selected_tag
   --      local g = awful.tag.find_by_name(awful.screen.focused(), terminal_tag)
   --      if t and t ~= g then
   --         c:toggle_tag(g)
   --      end
   --      client_manage_common(c)
   --   end
   -- },

   -- { rule = { class = visual_class },
   --   callback = function(c)
   --      local t = awful.screen.focused().selected_tag
   --      local g = awful.tag.find_by_name(awful.screen.focused(), visual_tag)
   --      if t and t ~= g then
   --         c:toggle_tag(g)
   --      end
   --      client_manage_common(c)
   --   end
   -- }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", client_manage)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                         -- buttons for the titlebar
                         local buttons = gears.table.join(
                            awful.button({ }, 1, function()
                                  c:emit_signal("request::activate", "titlebar", {raise = true})
                                  awful.mouse.client.move(c)
                            end),
                            awful.button({ }, 3, function()
                                  c:emit_signal("request::activate", "titlebar", {raise = true})
                                  awful.mouse.client.resize(c)
                            end)
                         )

                         awful.titlebar(c, { size = 24}) : setup {
                            { -- Left
                               awful.titlebar.widget.iconwidget(c),
                               buttons = buttons,
                               layout  = wibox.layout.fixed.horizontal
                            },
                            { -- Middle
                               { -- Title
                                  align  = "center",
                                  widget = awful.titlebar.widget.titlewidget(c)
                               },
                               buttons = buttons,
                               layout  = wibox.layout.flex.horizontal
                            },
                            { -- Right
                               awful.titlebar.widget.floatingbutton (c),
                               awful.titlebar.widget.ontopbutton    (c),
                               awful.titlebar.widget.stickybutton   (c),
                               awful.titlebar.widget.minimizebutton (c),
                               awful.titlebar.widget.maximizedbutton(c),
                               awful.titlebar.widget.closebutton    (c),
                               layout = wibox.layout.fixed.horizontal()
                            },
                            layout = wibox.layout.align.horizontal
                                                   }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                         if awful.screen.focused().selected_tag.layout ~= awful.layout.suit.floating then
                            c:emit_signal("request::activate", "mouse_enter", {raise = true})
                         end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
client.connect_signal("property::floating", floating_above_rule)
-- TODO tag request::select  if layout not floating then don't ontop
-- TODO tag property::layout
-- tag.connect_signal("property::layout", function(t)
--                       if t.layout == awful.layout.suit.floating then
--                          for _, c in ipairs(t:clients()) do
--                             if c.type == "normal" then
--                                c.titlebars_enabled = true
--                                c:emit_signal("request::titlebars")
--                             end
--                          end
--                       else
--                          for _, c in ipairs(t:clients()) do
--                             c.titlebars_enabled = false
--                          end
--                       end
-- end)
-- }}}
