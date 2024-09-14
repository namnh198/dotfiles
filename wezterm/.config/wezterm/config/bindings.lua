local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{
		key = "n",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ToggleFullScreen,
	},
	-- {
	-- 	key = "c",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	-- },
	-- {
	-- 	key = "k",
	-- 	mods = "CTRL|SHIFT",
	-- 	action = wezterm.action.ClearScrollback("ScrollbackOnly"),
	-- },
	-- {
	-- 	key = "t",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.DisableDefaultAssignment,
	-- },
	-- split
	-- {
	-- 	mods = "LEADER",
	-- 	key = "|",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "-",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	mods = "LEADER",
	-- 	key = "m",
	-- 	action = wezterm.action.TogglePaneZoomState,
	-- },
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
	-- leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = keys,
	mouse_bindings = mouse_bindings,
}
