local wezterm = require('wezterm')

-----------------------------------------------------------------------------------------------------------------------
--#region Color scheme
local color_scheme = 'Catppuccin Mocha'
local mocha = wezterm:get_builtin_color_schemes()['Catppuccin Mocha']
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Font
local font = wezterm.font('JetBrainsMonoNL Nerd Font')
local font_size = 12
--#endregion
-----------------------------------------------------------------------------------------------------------------------

return {
    color_scheme = color_scheme,
    font = font,
    font_size = font_size,

    background = {
        {
            source = { File = wezterm.GLOBAL.background },
            horizontal_align = 'Center',
        },
        {
            source = { Color = mocha['background'] },
            height = '100%',
            width = '100%',
            opacity = 0.95,
        },
    },
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.5,
    },

    -- window
    window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
    window_padding = {
        left = 0,
        right = 0,
        top = 5,
        bottom = 5,
    },
}
