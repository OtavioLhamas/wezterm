local wezterm = require('wezterm')

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

require('events.right-status').setup()

local path = require('utils.platform').is_win and 'H:/' or '/mnt/ssd/'
require('utils.backdrops'):set_files(path .. 'Pictures/Wallpapers'):random()

require('config.general'):apply(config)
require('config.appearance'):apply(config)
require('config.bindings'):apply(config)
require('config.launch'):apply(config)

return config
