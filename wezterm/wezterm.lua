-- Pull wezterm API
local wezterm = require("wezterm")
local keybindings = require("keybindings")


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
    top = "0.25cell",
    bottom = "0.25cell",
}
config.window_padding = default_padding

-- In this case we will override the default window padding to 0 when
-- we enter nvim because we want to get rid of weird borders
wezterm.on("update-status", function(window, pane)
    if pane:is_alt_screen_active() then
        window:set_config_overrides({
            window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
        })
    else
        window:set_config_overrides({
            window_padding = default_padding,
        })
    end
end)


-- Remove the top macos bar and set the tab bar font
config.window_decorations = "RESIZE|MACOS_FORCE_SQUARE_CORNERS"

local border_color = '#37364a'
config.window_frame = {
    font = wezterm.font { family = "Maple Mono NF", weight = "Medium" },
    font_size = 15,
    active_titlebar_bg = "none",
    inactive_titlebar_bg = "none",
    border_left_width = '0.5cell',
    border_right_width = '0.5cell',
    border_bottom_height = '0.25cell',
    border_top_height = '0.25cell',
    border_left_color = border_color,
    border_right_color = border_color,
    border_bottom_color = border_color,
    border_top_color = border_color,
}

-- Assign keybindings
keybindings.apply(config)

return config
