local Config = require('config')

require('events.right-status').setup()
require('utils.backdrops'):set_files('/home/otaviolhamas/Pictures/Wallpapers'):random()

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.bindings'))
    :append(require('config.general'))
    :append(require('config.launch')).options
