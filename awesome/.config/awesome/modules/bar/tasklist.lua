local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("utils")
local beautiful = require("beautiful")

local M = {}

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 2, function(c)
		c:kill()
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function widget_create_callback(self, c)
  utils.hover_effect(self)
	utils.generate_tooltip(self, c.class)
end

function M.initTaskList(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		layout = {
			spacing = dpi(5),
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					id = "icon_role",
					widget = wibox.widget.imagebox,
					scaling_quility = "good",
				},
				widget = wibox.container.margin,
				margins = dpi(2),
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = widget_create_callback
		},
		buttons = tasklist_buttons,
	})
end

return M
