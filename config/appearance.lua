local wezterm = require('wezterm')

local M = {}

-----------------------------------------------------------------------------------------------------------------------
--#region Color scheme
local color_scheme = 'rose-pine'
local mocha = wezterm:get_builtin_color_schemes()['Catppuccin Mocha']
local rose = wezterm:get_builtin_color_schemes()['rose-pine']
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Font
local font = wezterm.font('JetBrainsMonoNL Nerd Font')
local font_size = 12
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Background
local background = {
    {
        source = { File = wezterm.GLOBAL.background },
        horizontal_align = 'Center',
    },
    {
        source = { Color = rose['background'] },
        height = '100%',
        width = '100%',
        opacity = 0.88,
    },
}
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Window
local inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
}
local window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
local window_padding = {
    left = 0,
    right = 0,
    top = 5,
    bottom = 5,
}
--#endregion
-----------------------------------------------------------------------------------------------------------------------

function M:apply(config)
    config.color_scheme = color_scheme

    config.font = font
    config.font_size = font_size

    config.background = background

    config.inactive_pane_hsb = inactive_pane_hsb

    config.window_decorations = window_decorations
    config.window_padding = window_padding
end

return M
