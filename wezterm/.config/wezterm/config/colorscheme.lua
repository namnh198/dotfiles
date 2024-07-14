-- Color schema dynamic by OS
-- function scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return {
-- 			color_scheme = "Catppuccin Mocha",
-- 			window_background_gradient = {
-- 				orientation = "Vertical",
-- 				colors = {
-- 					"#1E1E2F",
-- 					"#1E1E2F",
-- 				},
-- 				blend = "Rgb",
-- 				interpolation = "Linear",
-- 			},
-- 		}
-- 	else
-- 		return {
-- 			color_scheme = "Catppuccin Latte",
-- 			window_background_gradient = {
-- 				orientation = "Vertical",
-- 				colors = {
-- 					"#eff1f0",
-- 					"#eff1f0",
-- 				},
-- 				blend = "Rgb",
-- 				interpolation = "Linear",
-- 			},
-- 		}
-- 	end
-- end
--
-- wezterm.on("window-config-reloaded", function(window)
-- 	local overrides = window:get_config_overrides() or {}
-- 	local appearance = window:get_appearance()
-- 	local scheme = scheme_for_appearance(appearance)
-- 	if overrides.color_scheme ~= scheme.color_scheme then
-- 		overrides.color_scheme = scheme.color_scheme
-- 		overrides.window_background_gradient = scheme.window_background_gradient
-- 		window:set_config_overrides(overrides)
-- 	end
-- end)

return {
	color_scheme = "Catppuccin Mocha",

	-- opacity & blur
	window_background_opacity = 0.90,
	macos_window_background_blur = 15,

	window_background_gradient = {
		orientation = "Vertical",
		colors = {
			"#1E1E2F",
			"#1E1E2F",
		},
		blend = "Rgb",
		interpolation = "Linear",
	},
}
