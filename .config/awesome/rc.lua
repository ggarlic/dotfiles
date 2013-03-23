-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
vicious = require("vicious")

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
        text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions

-- Useful Paths
home = os.getenv("HOME")
confdir = home .. "/.config/awesome"
themes = confdir .. "/themes"

-- Choose Your Theme
active_theme = themes .. "/colored"

-- Themes define colours, icons, and wallpapers
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init(active_theme .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser = "chromium"
fileman = "pcmanfm " .. home
cli_fileman = terminal .. " -e ranger "

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    -- tags[s] = awful.tag({ "⢷", "⣨", "⡪", "⣌", "⣪", "⡝"}, s,
    -- tags[s] = awful.tag({ "¹ term", "´ web", "² files", "© chat", "ê media", "º work" }, s,
    tags[s] = awful.tag({ "term", "web", "files", "chat", "media", "work" }, s,
    -- tags[s] = awful.tag({ "¹", "´", "²", "©", "ê", "º" }, s,
    { layouts[2], layouts[1], layouts[2],
    layouts[1], layouts[1], layouts[2]
})

awful.tag.seticon(active_theme .. "/widgets/blue/arch_10x10.png", tags[s][1])
awful.tag.seticon(active_theme .. "/widgets/red/cat.png", tags[s][2])
awful.tag.seticon(active_theme .. "/widgets/green/dish.png", tags[s][3])
awful.tag.seticon(active_theme .. "/widgets/yellow/mail.png", tags[s][4])
awful.tag.seticon(active_theme .. "/widgets/magenta/phones.png", tags[s][5])
awful.tag.seticon(active_theme .. "/widgets/cyan/diskette.png", tags[s][6])

end

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
    { "manual"            , terminal .. " -e man awesome" },
    { "restart"           , awesome.restart},
    { "edit config"       , editor_cmd .. " " .. awesome.conffile },
    { "edit theme"        , editor_cmd .. " " .. active_theme .. "/theme.lua" },  
}

myinternet = {
    { "Chromium"         , "chromium" },
    { "Firefox"          , "firefox" },
    { "IM Clinet"        , "pidgin" },
    { "Torrent"          , "transmission-gtk"},
    { "Email"            , terminal .. " -e mutt" },
}

mymedia = {
    { "Deadbeef"         , "deadbeef" },
    { "Vlc"              , "vlc" },
    { "SMplayer"         , "smplayer" },
    { "Audacity"         , "audacity" },
    { "Webcam"           , "mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 25 -vf screenshot" }
}

mygraphics = {
    { "Stampawindow"     , "scrot --select" },
    { "Screen"           , "scrot" },
    { "Gimp"             , "gimp" },
    { "Paint"            , "kolourpaint" },
}

mysystem = {
    { "Appearance"       , "lxappearance" },
    { "Desktop"          , "nitrogen" },
    { "Xdefaults"        , editor_cmd .. " " .. home .. "/.Xdefaults"},
    { "Cleaning"         , "bleachbit" },
    { "HardInfo"         , "hardinfo" },
    { "Task Manager"     , "lxtasks" }
}

mysystemroot = {
    { "Appearance"       , terminal .. " -e sudo lxappearance" },
    { "Cleaning"         , terminal .. " -e sudo bleachbit" },
    { "Partitions"       , terminal .. " -e sudo gparted" }
}

myexit = {
    { "Suspend"           , "systemctl suspend" },
    { "Sleep"             , "systemctl hybrid-sleep" },
    { "Hibernate"         , "systemctl hibernate" },
    { "Shutdown"          , "systemctl poweroff" },
    { "Reboot"            , "systemctl reboot" },
    { "Quit"              , awesome.quit }
}
mymainmenu = awful.menu({ items = { 
    { "Awesome", myawesomemenu },
    { "Ranger", cli_fileman },
    { "File Manager", fileman },
    { "Terminal", terminal },
    { "Browser" , browser },
    { " ", nil, nil}, -- separator
    { "Internet" , myinternet },
    { "Multimedia" , mymedia },
    { "Graphics" , mygraphics },
    { "System" , mysystem },
    { "System Root" , mysystemroot },
    { " ", nil, nil}, -- separator
    { "Exit", myexit },
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibox

-- Create a textclock widget
local mytextclock = awful.widget.textclock()
mytextclock:buttons( awful.util.table.join(
                awful.button({ }, 1, function () awful.util.spawn("/home/ggarlic/.mybashscripts/./dzen2_cal-extended_display.sh") end)
            ))

-- {{{ Temp
        local tempicon = wibox.widget.imagebox()
        tempicon:set_image(beautiful.widget_temp)
        local tempwidget = wibox.widget.textbox()
        -- vicious.register(tempwidget, vicious.widgets.thermal, "<span color=\"#ffaf5f\">$1 C</span>", 9, { "coretemp.0", "core"} )
        vicious.register(tempwidget, vicious.widgets.thermal, "$1C", 9, { "coretemp.0", "core"} )

        local function disptemp()
            local f, infos
            local capi = {
                mouse = mouse,
                screen = screen
            }

            f = io.popen("sensors")
            infos = f:read("*all")
            f:close()

            showtempinfo = naughty.notify( {
                text	= infos,
                timeout	= 0,
                position = "top_right",
                margin = 10,
                height = 200,
                width = 460,
                border_color = '#404040',
                border_width = 1,
                -- opacity = 0.95,
                screen	= capi.mouse.screen })
        end
        tempwidget:connect_signal('mouse::enter', function () disptemp(path) end)
        tempwidget:connect_signal('mouse::leave', function () naughty.destroy(showtempinfo) end)
    --    tempwidget:buttons(awful.util.table.join(
    --        awful.button({ }, 1, function () sexec(script_path .. "fan.sh") end)
    --    ))
-- }}}

-- {{{ pacman
    -- Pacman Icon
    pacicon = wibox.widget.imagebox()
    pacicon:set_image(beautiful.widget_pac)

    -- Pacman Widget
    pacwidget = wibox.widget.textbox()
    pacwidget_t = awful.tooltip({ objects = { pacwidget},})
    vicious.register(pacwidget, vicious.widgets.pkg,
    function(widget,args)
    local io = { popen = io.popen }
    local s = io.popen("sudo yaourt -Sya && yaourt -Qu")
    local str = ''
    for line in s:lines() do
    str = str .. line .. "\n"
    end
    pacwidget_t:set_text(str)
    s:close()
    return " " .. args[1]
    end, 600, "Arch")
    --'1800' means check every 30 minutes

    pacicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e yaourt -Syua", false) end)
    ))
-- }}}

-- {{{ Volume
    -- Vol Icon
    volicon = wibox.widget.imagebox()
    volicon:set_image(beautiful.widget_vol)

    -- Sound volume
    volumewidget = wibox.widget.textbox()
    vicious.register( volumewidget, vicious.widgets.volume, "$1", 1, "Master" )

    volicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1%+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1%-", false) end)
    ))

    volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1%+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1%-", false) end)
    ))
-- }}}

-- {{{ MPD
    -- MPD Icon
    mpdicon = wibox.widget.imagebox()
    mpdicon:set_image(beautiful.widget_mpd)

    -- Initialize MPD Widget
    mpdwidget = wibox.widget.textbox()
    vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then 
            return "Stopped"
        elseif args["{state}"] == "Pause" then
            return "Paused"
        else
            return args["{Title}"].. ' - '.. args["{Artist}"]
        end
    end, 1)

    mpdicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e ncmpcpp", false) end)
    ))

    -- MPD controls
    music_play = awful.widget.launcher({
        image = beautiful.widget_play,
        command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
    })

    music_pause = awful.widget.launcher({
        image = beautiful.widget_pause,
        command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
    })
    music_pause.visible = false

    music_stop = awful.widget.launcher({
        image = beautiful.widget_stop,
        command = "ncmpcpp stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
    })

    music_prev = awful.widget.launcher({
        image = beautiful.widget_prev,
        command = "ncmpcpp prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
    })

    music_next = awful.widget.launcher({
        image = beautiful.widget_next,
        command = "ncmpcpp next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
    })
-- }}}

-- {{{ Net
    -- Network usage
    local netdownicon = wibox.widget.imagebox()
    netdownicon:set_image(beautiful.widget_netdown)
    local netupicon = wibox.widget.imagebox()
    netupicon:set_image(beautiful.widget_netup)
    local netwidget = wibox.widget.textbox()
    vicious.register(netwidget, vicious.widgets.net, '${wlan1 down_kb}/${wlan1 up_kb}', 3)
    local function dispip()
        local f, infos
        local capi = {
            mouse = mouse,
            screen = screen
        }

        f = io.popen("echo \"Pub IP:   $(/home/ggarlic/.mybashscripts/ip.sh)\"")
        infos = f:read("*all")
        f:close()

        showip = naughty.notify( {
            text	= infos,
            timeout	= 0,
            position = "top_right",
            margin = 10,
            height = 33,
            width = 175,
            border_color = '#404040',
            border_width = 1,
            -- opacity = 0.95,
            screen	= capi.mouse.screen })
        end

        netwidget:connect_signal('mouse::enter', function () dispip(path) end)
        netwidget:connect_signal('mouse::leave', function () naughty.destroy(showip) end)
-- }}}

-- {{{ MEM
    -- MEM icon
    memicon = wibox.widget.imagebox()
    memicon:set_image(beautiful.widget_mem)
    -- Memory usage
    memwidget = wibox.widget.textbox()
    vicious.register(memwidget, vicious.widgets.mem, "$1%", 1)

    memicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e htop", false) end)
    ))
    local function freemem()
        local f, infos
        local capi = {
            mouse = mouse,
            screen = screen
        }

        f = io.popen("free -m")
        infos = f:read("*all")
        f:close()

        showmemfree = naughty.notify( {
            text	= infos,
            timeout	= 0,
            position = "top_right",
            margin = 10,
            height = 90,
            width = 450,
            border_color = '#404040',
            border_width = 1,
            -- opacity = 0.95,
            screen	= capi.mouse.screen })
        end
        memwidget:connect_signal('mouse::enter', function () freemem(path) end)
        memwidget:connect_signal('mouse::leave', function () naughty.destroy(showmemfree) end)
        -- }}}

        -- {{{CPU
        -- CPU Icon
        cpuicon = wibox.widget.imagebox()
        cpuicon:set_image(beautiful.widget_cpu)
        -- Cpu usage
        cpuwidget = wibox.widget.textbox()
        vicious.register( cpuwidget, vicious.widgets.cpu, "$1%", 1)

        cpuicon:buttons(awful.util.table.join(
        awful.button({ }, 1, function () awful.util.spawn("".. terminal.. " -e htop", false) end)
        ))
        local function pstree()
            local f, infos
            local capi = {
                mouse = mouse,
                screen = screen
            }

            f = io.popen("pstree")
            infos = f:read("*all")
            f:close()

            showpstree = naughty.notify( {
                text	= infos,
                timeout	= 0,
                position = "top_right",
                margin = 10,
                height = 400,
                width = 450,
                border_color = '#404040',
                border_width = 1,
                -- opacity = 0.95,
                screen	= capi.mouse.screen })
            end
            cpuwidget:connect_signal('mouse::enter', function () pstree(path) end)
            cpuwidget:connect_signal('mouse::leave', function () naughty.destroy(showpstree) end)
            -- }}}

-- {{{ BAT
        -- BATT Icon
    baticon = wibox.widget.imagebox()
    baticon:set_image(beautiful.widget_batt)

    -- Battery usage
    powermenu = awful.menu({items = {
        { "Ondemand" , function () awful.util.spawn("".. terminal.. " -e 'for i in 0 1 2 3;do sudo cpufreq-set -g ondemand -c $i;done'", false) end },
        { "Powersave" , function () awful.util.spawn("".. terminal.. " -e 'for i in 0 1 2 3;do sudo cpufreq-set -g powersave -c $i;done'", false) end },
        { "Performance" , function () awful.util.spawn("".. terminal.. " -e 'for i in 0 1 2 3;do sudo cpufreq-set -g performance -c $i;done'", false) end },
        { "Conservative" , function () awful.util.spawn("".. terminal.. " -e 'for i in 0 1 2 3;do sudo cpufreq-set -g conservative -c $i;done'", false) end },
        { "Powertop" , function () awful.util.spawn("".. terminal.. " -e 'sudo powertop'", false) end }
    }
    })

    batwidget = wibox.widget.textbox()
    vicious.register( batwidget, vicious.widgets.bat, "$2%", 61, "BAT0" )
    baticon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () powermenu:toggle() end )
    ))

    batwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () powermenu:toggle() end )
    ))

-- }}}

        ---------------------
        -- Utility Widgets --
        ---------------------

        -- Spacers
        rbracket = wibox.widget.textbox()
        rbracket:set_text(']')
        lbracket = wibox.widget.textbox()
        lbracket:set_text('[')
        line = wibox.widget.textbox()
        line:set_text('|')

        -- Space
        space = wibox.widget.textbox()
        space:set_text(' ')

        ----------------------------------------------------------------------
        ------------------------------[ LAYOUT ]------------------------------
        ----------------------------------------------------------------------


        -- Create a wibox for each screen and add it
        mywibox = {}
        mybottomwibox = {}
        mypromptbox = {}
        mylayoutbox = {}
        mytaglist = {}
        mytaglist.buttons = awful.util.table.join(
        awful.button({ }, 1, awful.tag.viewonly),
        awful.button({ modkey }, 1, awful.client.movetotag),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, awful.client.toggletag),
        awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
        )
        mytasklist = {}
        mytasklist.buttons = awful.util.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                -- Without this, the following
                -- :isvisible() makes no sense
                c.minimized = false
                if not c:isvisible() then
                    awful.tag.viewonly(c:tags()[1])
                end
                -- This will also un-minimize
                -- the client, if needed
                client.focus = c
                c:raise()
            end
        end),
        awful.button({ }, 3, function ()
            if instance then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({ width=250 })
            end
        end),
        awful.button({ }, 4, function ()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
        awful.button({ }, 5, function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end))

        for s = 1, screen.count() do
            -- Create a promptbox for each screen
            mypromptbox[s] = awful.widget.prompt()
            -- Create an imagebox widget which will contains an icon indicating which layout we're using.
            -- We need one layoutbox per screen.
            mylayoutbox[s] = awful.widget.layoutbox(s)
            mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
            -- Create a taglist widget
            mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

            -- Create a tasklist widget
            mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

            -- Create the wibox
            mywibox[s] = awful.wibox({ position = "top", screen = s })

            -- Widgets that are aligned to the left
            local left_layout = wibox.layout.fixed.horizontal()
            -- left_layout:add(mylauncher)
            left_layout:add(mytaglist[s])
            left_layout:add(mypromptbox[s])
            left_layout:add(music_prev)
            left_layout:add(music_play)
            left_layout:add(music_next)

            -- Widgets that are aligned to the right
            local right_layout = wibox.layout.fixed.horizontal()
            right_layout:add(mpdicon)
            right_layout:add(mpdwidget)
            --right_layout:add(pacicon)
            --right_layout:add(pacwidget)
            right_layout:add(netupicon)
            right_layout:add(netwidget)
            right_layout:add(cpuicon)
            right_layout:add(cpuwidget)
            right_layout:add(memicon)
            right_layout:add(memwidget)
            right_layout:add(tempicon)
            right_layout:add(tempwidget)
            right_layout:add(baticon)
            right_layout:add(batwidget)
            right_layout:add(volicon)
            right_layout:add(volumewidget)
            if s == 1 then right_layout:add(wibox.widget.systray()) end
            right_layout:add(mytextclock)
            right_layout:add(mylayoutbox[s])

            -- Now bring it all together (with the tasklist in the middle)
            local layout = wibox.layout.align.horizontal()
            layout:set_left(left_layout)
            layout:set_middle(mytasklist[s])
            layout:set_right(right_layout)

            mywibox[s]:set_widget(layout)
        end

 -- }}}

        -- {{{ Mouse bindings
        root.buttons(awful.util.table.join(
        awful.button({ }, 3, function () mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
        ))
        -- }}}

        -- {{{ Key bindings
        globalkeys = awful.util.table.join(
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

        awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
        awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
        awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
        awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

        -- Media Keys
        awful.key({                   }, "XF86AudioMute", function () awful.util.spawn("amixer set Master toggle") end),
        awful.key({                   }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer set Master 1%+") end),
        awful.key({                   }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer set Master 1%-") end),
        awful.key({                   }, "XF86AudioPlay", function () awful.util.spawn("ncmpcpp toggle") end),
        awful.key({                   }, "XF86AudioNext", function () awful.util.spawn("ncmpcpp next") end),
        awful.key({                   }, "XF86AudioPrev", function () awful.util.spawn("ncmpcpp prev") end),

        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
        awful.key({ modkey,           }, "q", function () awful.util.spawn(browser) end),
        awful.key({ modkey, "Control" }, "r", awesome.restart),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit),

        awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
        awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
        awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
        awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
        awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
        awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
        awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

        awful.key({ modkey, "Control" }, "n", awful.client.restore),

        -- Prompt
        awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

        awful.key({ modkey }, "x",
        function ()
            awful.prompt.run({ prompt = "Run Lua code: " },
            mypromptbox[mouse.screen].widget,
            awful.util.eval, nil,
            awful.util.getdir("cache") .. "/history_eval")
        end),
        -- Menubar
        awful.key({ modkey }, "p", function() menubar.show() end)
        )

        clientkeys = awful.util.table.join(
        awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
        awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
        awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
        awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
        awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
        awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
        awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
        )

        -- Compute the maximum number of digit we need, limited to 9
        keynumber = 0
        for s = 1, screen.count() do
            keynumber = math.min(9, math.max(#tags[s], keynumber))
        end

        -- Bind all key numbers to tags.
        -- Be careful: we use keycodes to make it works on any keyboard layout.
        -- This should map on the top row of your keyboard, usually 1 to 9.
        for i = 1, keynumber do
            globalkeys = awful.util.table.join(globalkeys,
            awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewonly(tags[screen][i])
                end
            end),
            awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewtoggle(tags[screen][i])
                end
            end),
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.movetotag(tags[client.focus.screen][i])
                end
            end),
            awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.toggletag(tags[client.focus.screen][i])
                end
            end))
        end

        clientbuttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize))

        -- Set keys
        root.keys(globalkeys)
        -- }}}

        -- {{{ Rules
        awful.rules.rules = {
            -- All clients will match this rule.
            { rule = { },
            properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = true,
            keys = clientkeys,
            buttons = clientbuttons } },
            { rule = { class = "smplayer" },
            properties = { floating = true } },
            { rule = { class = "Download" },
            properties = { floating = true } },
            { rule = { class = "Gimp" },
            properties = { floating = true } },
            { rule = { class = "ncmpcpp" },
            properties = { floating = true } }, 
            { rule = { class = "Pidgin" },
            properties = { floating = true } }, 
            -- Set Chromium to always map on tags number 2 of screen 1.
            { rule = { class = "Chromium" },
            properties = { tag = tags[1][2] } },
            { rule = { class = "Firefox" },
            properties = { tag = tags[1][2] } },
            { rule = { class = "Pidgin" },
            properties = { tag = tags[1][4] } },
        }
        -- }}}

        -- {{{ Signals
        -- Signal function to execute when a new client appears.
        client.connect_signal("manage", function (c, startup)
            -- Enable sloppy focus
            c:connect_signal("mouse::enter", function(c)
                if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                    and awful.client.focus.filter(c) then
                    client.focus = c
                end
            end)

            if not startup then
                -- Set the windows at the slave,
                -- i.e. put it at the end of others instead of setting it master.
                -- awful.client.setslave(c)

                -- Put windows in a smart way, only if they does not set an initial position.
                if not c.size_hints.user_position and not c.size_hints.program_position then
                    awful.placement.no_overlap(c)
                    awful.placement.no_offscreen(c)
                end
            end

            local titlebars_enabled = false
            if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
                -- Widgets that are aligned to the left
                local left_layout = wibox.layout.fixed.horizontal()
                left_layout:add(awful.titlebar.widget.iconwidget(c))

                -- Widgets that are aligned to the right
                local right_layout = wibox.layout.fixed.horizontal()
                right_layout:add(awful.titlebar.widget.floatingbutton(c))
                right_layout:add(awful.titlebar.widget.maximizedbutton(c))
                right_layout:add(awful.titlebar.widget.stickybutton(c))
                right_layout:add(awful.titlebar.widget.ontopbutton(c))
                right_layout:add(awful.titlebar.widget.closebutton(c))

                -- The title goes in the middle
                local title = awful.titlebar.widget.titlewidget(c)
                title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

                -- Now bring it all together
                local layout = wibox.layout.align.horizontal()
                layout:set_left(left_layout)
                layout:set_right(right_layout)
                layout:set_middle(title)

                awful.titlebar(c):set_widget(layout)
            end
        end)

        client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
        client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
        -- }}}

        -- {{{ Autostart

        function run_once(cmd)
            findme = cmd
            firstspace = cmd:find(" ")
            if firstspace then
                findme = cmd:sub(0, firstspace-1)
            end
            awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
        end

        run_once("nitrogen --restore")
        run_once("nm-applet")
        run_once("fcitx")
        --run_once("cairo-compmgr")
        run_once("xcompmgr")
        run_once("mpd")
        run_once("mpdscribble")
        -- }}}

        autorun = true
        autorunApps = 
        {
            --"urxvt -e ekg2",
            --"chromium",
        }
        if autorun then
            for app = 1, #autorunApps do
                awful.util.spawn(autorunApps[app])
            end
        end
