local wezterm = require 'wezterm'
local config = {}

config.color_scheme = "Catppuccin Mocha"
config.tab_bar_at_bottom = true

config.font = wezterm.font 'MesloLGS NF'
config.font_size = 16.0

config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

return config
