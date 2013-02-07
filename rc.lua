-- rc.lua by intrntbrn
-- www.github.com/intrntbrn

require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require("blingbling")
require("revelation")

-- startup error
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
	-- Make sure we don't go into an endless error loop
	if in_error then return end
	in_error = true

	naughty.notify({ preset = naughty.config.presets.critical,
			 title = "time to debug",
			 text = err,
			 screen = mouse.screen,
			 timeout = 0 })
	in_error = false
    end)
end


-- error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
		     title = "Oops, there were errors during startup!",
		     screen = mouse.screen,
		     text = awesome.startup_errors })
end


-- theme
home = os.getenv("HOME")
awesome_config = home .. "/.config/awesome"
beautiful.init(awesome_config .. "/theme.lua")

-- colors
blue 		= "#00ffff"
white 		= "#ffffff"
black 		= "#0a0a0b"
red 		= "#ea3da3"
green 		= "#16a712"
grey 		= "#6d7c80"

-- path
icons		= awesome_config .. "/icons/newblue/"
iconsmenu   	= awesome_config .. "/icons/menu/"
iconsclient 	= awesome_config .. "/icons/client/"
panel 		= awesome_config .. "/icons/panel/whiteblue/"

-- std programs
terminal	= "gnome-terminal"
browser		= "chromium-browser "
editor		= "vim"
editor_cmd	= terminal .. " -e " .. editor
guieditor	= "emacs "
fm		= "pcmanfm "

-- alias
exec		= awful.util.spawn
sexec		= awful.util.spawn_with_shell
modkey 		= "Mod4"
winkey		= "Mod4"
altkey		= "Mod1"

-- mixed
space 		= 40
widthMpd 	= 340
useMpd 		= true
usePanel	= true
gmailiconchange = nil

-- layouts
layouts =
{
   awful.layout.suit.floating,         -- 1
   awful.layout.suit.tile,             -- 2
   awful.layout.suit.tile.left,        -- 3
   awful.layout.suit.tile.bottom,      -- 4
   awful.layout.suit.tile.top,         -- 5
   awful.layout.suit.fair,             -- 6
   awful.layout.suit.fair.horizontal,  -- 7
   awful.layout.suit.spiral,           -- 8
   awful.layout.suit.spiral.dwindle,   -- 9
   awful.layout.suit.max,              -- 10
}

-- tags
 tags = {
   names  = { "sys", "web", "edit", "mail", "im", "other" },
   layout = { layouts[8],  -- Sys
              layouts[1],  -- Web
              layouts[10], -- Edit
              layouts[8],  -- Mail
              layouts[8],  -- IM
              layouts[8]}, -- Other
   icons  = {nil, icons .. "arrow.png", icons .. "arrow.png", icons .. "arrow.png", icons .. "arrow.png", icons .. "arrow.png"}
   }


 for s = 1, screen.count() do
     tags[s] = awful.tag(tags.names, s, tags.layout)

  for i, t in ipairs(tags[s]) do
      awful.tag.seticon(tags.icons[i], t)
  end
 end


-- menu
mysystemmenu = {
}

myfoldermenu = {
    { "Home", function () run_or_raise(fm, { class="Pcmanfm" }) end, nil },
    { "Downloads", function ()  run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Downloads/") end, nil },
    { "Downloads jD", function ()  run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. " /HDD/Downloads_JD/") end, nil },
    { "Musik", function ()  run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/HDD/Musik/") end, nil },
    { "Filme", function ()  run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/HDD/Film/") end, nil },
    { "Serien", function ()  run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/HDD/Serien/") end, nil },
    { "Stick", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/STICK/") end, nil },
    { " ", function () awful.menu.hide(instance)  end, nil},
    { "Dropbox", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/") end, nil },
    { "Workspace", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/workspace/") end, nil },
    { "Workspace dbx", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/WORKSPACE/") end, nil },
    { " ", function () awful.menu.hide(instance) end, nil},
    { "awesome", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/.config/awesome/") end, nil },
    { "icons", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/icons/") end, nil },
    { "shared icons", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " /usr/share/icons/") end, nil },
    { "shared themes", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " /usr/share/themes/") end, nil },
    { " ", function () awful.menu.hide(instance) end, nil},
    { "SS2012", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/SS2011/SS2012/")  end, nil },
    { "SE", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/SS2011/SS2012/SE") end},
    { "DB", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/SS2011/SS2012/Datenbanken") end},
    { "MPS", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/SS2011/SS2012/MPS-ARM") end},
    { "OS", function () run_or_raise(fm, { class="Pcmanfm" }) exec(fm .. " " .. home .. "/Dropbox/SS2011/SS2012/Betriebssysteme") end},
}

myinternetmenu = {
    { "Dwb", "dwb"},
    { "Firefox", "firefox"},
    { " ", function () awful.menu.hide(mymainmenu) end, nil},
    { "Steam friends", terminal .. " -e mono " .. home .. "/bin/Vapor/Vapor.exe" },
    { "Mcabber", terminal .. " -e mcabber" },
    { "jDownloader", function () exec("jdownloader") end},
    { "IRC", terminal .. " -e weechat-curses" },
    { " ", function () awful.menu.hide(mymainmenu) end, nil},
    { "Wicd", "wicd-gtk"},
}

mymultimediamenu = {
    { "ncmpcpp", terminal .. " -e ncmpcpp"},
    { "Dreambox WebTV", "gnome-mplayer stream.m3u" },
    { "Vlc", function () exec("vlc") end},
}

mydevelmenu = {
    { "Eclipse", "eclipse" },
    { "Netbeans", function () sexec("wmname LG3D; netbeans --laf com.sun.java.swing.plaf.gtk.GTKLookAndFeel") end},
    { "Insight ARM", function () sexec("" .. home .. "/toolchain/insight/bin/arm-none-eabi-insight") end},
    { "MagicDraw", function () sexec("wmname LG3D; sh " .. home .. "/bin/MagicDraw/bin/mduml") end},
}

mygraphicsmenu = {
    { "Gimp", function () exec("gimp") end},
    { "Mirage", function () exec("mirage") end},
    { "Feh", function () sexec("feh") end},
}

mymainmenu = awful.menu({ items = {
    { "Internet", myinternetmenu, iconsmenu .. "internet.png" },
    { "Multimedia", mymultimediamenu, iconsmenu .. "multimedia.png" },
    { "Development", mydevelmenu, iconsmenu .. "development.png" },
    { "Graphics", mygraphicsmenu, iconsmenu .. "graphics.png" },
    { "Folder", myfoldermenu, iconsmenu .."folder.png" },
    { " ", function () awful.menu.hide(mymainmenu) end, nil},
    { "Terminal", terminal },
    { "Browser", function () exec(browser) end},
    { "Filemanager", function () exec(fm .. "" .. home .. "/") end},
    { "Editor", function () sexec(guieditor) end},
    { " ", function () awful.menu.hide(mymainmenu) end, nil},
    { "Exit", mysystemmenu, iconsmenu .. "arch-red.png" },
    { "Shutdown", awesome_config .. "/scripts/session.sh" }
}})


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
				     menu = mymainmenu })


-- systray
mysystray = widget({ type = "systray" })


-- wiboxes
mywibox = {}
mywib = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
		    awful.button({ }, 1, awful.tag.viewonly),
		    awful.button({ modkey }, 1, awful.client.movetotag),
		    awful.button({ }, 3, awful.tag.viewtoggle),
		    awful.button({ modkey }, 3, awful.client.toggletag),
		    awful.button({ }, 4, awful.tag.viewnext),
		    awful.button({ }, 5, awful.tag.viewprev)
		    )
mytasklist = {}


mytasklist.buttons = awful.util.table.join(
		     awful.button({ }, 1, function (c)
					      if c == client.focus then
							c.minimized = true
							client.focus = c
					      else
						  if not c:isvisible() then
							awful.tag.viewonly(c:tags()[1])
							client.focus = c
						  end
						  -- This will also un-minimize
						  -- the client, if needed
						  client.focus = c
						  c:raise()
					      end
					  end),
		     -- right mouse: my nav menu
		     awful.button({ }, 3, function (c)
						client.focus = c
						instance = awful.menu.showNavMenu({ width=100 })

					  end),
		     awful.button({ }, 4, function ()
					      awful.client.focus.byidx(1)
					      if client.focus then client.focus:raise() end
					  end),
		     awful.button({ }, 5, function ()
					      awful.client.focus.byidx(-1)
					      if client.focus then client.focus:raise() end
					  end)

		     -- middle mouse: swap client to master
		     --awful.button({ }, 0, function (c)
					      --if c == client.focus then
						 ----  c.minimized = true
						  --client.focus = c
						  --c:swap(awful.client.getmaster())
					      --else
						  --if not c:isvisible() then
						      --awful.tag.viewonly(c:tags()[1])
							--client.focus = c
						 	--c:swap(awful.client.getmaster())
						  --end
						  ---- This will also un-minimize
						  ---- the client, if needed
						  --client.focus = c
						  --c:raise()
						  --c:swap(awful.client.getmaster())
					      --end
					  --end)
		     )

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
			   awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
			   awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
			   awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
			   awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
					      return awful.widget.tasklist.label.currenttags(c, s)
					  end, mytasklist.buttons)



-- widgets

---------- spacer
	spacer = widget({ type = "textbox" })
	spacer.text = " "

	center = widget({ type = "textbox" })
	center.text = ""
	center.width = 305


---------- debugger
	debugger = widget({ type = "textbox" })


---------- textclock
	mytextclock = awful.widget.textclock({ align = "right",}, "%A, %d/%m/%Y %H:%M", 100)
	mytextclock.width = 170


---------- google calendar
	function string:split(sep)
        local sep, fields = sep or " ", {}
        local pattern = string.format("([^%s]+)", sep)
        self:gsub(pattern, function(c) fields[#fields+1] = c
	end)
        return fields
	end


	function getgmail()
--	local netrc = io.open("" .. home .. "/.netrc", "r")
--	local gmailstr = netrc:read("*all")
--	netrc:close()
--	gmailstr = string.gsub(string.gsub(gmailstr, "machine mail.google.com login ", ""), "password ", "")
	gmaildata = { }
--	gmaildata = gmailstr:split(" ")
	return gmaildata
	end

	local gcal = nil

	function remove_gcal()
	    if gcal~= nil then
		naughty.destroy(gcal)
		gcal = nil
	    end
	end

	gm = nil
	gpw = nil

	function add_gcal()
	    if (guser and gpw) then
	    remove_gcal()
	    local gcalcinfo = awful.util.pread("gcalcli --user " .. guser .. " --pw " .. gpw .. " --24hr --nc agenda")
	    gcalcinfo = string.gsub(gcalcinfo, "%$(%w+)", "%1")
	    today = os.date("%A, %d. %B") .. "\n"
	    gcal = naughty.notify({
		title = today,
		text = gcalcinfo,
		timeout = 0,
		fg = white,
		bg = blue,
		screen = mouse.screen,
		ontop = true,
		border_color = black,
	    })
	    end
	end
	mytextclock:add_signal("mouse::enter", function()
	    add_gcal()
	end)

	mytextclock:add_signal("mouse::leave", remove_gcal)


---------- calendar
	my_cal =blingbling.calendar.new({type = "imagebox", image = icons .. "clock.png"})
	my_cal:set_cell_padding(3)
	my_cal:set_title_font_size(8)
	my_cal:set_font_size(8)
	my_cal:set_inter_margin(1)
	my_cal:set_columns_lines_titles_font_size(8)
	my_cal:set_columns_lines_titles_text_color(white)
	my_cal:set_link_to_external_calendar(false)
	my_cal:set_cell_background_color(blue)
	my_cal:set_title_background_color(blue)
	my_cal:set_title_text_color(white)
	my_cal:set_text_color(black)
	my_cal:set_cell_padding(4)

----------- round()
	function round(num, idp)
		if (num ~= nil) then
			local mult = 10^(idp or 0)
			return math.floor(num * mult + 0.5) / mult
		else
			return 0
		end
	end

---------- wlan downstream
	netwidget = widget({ type = "textbox" })
	vicious.register(netwidget, vicious.widgets.net,
	function (widget, args)
	    return round(args["{wlan0 down_kb}"], 0) .. "kb"
	end, 5)
	netwidget.width = space

	neticon = widget({ type = "imagebox" })
	neticon.image = image(icons .. "net_down_01.png")

---------- weather
	--weathericon = widget({ type = "imagebox" })
	--weathericon.image = image(icons .. "temp.png")

	--weatherwidget = widget({ type = "textbox" })
	--weatherwidget.width = space
	--weather_t = awful.tooltip({ objects = { weatherwidget },})

	--vicious.register(weatherwidget, vicious.widgets.weather,
	--function (widget, args)
	    --weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
	    --return args["{tempc}"] .. "°"
	--end, 1800, "EDDF")

---------- wlan widget
	wlanicon = widget({ type = "imagebox" })
	wlanicon.image = image(icons .. "wifi_01.png")

	wlanwidget = widget({ type = "textbox" })

	wlanwidget_t = awful.tooltip({ objects = { wlanicon },})

	vicious.register(wlanwidget, vicious.widgets.wifi,
	function (widget, args)
		if (not assert(args["{link}"]) or (args["{link}"] == 0)) then
			netwidget.width = 0
			netwidget.visible = false
			neticon.visible = false
			return  "off"
		else
			netwidget.width = space
			netwidget.visible = true
			neticon.visible = true

			wlanwidget_t:set_text(
			"<span color='" .. white .. "'> SSID: </span>" .. "<span color='" .. black .. "'>" .. args["{ssid}"] .. " </span>\n" ..
			"<span color='" .. white .. "'> Chan: </span>" .. "<span color='" .. black .. "'>" .. args["{chan}"] .. " </span>"
			)
			return round(((args["{link}"] *100) / 70), 0) .. "%"

		end
	end, 10, "wlan0")

	wlanwidget.width = space


---------- mem load
	mymem = widget({ type = "textbox" })
	vicious.register(mymem, vicious.widgets.mem, "$1%", 30)
	mymem.width = space

	mymemicon = widget({ type = "imagebox" })
	mymemicon.image = image(icons .. "mem.png")

---------- cpu freq
	function cpufreq(whichcpu)
	    local file = io.open("/sys/devices/system/cpu/" .. whichcpu .. "/cpufreq/scaling_cur_freq", "r")
	    local cpufreq = file:read("*n")
	    file:close()
	    return cpufreq / 1000
	end



---------- cpu load
	mycpuload = widget({ type = "textbox" })
	vicious.register(mycpuload, vicious.widgets.cpu, "$1%", 5)
	mycpuload.width = space

	mycpuloadicon = widget({ type = "imagebox" })
	mycpuloadicon.image = image(icons .. "cpu.png")

---------- fan()
	-- function fan()
	--     local file = io.open("/sys/devices/platform/thinkpad_hwmon/fan1_input", "r")
	--     local fan = file:read("*n")
	--     file:close()

    	--     return fan
	-- end

---------- cputmp()
	function cputemp()
	    local file = io.open("/sys/class/thermal/thermal_zone0/temp", "r")
	    local output = file:read("*n")
	    file:close()
    	    return output / 1000
	end

---------- cpu popup

	mycpu_t = awful.tooltip({ objects = { mycpuloadicon },})
	mycpuloadicon:add_signal("mouse::enter", function()
	mycpu_t:set_text(
	"<span color='" .. white .. "'> CPU 0:</span> <span color='" .. black .. "'>" .. cpufreq("cpu0") .. " Mhz</span> \n" ..
	"<span color='" .. white .. "'> CPU 1:</span> <span color='" .. black .. "'>" .. cpufreq("cpu1") .. " Mhz</span> \n" ..
--	"<span color='" .. white .. "'> Fan:</span> <span color='" .. black .. "'>\t" .. fan() .. " RPM</span> \n" ..
	"<span color='" .. white .. "'> Temp:</span> <span color='" .. black .. "'>\t" .. cputemp() .. " °C</span> ")
	end)


---------- volume
	myvolicon = widget({ type = "imagebox" })
	myvolicon.image = image(icons .. "spkr_01.png")

	myvol = widget({ type = "textbox" })
		vicious.register(myvol, vicious.widgets.volume,
		function (widget, args)
			if ((args[1] < 1) or (args[2] == "off")) then
				myvolicon.image = image(icons .. "spkr_02.png")
				return "mute"
			else
				myvolicon.image = image(icons .. "spkr_01.png")
				return args[1] .. "%"
			end
		end, 2, "Master")

	myvol.width = space

	myvolicon:buttons(awful.util.table.join(
	awful.button({ }, 1, function () sexec("sh ~/bin/vol.sh mute", false) end)))



---------- battery
	mybaticon = widget({ type = "imagebox" })
	mybaticon.image = image(icons .. "bat_full_01.png")

	-- batstate()
	function batstate()
		local fileee = io.open("/sys/class/power_supply/BAT0/status", "r")
		local batstate = fileee:read("*line")
		if ((batstate == 'Discharging') or (batstate == 'Charging')) then
			return batstate
		else
			return "Fully Charged"
		end
	end


	-- shutdown()
	function shdown()
		sexec("sudo pm-suspend")
	end


	-- watt()
	function watt()

		if (batstate() == 'Discharging') then

			if(assert(io.open("/sys/devices/platform/smapi/BAT0/power_avg", "r"))) then

				local file = io.open("/sys/devices/platform/smapi/BAT0/power_avg", "r")
				local avg = file:read("*n")
				file:close()

				wattavg = ((avg * -1) / 1000)

				return round(wattavg, 2) .. " W"
			else
				return "Error"
			end
		else
			return "n/a"
		end
	end


	-- remaining()
	function remaining()

		if (batstate() == 'Fully Charged') then
			return "n/a"
		end

		if (batstate() == 'Discharging') then

				if (assert(io.open("/sys/devices/platform/smapi/BAT0/remaining_running_time", "r"))) then
					local file = (io.open("/sys/devices/platform/smapi/BAT0/remaining_running_time", "r"))
					local remain = file:read("*n")
					file:close()

					return remain .. " min"

				else return "Error"
				end
		else

			if (assert(io.open("/sys/devices/platform/smapi/BAT0/remaining_charging_time", "r"))) then
				local filee = io.open("/sys/devices/platform/smapi/BAT0/remaining_charging_time", "r")
				local charge = filee:read("*n")
				filee:close()
				return charge .. " min"
			else
				return "Error"
			end
		end
	 end

	 -- batterypopup
	-- mybat_t = awful.tooltip({ objects = { mybaticon },})
	-- mybaticon:add_signal("mouse::enter", function()
	-- mybat_t:set_text(
	-- "<span color='" .. white .. "'> Status:  </span>" .. "<span color='" .. black .. "'>" .. batstate() .. "</span> \n" ..
	-- "<span color='" .. white .. "'> Usage:   </span>" .. "<span color='" .. black .. "'>" .. watt() .. "</span> \n" ..
	-- "<span color='" .. white .. "'> Remain:  </span>" .. "<span color='" .. black .. "'>" .. remaining() .. "</span> "
	-- ) end)

	-- mybat = widget({ type = "textbox" })
	-- vicious.register(mybat, vicious.widgets.bat,
	-- function (widget, args)

	-- 		batnofiy = nil

	-- 		-- critical ( < 4)
	-- 		if (args[2] < 4 and batstate() == 'Discharging') then
	-- 			naughty.notify({
	-- 					text = "hybernating to disk now",
	-- 					title = "Critical Battery",
	-- 					position = "top_right",
	-- 					timeout = 30,
	-- 					fg=black,
	-- 					bg=red,
	-- 					screen = 1,
	-- 					ontop = true,
	-- 					screen = mouse.screen,
	-- 					run = function () sexec("sudo pm-suspend") end
	-- 			})
	-- 			shdown()
	-- 			mybaticon.image = image(icons .. "bat_empty_01.png")
	-- 			return args[2] .. "%"

	-- 		-- low ( < 10)
	-- 		elseif (args[2] < 10 and batstate() == 'Discharging') then
	-- 			naughty.notify({
	-- 					text = "charge now",
	-- 					title = "Low Battery",
	-- 					position = "top_right",
	-- 					timeout = 1,
	-- 					fg=white,
	-- 					bg=blue,
	-- 					screen = mouse.screen,
	-- 					ontop = true,
	-- 			})

	-- 			mybaticon.image = image(icons .. "bat_empty_01.png")
	-- 			return args[2] .. "%"

	-- 		-- normal discharging
	-- 		elseif (batstate() == 'Discharging') then
	-- 			mybaticon.image = image(icons .."bat_full_01.png")
	-- 			return args[2] .. "%"
	-- 		-- charging
	-- 		else
	-- 			mybaticon.image = image(icons .. "ac_01.png")
	-- 			return args[2] .. "%"
	-- 	end
	-- end, 61, 'BAT0')
	-- mybat.width = space

---------- gmailwidget + notifactions
mygmail = widget({ type = "textbox" })
mygmail.width = space

mygmailicon = widget({ type = "imagebox" })
mygmailicon.image = image(icons .. "mail.png")

mygmail_t = awful.tooltip({ objects = { mygmailicon },})

gmailcount = 0

vicious.register(mygmail, vicious.widgets.gmail,
		function (widget, args)
		if (args["{count}"] > 0) then
		    if gmailiconchange then
			mygmailicon.image = image(icons .. "mail_new.png")
		    end

		    if (gmailcount < args["{count}"]) then
			naughty.notify({
			text = "\n" .. args["{subject}"],
			title = "<span color='" .. white .. "'>" .. args["{count}"] .. " unread Mails: </span><span color='" .. black .. "'>" .. "(".. guser .. ")" .. "</span>",
			timeout = 5,
			icon = iconsclient .. "mailnoti.png",
			fg=white,
			bg=blue,
			border_color = black,
			position = "bottom_right",
			screen = mouse.screen,
			ontop = true,
			run = function () awful.util.spawn(browser .. "https://mail.google.com") end,
			})
		    end
		    mygmail_t:set_text(
		    "<span color='" .. white .. "'>" .. args["{count}"] .. " unread Mails: </span><span color='" .. black .. "'>" .. "(".. guser .. ")" .. "</span>\n" ..
		    "<span color='" .. black .. "'>" .. args["{subject}"] .. "</span>"
		    )

		else
		    if gmailiconchange then
			mygmailicon.image = image(icons .. "mail.png")
		    end
		end

		gmailcount = args["{count}"]

		return args["{count}"]
		end, 300)

mygmailicon:buttons(awful.util.table.join(awful.button({ }, 1, function () sexec(browser .. "https://mail.google.com", false) end)))

---------- htop popup on mymemicon
blingbling.popups.htop(mymemicon, { title_color = white, user_color = black, root_color = black, terminal = "urxvt"})

---------- netstat popup on wlanicon
--blingbling.popups.netstat(wlanicon,{ title_color = blue, established_color= green, listen_color = white})



---- MY SHORTCUTS

if usePanel then

panelin = widget({ type = "imagebox" })
panelin.image = image(panel .. "panelin.png")

panelout = widget({ type = "imagebox" })
panelout.image = image(panel .. "panelout.png")


sc_music = widget({ type = "imagebox" })
sc_music.image = image(panel .. "note.png")
sc_music:buttons(awful.util.table.join(awful.button({ }, 1, function () sexec("ncmpcpp play") run_or_raise(terminal .. " -e ncmpcpp", { class = "URxvt", name = "ncmpcpp" }) end)))
sc_music_t = awful.tooltip({ objects = { sc_music },})
sc_music_t:set_text(" ncmpcpp ")

sc_jabber = widget({ type = "imagebox" })
sc_jabber.image = image(panel .. "contacts.png")
sc_jabber:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise(terminal .. " -e mcabber", { class = "URxvt", name = "mcabber" }) end)))
sc_jabber_t = awful.tooltip({ objects = { sc_jabber },})
sc_jabber_t:set_text(" mcabber ")

sc_jdownloader = widget({ type = "imagebox" })
sc_jdownloader.image = image(panel .. "jdownloader.png")
sc_jdownloader:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise("jdownloader", { class = "jd-Main", name = "JDownloader" }) end)))
sc_jdownloader_t = awful.tooltip({ objects = { sc_jdownloader },})
sc_jdownloader_t:set_text(" jDownloader ")

sc_geany = widget({ type = "imagebox" })
sc_geany.image = image(panel .. "geany.png")
sc_geany:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise("geany", { class = "Geany" }) end)))
sc_geany_t = awful.tooltip({ objects = { sc_geany },})
sc_geany_t:set_text(" geany ")

sc_gimp = widget({ type = "imagebox" })
sc_gimp.image = image(panel .. "colors.png")
sc_gimp:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise("gimp", { class = "Gimp" }) end)))
sc_gimp_t = awful.tooltip({ objects = { sc_gimp },})
sc_gimp_t:set_text(" gimp ")

sc_eclipse = widget({ type = "imagebox" })
sc_eclipse.image = image(panel .. "eclipse.png")
sc_eclipse:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise("eclipse", { class = "Eclipse" }) end)))
sc_eclipse_t = awful.tooltip({ objects = { sc_eclipse },})
sc_eclipse_t:set_text(" eclipse ")

sc_pcmanfm = widget({ type = "imagebox" })
sc_pcmanfm.image = image(panel .. "pcmanfm.png")
sc_pcmanfm:buttons(awful.util.table.join(
	    awful.button({ }, 1, function () run_or_raise("pcmanfm", { class = "Pcmanfm" }) end),
	    awful.button({ }, 3, function () instance = showPlacesMenu({ width=110 }) end )
))
sc_pcmanfm_t = awful.tooltip({ objects = { sc_pcmanfm },})
sc_pcmanfm_t:set_text(" pcmanfm ")

function showPlacesMenu(menu, args)
    if not menu then
        menu = {}
    end
    menu.items = myfoldermenu

    local m = awful.menu.new(menu)
    m:show(args)
    return m
end


sc_pacman = widget({ type = "imagebox" })
sc_pacman.image = image(panel .. "pacman.png")
sc_pacman:buttons(awful.util.table.join(awful.button({ }, 1, function () exec(terminal .. " -e yaourt -Syyua") end)))
sc_pacman_t = awful.tooltip({ objects = { sc_pacman },})
sc_pacman_t:set_text(" pacman ")

sc_calc = widget({ type = "imagebox" })
sc_calc.image = image(panel .. "calc.png")
sc_calc:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise("gnome-calculator", { class = "Gnome-calculator" }) end)))
sc_calc_t = awful.tooltip({ objects = { sc_calc },})
sc_calc_t:set_text(" calculator ")

sc_irc = widget({ type = "imagebox" })
sc_irc.image = image(panel .. "irc.png")
sc_irc:buttons(awful.util.table.join(awful.button({ }, 1, function () run_or_raise(terminal .. " -e weechat-curses", { class = "URxvt", name = "weechat-curses" }) end)))
sc_irc_t = awful.tooltip({ objects = { sc_irc },})
sc_irc_t:set_text(" weechat ")

sc_shutdown = widget({ type = "imagebox" })
sc_shutdown.image = image(panel .. "shutdown.png")
function showShutdownMenu(menu, args)
    if not menu then
        menu = {}
    end
    menu.items = mysystemmenu

    local m = awful.menu.new(menu)
    m:show(args)
    return m
end
sc_shutdown:buttons(awful.util.table.join(awful.button({ }, 1, function () instance = showShutdownMenu({ width=110 }) end)))
sc_shutdown_t = awful.tooltip({ objects = { sc_shutdown },})
sc_shutdown_t:set_text(" quit ")

end

------ MPD
	if useMpd then

	panelinmusic = widget({ type = "imagebox" })
	panelinmusic.image = image(panel .. "panelinmusic.png")

	paneloutmusic = widget({ type = "imagebox" })
	paneloutmusic.image = image(panel .. "paneloutmusic.png")

	  music_play = awful.widget.launcher({
	    image = image(panel .. "play.png"),
	    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })

	  music_pause = awful.widget.launcher({
	    image = image(panel .. "pause.png"),
	    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })
	  music_pause.visible = false

	  music_stop = awful.widget.launcher({
	    image = image(panel .. "stop.png"),
	    command = "ncmpcpp stop && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })

	  music_prev = awful.widget.launcher({
	    image = image(panel .. "prev.png"),
	    command = "ncmpcpp prev && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })

	  music_next = awful.widget.launcher({
	    image = image(panel .. "next.png"),
	    command = "ncmpcpp next && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })
	  maxlength = 15

	  mpdicon = awful.widget.launcher({
	    image = image(panel .. "note.png"),
	    command = "ncmpcpp toggle && echo -e 'vicious.force({ mpdwidget, })' | awesome-client"
	  })

	  mpdwidget = widget({ type = "textbox" })
	  mpdwidget.width = widthMpd
	  vicious.register(mpdwidget, vicious.widgets.mpd,
	    function(widget, args)

	      local string =  args["{Artist}"] .. " - " .. args["{Title}"] .. "     "

	      -- play
	      if (args["{state}"] == "Play") then
		music_play.visible = false
		music_pause.visible = true
		music_next.visible = true
		music_prev.visible = true
		music_stop.visible = true
		mpdwidget.visible = true
		center.visible = false
		panelinmusic.visible = true
		paneloutmusic.visible = true
		return string

	      -- pause
	      elseif (args["{state}"] == "Pause") then

		music_play.visible = true
		music_pause.visible = false
		music_next.visible = true
		music_prev.visible = true
		music_stop.visible = true
		mpdwidget.visible = true
		center.visible = false
		panelinmusic.visible = true
		paneloutmusic.visible = true
		return string

	      -- stop
	      else
		music_play.visible = false
		music_pause.visible = false
		music_next.visible = false
		music_prev.visible = false
		music_stop.visible = false
		mpdwidget.visible = false
		center.visible = true
		panelinmusic.visible = false
		paneloutmusic.visible = false
		return string

	      end

	    end, 1)
	end


-- wibox

    -- top
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16})

	mywibox[s].widgets = {
	    {
		mylauncher,
		spacer,
		mytaglist[s],
		spacer,
		mylayoutbox[s],
		mypromptbox[s],
		spacer,
		debugger,

		center,

		layout = awful.widget.layout.horizontal.leftright,
	    },


		mytextclock,
		my_cal.widget,

		mybat,
		mybaticon,

		myvol,
		myvolicon,

		mymem,
		mymemicon,

		mycpuload,
		mycpuloadicon,

		netwidget,
		neticon,

		wlanwidget,
		wlanicon,

	--	weatherwidget,
	--	weathericon,


		mygmail,
		mygmailicon,

		spacer,


		layout = awful.widget.layout.horizontal.rightleft
    }


    -- bottom
    mywib[s] = awful.wibox({ position = "bottom", screen = s})


    mywib[s].widgets = {
		mysystray,
		mytasklist[s],

		layout = awful.widget.layout.horizontal.rightleft
    }
end


-- mouse binds
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


-- key binds
globalkeys = awful.util.table.join(
    awful.key({ modkey	       }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey	       }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey	       }, "Escape", awful.tag.history.restore),
    awful.key({ modkey, "Ctrl" }, "+", function () sexec("sh amixer -c 0 set Master 2+ unmute" ) end),
    awful.key({ modkey, "Ctrl" }, "-", function () sexec("sh amixer -c 0 set Master 2- unmute" ) end),
    awful.key({ modkey, "Ctrl" }, "m", function () sexec("sh amixer -c 0 set Master mute") end),
    awful.key({                }, "#233", function () sexec("sh ~/bin/bright.sh") end),
    awful.key({                }, "#232", function () sexec("sh ~/bin/bright.sh") end),
    awful.key({                }, "#107", function () sexec("cd " .. home .. "/snapshot/ ; scrot; notify-send 'screenshot taken'") end),

 --   awful.key({"Control"}, "space", revelation),

    awful.key({ altkey,	       }, "Tab",
	function ()
	    awful.client.focus.byidx( 1)
	    if client.focus then client.focus:raise() end
	end),
    awful.key({ altkey,	"Shift"   }, "Tab",
	function ()
	    awful.client.focus.byidx(-1)
	    if client.focus then client.focus:raise() end
	end),
    awful.key({ modkey,	   }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey			    }, "Tab", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.client.swap.byidx( -1)    end),
    awful.key({ altkey	    }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ altkey	    }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,	   }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,	   }, "Tab",
	function ()
	    awful.client.focus.history.previous()
	    if client.focus then
		client.focus:raise()
	    end
	end),

    -- Standard program
    awful.key({ modkey   	 }, "Return", function () awful.tag.viewonly(tags[mouse.screen][1]) awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ }, "F1", function () exec("dwb") end),
    awful.key({ }, "F8", function () exec(browser .. " --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version=11.3.31.103 --enable-user-scripts") end),
    awful.key({}, "#160", function () exec("slimlock") end),
    awful.key({}, "#150", function () sexec("sudo pm-suspend") end),

    awful.key({ modkey,	   }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,	   }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)	 end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)	 end),
    awful.key({ altkey,	   }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },	    "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
	      function ()
		  awful.prompt.run({ prompt = "Run Lua code: " },
		  mypromptbox[mouse.screen].widget,
		  awful.util.eval, nil,
		  awful.util.getdir("cache") .. "/history_eval")
	      end)
)

clientkeys = awful.util.table.join(
    awful.key({ altkey	   }, "m",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ "Control"   	  }, "q",      function (c) c:kill()			 end),
--    awful.key({ altkey }, "d",  awful.client.floating.toggle		     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,	   }, "o",      awful.client.movetoscreen			),
    awful.key({ altkey,	   }, "t",      function (c) c.ontop = not c.ontop	    end)
--    ,
--    awful.key({ altkey	   }, "n",
--        function (c)
--            -- The client currently has the input focus, so it cannot be
--            -- minimized, since minimized clients can't have the focus.
--            c.minimized = true
--        end)
--,
--     awful.key({ altkey	   }, "f",
-- 	function (c)
-- 	    c.maximized_horizontal = not c.maximized_horizontal
-- 	    c.maximized_vertical   = not c.maximized_vertical
-- 	end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
	awful.key({ "Control" }, "#" .. i + 9,
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
	awful.key({ altkey }, "#" .. i + 9,
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
    awful.button({ altkey }, 1, awful.mouse.client.move),
    awful.button({ altkey }, 3, awful.mouse.client.resize))

root.keys(globalkeys)



-- rules

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
		     border_color = beautiful.border_normal,
		     focus = true,
		     keys = clientkeys,
		     buttons = clientbuttons,
		     size_hints_honor = false } },


      -- 1: sys

      -- 2: web
	{ rule = { class = "Firefox" },
          properties = { tag = tags[mouse.screen][2], maximized_vertical = true, maximized_horizontal = true, switchtotag = true, floating = false, }},

	{ rule = { class = "Chromium" },
          properties = { tag = tags[mouse.screen][2], maximized_vertical = true, maximized_horizontal = true, switchtotag = true, floating = false, }},

	{ rule = { class = "Firefox" },
          except = { instance = "Navigator" },
          properties = { tag = tags[mouse.screen][2], floating = true, switchtotag = true },
	},

	{ rule = { class = "Dwb" },
          properties = { tag = tags[mouse.screen][2], switchtotag = true , maximized_vertical = true, maximized_horizontal = true, floating = false }
	},

      -- 3: edit
	{ rule = { class = "Epdfview" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true }
	},
	{ rule = { class = "Zathura" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true }
	},
	{ rule = { class = "Geany" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true }
	},
        { rule = { class = "Emacs", instance = "emacs" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false}
        },
	{ rule = { class = "NetBeans" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false }
	},
	{ rule = { class = "sun-awt-X11-XFramePeer" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false }
	},
	{ rule = { class = "java-lang-Thread" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false }
	},
	{ rule = { class = "Eclipse" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false }
	},
	{ rule = { class = "com-nomagic-launcher-Launcher" },
          properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false}
	},
	{ rule = { class = "sublime_text" },
	      properties = { tag = tags[mouse.screen][3], switchtotag = true, floating = false}
    },

  -- 4: Mail
  

      -- 5: im
        { rule = { class = "Empathy", instance = "empathy" }, 
          properties = { tag = tags[mouse.screen][5], floating = false }
        },
        { rule = { class = "empathy" }, 
          properties = { floating = true }
        },
        { rule = { class = "URxvt", name = "mcabber"},
          properties = { tag = tags[mouse.screen][5], switchtotag = true }
        },
        { rule = { class = "URxvt", name = "weechat-curses"},
          properties = { tag = tags[mouse.screen][5], switchtotag = true }
        },

      -- 6: other
        { rule = { class = "Spotify" },
          properties = { tag = tags[mouse.screen][6], switchtotag = false }
        },
        { rule = { class = "Mplayer" },
          properties = { tag = tags[mouse.screen][6], switchtotag = true }
        },
        { rule = { class = "Vlc" },
          properties = { tag = tags[mouse.screen][6], switchtotag = true }
        },
        { rule = { class = "Gimp" },
          properties = { tag = tags[mouse.screen][6], switchtotag = true, floating = true }
        },
        { rule = { class = "Gimp", role = "toolbox" },
          properties = { tag = tags[mouse.screen][6], switchtotag = true, floating = true, 
                         maximized_vertical = true, ontop = true }
        },
        { rule = { class = "URxvt", name = "ncmpcpp"},
          properties = { tag = tags[mouse.screen][6], switchtotag = true }
        },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.

client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
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
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- naughty notifications
function closeLastNoti()
    screen = mouse.screen
    for p,pos in pairs(naughty.notifications[screen]) do
	for i,n in pairs(naughty.notifications[screen][p]) do
			if (n.width == 258) then -- to close only previous bright/vol notifications
	    naughty.destroy(n)
	    break
	    end
	end
    end
end

-- volume notification

volnotiicon = nil

function volnoti()
					closeLastNoti()
					naughty.notify{
					icon = volnotiicon,
					position = "top_right",
					fg=black,
					bg=blue,
					border_color = black,
					timeout=1,
					width = 256,
					screen = mouse.screen,
					}
end

brightnotiicon = nil

-- brightness notification

function brightnoti()
					closeLastNoti()
					naughty.notify{
					icon = brightnotiicon,
					position = "top_right",
					fg=black,
					bg=blue,
					timeout=1,
					width = 256,
					screen = mouse.screen,
					}
end

-- mcabber notifcation wrapper (gettin jabber msgs & statusupdates via naughty)

naughty.config.presets.online = {
    bg = green,
    fg = white,
}
naughty.config.presets.chat = naughty.config.presets.online
naughty.config.presets.away = {
    bg = grey,
    fg = white,
}
naughty.config.presets.xa = {
    bg = grey,
    fg = white,
}
naughty.config.presets.dnd = {
    bg = red,
    fg = white,
}
naughty.config.presets.invisible = {
    bg = grey,
    fg = blue,
}
naughty.config.presets.offline = {
    bg = black,
    fg = white,
}
naughty.config.presets.requested = naughty.config.presets.offline
naughty.config.presets.error = {
    bg = black,
    fg = white,
}

muc_nick = "dani"

function mcabber_event_hook(kind, direction, jid, msg)
    if kind == "MSG" then
	if direction == "IN" or direction == "MUC" then
	    local filehandle = io.open(msg)
	    local txt = filehandle:read("*all")
	    filehandle:close()
	    awful.util.spawn("rm "..msg)
	    if direction == "MUC" and txt:match("^<" .. muc_nick .. ">") then
		return
	    end
	    if (awful.tag.selected(mouse.screen).name ~= "msg") then
	    naughty.notify{
	    	fg=black,
		bg=blue,
		timeout=5,
		width = 255,
		position = "bottom_right",
		screen = mouse.screen,
		icon = iconsclient .. "mailnoti.png",
		text = awful.util.escape(txt),
		run = function () awful.tag.viewonly(tags[mouse.screen][5]) end,
		title = jid
	    }
	    end
	end
    elseif kind == "STATUS" then
	local mapping = {
	    [ "O" ] = "online",
	    [ "F" ] = "chat",
	    [ "A" ] = "away",
	    [ "N" ] = "xa",
	    [ "D" ] = "dnd",
	    [ "I" ] = "invisible",
	    [ "_" ] = "offline",
	    [ "?" ] = "error",
	    [ "X" ] = "requested"
	}
	local status = mapping[direction]
	local iconstatus = status
	if not status then
	    status = "error"
	end
	if jid:match("icq") then
	    iconstatus = "icq/" .. status
	end
	naughty.notify{
	    preset = naughty.config.presets[status],
	    text = jid,
	    screen = mouse.screen,
 --	   icon = iconstatus
	}
    end
end

function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      if table.getn(ctags) == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
   for k, v in pairs(table1) do
      if table2[k] ~= v and not table2[k]:find(v) then
         return false
      end
   end
   return true
end

-- disable startup-notification globally
local oldspawn = awful.util.spawn
awful.util.spawn = function (s)
  oldspawn(s, false)
end
