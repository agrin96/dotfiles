-- Pull wezterm API
local wezterm = require("wezterm")
local keybindings = require("keybindings")
-- Plugin to allow motions between nvim and wezterm panes.
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
-- Plugin to allow session savings/persistance for workspaces
local sessions = wezterm.plugin.require("https://github.com/abidibo/wezterm-sessions")

if not wezterm.config_builder then
    error("Wezterm.config_builder is not available!")
end

local config = wezterm.config_builder()
config.max_fps = 120

-- Set colorscheme and font
local selectedScheme = "Sonokai (Gogh)"
config.color_scheme = selectedScheme
config.font = wezterm.font { family = "Maple Mono NF", weight = "Medium"}
config.font_size = 14
config.audible_bell = 'Disabled'
config.colors = {
    split = '#99bbff'
}

-- Get rid of the tab bar and put the status bar in the bottom.
config.enable_tab_bar = false
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Whole window settings
config.adjust_window_size_when_changing_font_size = false
config.scrollback_lines = 5000
config.window_background_opacity = 0.98

local default_padding = {
    left = "1.5cell",
    right = "1.5cell",
    top = "0.50cell",
    bottom = "0.50cell",
}
config.window_padding = default_padding

-- Remove the top macos bar and set the tab bar font
config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"

local border_color = '#70708f'
config.window_frame = {
    font = wezterm.font { family = "Maple Mono NF", weight = "Medium" },
    font_size = 15,
    active_titlebar_bg = "none",
    inactive_titlebar_bg = "none",
    border_left_width = '0.25cell',
    border_right_width = '0.25cell',
    border_bottom_height = '0.12cell',
    border_top_height = '0.12cell',
    border_left_color = border_color,
    border_right_color = border_color,
    border_bottom_color = border_color,
    border_top_color = border_color,
}

-- PLUGIN: sessions
-- https://github.com/abidibo/wezterm-sessions/
sessions.apply_to_config(config)

-- Assign keybindings
keybindings.apply(config)

-- PLUGIN: smart-splits use defaults
-- https://github.com/mrjones2014/smart-splits.nvim?tab=readme-ov-file#wezterm
smart_splits.apply_to_config(config)


return config
