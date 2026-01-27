local wezterm = require('wezterm')
local M = {}

local default_prog = { 'bash', '-l' }
local launch_menu = {
    { label = 'Bash', args = { 'bash', '-l' } },
    { label = 'Zsh', args = { 'zsh', '-l' } },
}

function M:apply(config)
    local platform = require('utils.platform')

    if platform.is_win then
        -- Helper: check if executable exists in Windows PATH
        -- https://github.com/pasanec/wezterm_win/blob/main/wezterm.lua
        local function exe_exists(name)
            local ok, _stdout, _stderr = wezterm.run_child_process({ 'where', name })
            return ok
        end

        local has_pwsh = exe_exists('pwsh.exe')
        local has_powershell = exe_exists('powershell.exe')
        local has_cmd = exe_exists('cmd.exe')

        if has_cmd then
            default_prog = { 'cmd.exe' }
            table.insert(launch_menu, {
                label = 'Command Prompt',
                domain = { DomainName = 'local' },
                args = { 'cmd.exe' },
            })
        end
        if has_powershell then
            default_prog = { 'powershell.exe', '-NoLogo' }
            table.insert(launch_menu, {
                label = 'PowerShell (Windows)',
                domain = { DomainName = 'local' },
                args = { 'powershell.exe', '-NoLogo' },
            })
        end
        if has_pwsh then
            default_prog = { 'pwsh.exe', '-NoLogo' }
            table.insert(launch_menu, {
                label = 'PowerShell (pwsh)',
                domain = { DomainName = 'local' }, -- force Windows domain
                args = { 'pwsh.exe', '-NoLogo' },
            })
        end
    else
        default_prog = { 'fish', '-l' }
        table.insert(launch_menu, { label = 'Fish', args = { 'fish', '-l' } })
    end

    config.default_prog = default_prog
    config.launch_menu = launch_menu
end

return M
