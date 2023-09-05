local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
	"Fira Code",
	"Twemoji",
    "Twitter Color Emoji",
	"Symbols Nerd Font",
})

config.front_end = "WebGpu"
config.font_size = 11.0

local theme = "Dracula (Official)"
local scheme = wezterm.color.get_builtin_schemes()[theme]
scheme.background = "#101116"
config.color_schemes = {
	[theme] = scheme,
}
config.color_scheme = theme

config.window_background_opacity = 0.8

config.keys = { {
	mods = "CTRL|SHIFT",
	key = "Enter",
	action = wezterm.action.SpawnWindow,
} }

return config
