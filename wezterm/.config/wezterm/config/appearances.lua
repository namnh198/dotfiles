local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	-- disable sound when at the end of doc
	audible_bell = "Disabled",

	-- hide titlebar
	window_decorations = "RESIZE",
	native_macos_fullscreen_mode = true,

	-- padding
	window_padding = {
		left = 15,
		right = 10,
		top = 10,
		bottom = 0,
	},

	-- font
	font = wezterm.font("OperatorMonoSSmLig Nerd Font", { weight = "Regular" }),
	font_size = 13,

	cursor_blink_rate = 800,

	-- tab bar
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 25,
	show_tabs_in_tab_bar = false,

	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},
}
