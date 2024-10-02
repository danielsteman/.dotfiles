local wezterm = require "wezterm"

local keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {key="LeftArrow", mods="OPT", action=wezterm.action{SendString="\x1bb"}},
    -- Make Option-Right equivalent to Alt-f; forward-word
    {key="RightArrow", mods="OPT", action=wezterm.action{SendString="\x1bf"}},
    -- Add other key bindings as needed
    {key="U", mods="CTRL", action=wezterm.action{ScrollByPage=-0.5}},
    {key="D", mods="CTRL", action=wezterm.action{ScrollByPage=0.5}},
}

return keys
