local options = {
    default_prog = {},
    launch_menu = {},
}

local platform = require('utils.platform')

options.default_prog = platform.is_win and { 'pwsh.exe' } or { 'fish', '-l' }

options.launch_menu = {
    { label = 'Bash', args = { 'bash', '-l' } },
    { label = 'Fish', args = { 'fish', '-l' } },
    { label = 'Zsh', args = { 'zsh', '-l' } },
    { label = 'PowerShell', args = { 'pwsh', '-l' } },
}

return options
