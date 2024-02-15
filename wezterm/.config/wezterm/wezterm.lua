local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font("SFMono Nerd Font Mono")
config.color_scheme = "OneDark (base16)"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.default_prog = { "/bin/fish" }
config.check_for_updates = false
config.window_padding = {
	left = "0px",
	right = "0px",
	top = "0px",
	bottom = "0px",
}

return config
