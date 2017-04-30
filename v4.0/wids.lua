local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local vicious = require("vicious")

module("wids")

beautiful.init("~/.config/awesome/theme.lua")

-- Thermal widget
-- package temperature, higher than CPU core temperature, refresh every 4s
thermwidget = wibox.widget.textbox("")
vicious.register(thermwidget, vicious.widgets.thermal, " CPU $1°C ", 4, {"thermal_zone0", "sys"})

-- Battery widget
-- refresh every 30s
batwidget = wibox.widget.textbox("")
vicious.register(batwidget, vicious.widgets.bat, " Battery $2% [$1$3] ", 4, "BAT0")

-- ALSA Volume widget
-- refresh every 1s
volwidget = wibox.widget.textbox("")
vicious.register(volwidget, vicious.widgets.volume, " Volume $1% ", 1, "Master")

-- Disk I/O
diowidget = wibox.widget.textbox("")
vicious.register(diowidget, vicious.widgets.dio, " SSD ${sda read_mb} / ${sda write_mb}MB ", 2)

-- WiFi
wifiwidget = wibox.widget.textbox("")
vicious.register(wifiwidget, vicious.widgets.wifi, " WiFi ${linp}% ", 4, "wlp3s0")
