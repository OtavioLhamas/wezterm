local wezterm = require('wezterm')

-----------------------------------
--#region Color scheme
local color_scheme = 'Catppuccin Mocha'
--#endregion
-----------------------------------

-----------------------------------
--#region Font
local font = wezterm.font('JetBrainsMonoNL Nerd Font')
local font_size = 12
--#endregion
-----------------------------------

local inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.65,
}

-- window
local window_padding = {
    left = 5,
    right = 5,
    top = 5,
    bottom = 5,
}

local window_decorations = 'INTEGRATED_BUTTONS|RESIZE'

return {
    color_scheme = color_scheme,
    font = font,
    font_size = font_size,
    inactive_pane_hsb = inactive_pane_hsb,
    window_padding = window_padding,
    window_decorations = window_decorations
}
