local M = {}
local gpu_adapters = require('utils.gpu_adapter')

function M:apply(config)
    -- behaviours
    config.automatically_reload_config = true
    config.exit_behavior = 'CloseOnCleanExit' -- if the shell program exited with a successful status
    config.exit_behavior_messaging = 'Verbose'
    config.status_update_interval = 1000

    config.audible_bell = 'Disabled'
    config.hide_mouse_cursor_when_typing = true

    config.scrollback_lines = 5000

    config.front_end = 'WebGpu'
    config.webgpu_power_preference = 'HighPerformance'
    config.webgpu_preferred_adapter = gpu_adapters:pick_best()

    config.hyperlink_rules = {
        -- Matches: a URL in parens: (URL)
        {
            regex = '\\((\\w+://\\S+)\\)',
            format = '$1',
            highlight = 1,
        },
        -- Matches: a URL in brackets: [URL]
        {
            regex = '\\[(\\w+://\\S+)\\]',
            format = '$1',
            highlight = 1,
        },
        -- Matches: a URL in curly braces: {URL}
        {
            regex = '\\{(\\w+://\\S+)\\}',
            format = '$1',
            highlight = 1,
        },
        -- Matches: a URL in angle brackets: <URL>
        {
            regex = '<(\\w+://\\S+)>',
            format = '$1',
            highlight = 1,
        },
        -- Then handle URLs not wrapped in brackets
        {
            regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
            format = '$0',
        },
        -- implicit mailto link
        {
            regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
            format = 'mailto:$0',
        },
    }

    config.warn_about_missing_glyphs = false
end

return M
