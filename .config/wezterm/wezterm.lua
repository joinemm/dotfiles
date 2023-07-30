-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font_with_fallback({
	"Fira Code",
	"Twemoji",
	"Symbols Nerd Font",
})
config.front_end = "WebGpu"

config.font_size = 12.0
-- This is where you actually apply your config choices

-- For example, changing the color scheme:
local scheme = wezterm.color.get_builtin_schemes()["Dracula (Official)"]
scheme.background = "#101116"

config.color_schemes = {
	["Dracula (Official)"] = scheme,
}
config.color_scheme = "Dracula (Official)"
config.window_background_opacity = 0.8

config.keys = { {
	mods = "CTRL|SHIFT",
	key = "Enter",
	action = wezterm.action.SpawnWindow,
} }

-- and finally, return the configuration to wezterm
return config
