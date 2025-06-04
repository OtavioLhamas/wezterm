local Config = require('config')

require('events.right-status').setup()
local path = require('utils.platform').is_win and 'H:/' or '/mnt/ssd/'
require('utils.backdrops'):set_files(path .. 'Pictures/Wallpapers'):random()

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.bindings'))
    :append(require('config.general'))
    :append(require('config.launch')).options
