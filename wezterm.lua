-----------------------------------
--#region Initiate helper variables
local wezterm = require('wezterm')
local act = wezterm.action
local mux = wezterm.mux
local gui = wezterm.gui
local info = wezterm.log_info
local config = {}
--#endregion
-----------------------------------

-----------------------------------
--#region Color scheme
config.color_scheme = 'Catppuccin Mocha'
--#endregion
-----------------------------------

-----------------------------------
--#region Font
config.font = wezterm.font('JetBrainsMonoNL Nerd Font')
config.font_size = 12
--#endregion
-----------------------------------

-----------------------------------
--#region Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
    local name = window:active_key_table()

    if name then
        name = 'TABLE: ' .. name
    end

    window:set_right_status(name or '')
end)
--#endregion
-----------------------------------

-----------------------------------
--#region Keybinds
config.disable_default_key_bindings = true
local zsa_meh = 'ALT|CTRL|SHIFT'

config.leader = { key = 'Space', mods = zsa_meh }
config.keys = {

    -- utils --

    -- command pallete
    {
        key = 'P',
        mods = zsa_meh,
        action = act.ActivateCommandPalette,
    },
    {
        key = 'F11',
        mods = zsa_meh,
        action = act.ActivateCommandPalette,
    },

    -- launcher
    {
        key = 'F12',
        mods = zsa_meh,
        action = act.ShowLauncher,
    },

    -- debug overlay
    {
        key = 'L',
        mods = zsa_meh,
        action = act.ShowDebugOverlay,
    },
    {
        key = 'F20',
        mods = zsa_meh,
        action = act.ShowLauncher
    },

    -- font-size mode
    {
        key = '=',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'font_size',
            one_shot = false,
        }),
    },

    -- unicode char menu
    {
        key = 'u',
        mods = 'LEADER',
        action = act.CharSelect,
    },

    -- quick select
    {
        key = 'Space',
        mods = 'LEADER',
        action = act.QuickSelect,
    },
    {
        key = 'h',
        mods = 'LEADER',
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
        key = 'K',
        mods = zsa_meh,
        action = act.ClearScrollback('ScrollbackAndViewport'),
    },

    -- copy paste --
    -- copy to system clipboard
    {
        key = 'c',
        mods = 'LEADER',
        action = act.CopyTo('Clipboard'),
    },
    -- paste from system clipboard
    {
        key = 'v',
        mods = 'LEADER',
        action = act.PasteFrom('Clipboard'),
    },

    -- copy to primary selection buffer
    {
        key = 'C',
        mods = zsa_meh,
        action = act.CopyTo('PrimarySelection'),
    },
    -- paste from primary selection buffer
    {
        key = 'V',
        mods = zsa_meh,
        action = act.PasteFrom('PrimarySelection'),
    },

    -- copy mode
    {
        key = 'x',
        mods = 'LEADER',
        action = act.ActivateCopyMode,
    },

    -- window --
    -- spawn a new wezterm window
    {
        key = 'N',
        mods = zsa_meh,
        action = act.SpawnWindow,
    },

    -- toggle fullscreen
    {
        key = 'Enter',
        mods = 'LEADER',
        action = act.ToggleFullScreen,
    },

    -- tab --
    -- spawn new tab
    {
        key = 'T',
        mods = zsa_meh,
        action = act.SpawnTab('CurrentPaneDomain'),
    },

    -- close current tab
    {
        key = 'W',
        mods = zsa_meh,
        action = act.CloseCurrentTab({ confirm = true }),
    },

    -- activate the right most tab
    -- I do the other activate tabs command on a loop later
    {
        key = '0',
        mods = 'LEADER',
        action = act.ActivateTab(-1),
    },
    {
        key = 'F10',
        action = act.ActivateTab(-1),
    },

    -- activate next tab
    {
        key = 'RightArrow',
        mods = zsa_meh,
        action = act.ActivateTabRelative(1),
    },

    -- activate previous tab
    {
        key = 'LeftArrow',
        mods = zsa_meh,
        action = act.ActivateTabRelative(-1),
    },

    -- move-tab mode
    {
        key = 'm',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'move_tab',
            one_shot = false,
        }),
    },

    -- pane --
    -- resize-pane mode
    {
        key = 'r',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
        }),
    },

    -- navigation --
    -- scroll up
    {
        key = 'PageUp',
        mods = zsa_meh,
        action = act.ScrollByPage(-1),
    },

    -- scroll down
    {
        key = 'PageDown',
        mods = zsa_meh,
        action = act.ScrollByPage(1),
    },

    -- search
    {
        key = 'F',
        mods = zsa_meh,
        action = act.Search('CurrentSelectionOrEmptyString'),
    },
}

for i = 1, 9 do
    -- Leader + Number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'LEADER',
        action = act.ActivateTab(i - 1),
    })
    -- F1 through F9 to activate that tab
    table.insert(config.keys, {
        key = 'F' .. tostring(i),
        action = act.ActivateTab(i - 1),
    })
end

local function move_tab_last(window, pane)
    local tabs = window:mux_window():tabs_with_info()
    window:perform_action(act.MoveTab(tabs[#tabs].index), pane)
end

config.key_tables = {
    resize_pane = {
        { key = 'LeftArrow', action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },

        { key = 'RightArrow', action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },

        { key = 'UpArrow', action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },

        { key = 'DownArrow', action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },

        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
    },

    activate_pane = {
        { key = 'LeftArrow', action = act.ActivatePaneDirection('Left') },
        { key = 'h', action = act.ActivatePaneDirection('Left') },

        { key = 'RightArrow', action = act.ActivatePaneDirection('Right') },
        { key = 'l', action = act.ActivatePaneDirection('Right') },

        { key = 'UpArrow', action = act.ActivatePaneDirection('Up') },
        { key = 'k', action = act.ActivatePaneDirection('Up') },

        { key = 'DownArrow', action = act.ActivatePaneDirection('Down') },
        { key = 'j', action = act.ActivatePaneDirection('Down') },
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
        -- decrease font size
        { key = '-', action = act.DecreaseFontSize },
        -- increase font size
        { key = '=', action = act.IncreaseFontSize },
        -- reset font size
        { key = '0', action = act.ResetFontSize },
        -- Cancel the mode by pressing escape
        { key = 'Escape', action = 'PopKeyTable' },
    },
}
--#endregion
-----------------------------------

return config
