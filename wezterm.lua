local Config = require('config')

require('events.right-status').setup()

return Config:init()
    :append(require('config.appearance'))
    :append(require('config.bindings'))
    :append(require('config.general')).options
