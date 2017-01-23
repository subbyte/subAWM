-- Float Console (ccs)
-- Similar to "quake console": http://awesome.naquadah.org/wiki/Drop-down_terminal
--
-- Difference: console created at awesome launch time, so it is more smooth
-- at the first time calling the console. There is only one console for all screen.
--
-- Usage:
--      require("console")
--      awful.key({ modkey, }, "`", function () console.toggle() end)
--      console.init(terminal)

local awful = require("awful")
local capi  = { mouse = mouse, screen = screen, client = client, timer = timer }

module("console")

-- {{{ parameters to adjust the console display
console_margin = 8
console_borderwidth = 1
console_height_ratio = 0.3
-- }}}

console_term = nil
console_name = "ccs"

function get_console_client ()
    local cc = nil
    for c in awful.client.iterate(function (c) return c.instance == console_name end, nil, nil)
    do
        cc = c
    end
    return cc
end

function create()
    if get_console_client() == nil then
        awful.util.spawn(console_term .. " -name " .. console_name)
    end
end

function init(terminal)
    if terminal ~= nil then 
        console_term = terminal
    end

    local reattach = capi.timer { timeout = 0 }
    reattach:connect_signal("timeout", function() reattach:stop() create() end)
    reattach:start()

    capi.client.connect_signal("manage", function (c, startup)
        if c.instance == console_name then
            c.hidden = true
        end
    end)

    capi.client.connect_signal("unmanage", function (c, startup)
        if c.instance == console_name then
            c.hidden = true
        end
    end)
end

function toggle()
    init(nil)
    local cc = get_console_client()

    if cc ~= nil then
        if cc.hidden then
            -- Comptute size
            local geom = capi.screen[capi.mouse.screen].workarea
            local width, height, x, y
            width = geom.width - (console_margin + console_borderwidth) * 2
            height = geom.height * console_height_ratio
            x = geom.x + console_margin
            y = geom.height + geom.y - height - console_margin - console_borderwidth

            -- Resize
            awful.client.floating.set(cc, true)
            cc.border_width = console_borderwidth
            cc.size_hints_honor = false
            cc:geometry({ x = x, y = y, width = width, height = height })

            -- Sticky and on top
            cc.ontop = true
            cc.above = true
            cc.skip_taskbar = true
            cc.sticky = true

            -- This is not a normal window, don't apply any specific keyboard stuff
            cc:buttons({})
            cc:keys({})

            -- display the console
            cc.hidden = false
            cc:raise()
            capi.client.focus = cc
        else
            cc.hidden = true
        end
    end
end
