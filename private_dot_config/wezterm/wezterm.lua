local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",
	font = wezterm.font({ family = "MonoLisa" }),
	font_rules = {
		{
			italic = false,
			font = wezterm.font({
				family = "MonoLisa",
				style = "Normal",
			}),
		},
		-- Select a fancy italic font for italic text
		{
			italic = true,
			font = wezterm.font({
				family = "MonoLisa",
				style = "Italic",
			}),
		},
	},
	font_size = 15,
	enable_tab_bar = true,
	use_fancy_tab_bar = true,
	audible_bell = "Disabled",

	default_prog = {'/usr/bin/fish', '-l'}
}

