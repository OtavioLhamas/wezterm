local wezterm = require('wezterm')
local act = wezterm.action

local zsa_meh = 'ALT|CTRL|SHIFT'

local mod = {
    MEH = zsa_meh,
    LEADER = 'LEADER'
}
local leader = { key = 'Space', mods = mod.MEH }

local disable_default_key_bindings = true

-----------------------------------------------------------------------------------------------------------------------
--#region Keybinds
local keys = {
    --#region Utils
    -- command pallete
    {
        key = [[\]],
        mods = mod.LEADER,
        action = act.ActivateCommandPalette,
    },

    -- launcher
    {
        key = 'F11',
        mods = mod.MEH,
        action = act.ShowLauncher,
    },
    {
        key = 'F12',
        mods = mod.MEH,
        action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }),
    },
    {
        key = 'raw:191', -- F13
        mods = mod.MEH,
        action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
    },

    -- debug overlay
    {
        key = 'raw:192', -- F14
        mods = mod.MEH,
        action = act.ShowDebugOverlay,
    },

    -- font-size mode
    {
        key = '=',
        mods = mod.LEADER,
        action = act.ActivateKeyTable({
            name = 'font_size',
            one_shot = false,
        }),
    },

    -- unicode char menu
    {
        key = 'u',
        mods = mod.LEADER,
        action = act.CharSelect,
    },

    -- quick select
    {
        key = 'Space',
        mods = mod.LEADER,
        action = act.QuickSelect,
    },
    {
        key = 'h',
        mods = mod.LEADER,
        action = act.QuickSelectArgs({
            label = 'open url',
            patterns = {
                '\\((https?://\\S+)\\)',
                '\\[(https?://\\S+)\\]',
                '\\{(https?://\\S+)\\}',
                '<(https?://\\S+)>',
                '\\bhttps?://\\S+[)/a-zA-Z0-9-]+',
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
            end),
        }),
    },

    -- clear
    {
        key = 'k',
        mods = mod.LEADER,
        action = act.ClearScrollback('ScrollbackAndViewport'),
    },
    --#endregion

    --#region Copy Paste
    -- copy to system clipboard
    {
        key = 'c',
        mods = mod.LEADER,
        action = act.CopyTo('Clipboard'),
    },
    -- paste from system clipboard
    {
        key = 'v',
        mods = mod.LEADER,
        action = act.PasteFrom('Clipboard'),
    },

    -- copy to primary selection buffer
    {
        key = 'C',
        mods = mod.MEH,
        action = act.CopyTo('PrimarySelection'),
    },
    -- paste from primary selection buffer
    {
        key = 'V',
        mods = mod.MEH,
        action = act.PasteFrom('PrimarySelection'),
    },

    -- copy mode
    {
        key = 'x',
        mods = mod.LEADER,
        action = act.ActivateCopyMode,
    },
    --#endregion

    --#region Window
    -- spawn a new wezterm window
    {
        key = 'N',
        mods = mod.MEH,
        action = act.SpawnWindow,
    },

    -- toggle fullscreen
    {
        key = 'Enter',
        mods = mod.LEADER,
        action = act.ToggleFullScreen,
    },
    --#endregion

    --#region Tab
    -- spawn new tab
    {
        key = 'T',
        mods = mod.MEH,
        action = act.SpawnTab('CurrentPaneDomain'),
    },

    -- close current tab
    {
        key = 'w',
        mods = mod.LEADER,
        action = act.CloseCurrentTab({ confirm = true }),
    },

    -- activate the right most tab
    -- I do the other activate tabs command on a loop later
    {
        key = '0',
        mods = mod.LEADER,
        action = act.ActivateTab(-1),
    },
    {
        key = 'F10',
        action = act.ActivateTab(-1),
    },

    -- activate next tab
    {
        key = 'RightArrow',
        mods = mod.MEH,
        action = act.ActivateTabRelative(1),
    },

    -- activate previous tab
    {
        key = 'LeftArrow',
        mods = mod.MEH,
        action = act.ActivateTabRelative(-1),
    },

    -- move-tab mode
    {
        key = 'm',
        mods = mod.LEADER,
        action = act.ActivateKeyTable({
            name = 'move_tab',
            one_shot = false,
        }),
    },
    --#endregion

    --#region Pane
    -- resize-pane mode
    {
        key = 'r',
        mods = mod.LEADER,
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
        }),
    },

    -- split horizontal
    {
        key = [[|]],
        mods = mod.MEH,
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    -- split vertical
    {
        key = '"',
        mods = mod.MEH,
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },

    -- zoom
    {
        key = 'Z',
        mods = mod.MEH,
        action = act.TogglePaneZoomState,
    },

    -- close
    {
        key = 'W',
        mods = mod.MEH,
        action = act.CloseCurrentPane({ confirm = true }),
    },

    -- navigation
    {
        key = 'H',
        mods = mod.MEH,
        action = act.ActivatePaneDirection('Left'),
    },
    {
        key = 'J',
        mods = mod.MEH,
        action = act.ActivatePaneDirection('Down'),
    },
    {
        key = 'K',
        mods = mod.MEH,
        action = act.ActivatePaneDirection('Up'),
    },
    {
        key = 'L',
        mods = mod.MEH,
        action = act.ActivatePaneDirection('Right'),
    },
    -- by index
    {
        key = 'P',
        mods = mod.MEH,
        action = act.PaneSelect({ alphabet = '1234567890', mode = 'Activate' }),
    },
    {
        key = 'p',
        mods = mod.LEADER,
        action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
    },
    --#endregion

    --#region Navigation
    -- scroll up
    {
        key = 'PageUp',
        mods = mod.MEH,
        action = act.ScrollByPage(-1),
    },

    -- scroll down
    {
        key = 'PageDown',
        mods = mod.MEH,
        action = act.ScrollByPage(1),
    },

    -- search
    {
        key = 'F',
        mods = mod.MEH,
        action = act.Search('CurrentSelectionOrEmptyString'),
    },
    --#endregion
}

for i = 1, 9 do
    -- Leader + Number to activate that tab
    table.insert(keys, {
        key = tostring(i),
        mods = mod.LEADER,
        action = act.ActivateTab(i - 1),
    })
    -- F1 through F9 to activate that tab
    table.insert(keys, {
        key = 'F' .. tostring(i),
        action = act.ActivateTab(i - 1),
    })
end
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Key Tables
local function move_tab_last(window, pane)
    local tabs = window:mux_window():tabs_with_info()
    window:perform_action(act.MoveTab(tabs[#tabs].index), pane)
end

local key_tables = {
    resize_pane = {
        { key = 'LeftArrow', action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'LeftArrow', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 10 }) },
        { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'h', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Left', 10 }) },

        { key = 'RightArrow', action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'RightArrow', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 10 }) },
        { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'l', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Right', 10 }) },

        { key = 'UpArrow', action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'UpArrow', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 10 }) },
        { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'k', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Up', 10 }) },

        { key = 'DownArrow', action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'DownArrow', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 10 }) },
        { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'j', mods = 'SHIFT', action = act.AdjustPaneSize({ 'Down', 10 }) },

        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
    },

    move_tab = {
        { key = 'LeftArrow', action = act.MoveTabRelative(-1) },
        { key = 'h', action = act.MoveTabRelative(-1) },

        { key = 'RightArrow', action = act.MoveTabRelative(1) },
        { key = 'l', action = act.MoveTabRelative(1) },

        { key = 'UpArrow', action = wezterm.action_callback(move_tab_last) },
        { key = 'k', action = wezterm.action_callback(move_tab_last) },

        { key = 'DownArrow', action = act.MoveTab(0) },
        { key = 'j', action = act.MoveTab(0) },

        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
    },

    font_size = {
        { key = '-', action = act.DecreaseFontSize },
        { key = 'j', action = act.DecreaseFontSize },
        { key = '=', action = act.IncreaseFontSize },
        { key = 'k', action = act.IncreaseFontSize },
        { key = '0', action = act.ResetFontSize },
        { key = 'r', action = act.ResetFontSize },

        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
    },
}
--#endregion
-----------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------
--#region Mouse Bindings
local mouse_bindings = {
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = 'CTRL',
        action = act.OpenLinkAtMouseCursor,
    },
}
--#endregion
-----------------------------------------------------------------------------------------------------------------------

return {
    disable_default_key_bindings = disable_default_key_bindings,
    leader = leader,
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
