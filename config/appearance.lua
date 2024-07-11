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

return {
    color_scheme = color_scheme,
    font = font,
    font_size = font_size,

    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.65,
    },

    -- window
    window_background_opacity = 0.9,
    window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
    window_padding = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5,
    },
}
