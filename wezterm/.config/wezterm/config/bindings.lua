local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

local mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

return {
	keys = keys,
	mouse_bindings = mouse_bindings,
}
