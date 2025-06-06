local options = {
    default_prog = {},
    launch_menu = {},
}

options.launch_menu = {
    { label = 'Bash', args = { 'bash', '-l' } },
    { label = 'Zsh', args = { 'zsh', '-l' } },
}

local platform = require('utils.platform')

if platform.is_win then
    -- Get PowerShell version table
    local powershell_cmd = require('wezterm').execute_command({
        args = { 'powershell.exe', '-NoProfile', '-Command', '$PSVersionTable.PSVersion.Major' },
        hidden = true,
    })

    local powershell_output = powershell_cmd:wait_for_output()

    -- Trim whitespace and newlines from the output
    local major_version = tonumber(string.match(powershell_output, '^%s*(%d+)%s*$'))

    if major_version and tonumber(major_version) >= 7 then
        options.default_prog = { 'pwsh.exe' }
        table.insert(options.launch_menu, { label = 'PowerShell', args = { 'pwsh', '-l' } })
    else
        options.default_prog = { 'powershell.exe' }
        options.launch_menu:insert({ label = 'PowerShell', args = { 'powershell' } })
    end
else
    options.default_prog = { 'fish', '-l' }
    table.insert(options.launch_menu, { label = 'Fish', args = { 'fish', '-l' } })
end

return options
