local wezterm = require 'wezterm'
local config = {}

-- Load keys config
local cfg_keys = require 'keys'
config.keys = cfg_keys.keys

config.color_scheme = "Catppuccin Mocha"
config.tab_bar_at_bottom = true

config.font = wezterm.font('MesloLGS NF')
config.font_size = 16.0

config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

config.colors = {
    background = "#000000", 
}

return config
