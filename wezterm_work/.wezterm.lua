local wezterm = require("wezterm")

return {
	font = wezterm.font_with_fallback({
		"Monoid Nerd Font",
		"Symbols Nerd Font Mono",
	}),
	font_size = 14,
	freetype_load_target = "HorizontalLcd",
	color_scheme = "Kanagawa (Gogh)",
	keys = {
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.DisableDefaultAssignment,
		},
		{
			key = "Enter",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.ToggleFullScreen,
		},
	},
	hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	scrollback_lines = 5000,
}
