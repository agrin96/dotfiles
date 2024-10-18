-- Pull wezterm API
local wezterm = require("wezterm")
local keybindings = require("keybindings")


if not wezterm.config_builder then
    error("Wezterm.config_builder is not available!")
end
local config = wezterm.config_builder()
local glyphs = {
    LEFT_HALF_CIRCLE = utf8.char("0xe0b6"),
    RIGHT_HALF_CIRCLE = utf8.char("0xe0b4"),
    FOLDER = utf8.char("0xf07b"),
    CALENDAR = utf8.char("0xf00f0"),
    CABLE = utf8.char("0xf1616"),
    DOCUMENT = utf8.char("0xf0219"),
    PROJECT = utf8.char("0xf08ea"),
    MAGNIFYING_GLASS = utf8.char("0xf002"),
}

-- Set colorscheme and font
local selectedScheme = "Sonokai (Gogh)"
config.color_scheme = selectedScheme
config.font = wezterm.font { family = "Maple Mono", weight = "Regular"}
config.font_size = 14

-- Get rid of the tab bar and put the status bar in the bottom.
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.show_tabs_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false

-- Whole window settings
config.adjust_window_size_when_changing_font_size = false
config.scrollback_lines = 5000
config.window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
}

-- Activate multiplexing connection
config.unix_domains = {
    {
        name = "local-domain"
    }
}

-- Remove the top macos bar and set the tab bar font
config.window_decorations = "RESIZE"
config.window_frame = {
    font = wezterm.font { family = "Maple Mono", weight = "Light"},
    font_size = 15,
    active_titlebar_bg = "none",
    inactive_titlebar_bg = "none",
}



local function padded(original, left_amount, right_amount)
    return string.rep(" ", left_amount) .. original .. string.rep(" ", right_amount)
end



local function working_directory(window)
    local url = window:active_pane():get_current_working_dir()
    if url then
        return url.path:gsub(wezterm.home_dir, "~")
    end
    return ""
end


local function is_pane_zoomed(window)
    local tab = window:mux_window():active_tab()
    for _, item in ipairs(tab:panes_with_info()) do
        if item.is_active then
            if item.is_zoomed then
                return padded(glyphs.MAGNIFYING_GLASS, 1, 0)
            end
        end
    end
    return ""
end


local function tab_status(window)
    return #window:mux_window():tabs() .. is_pane_zoomed(window)
end


local function left_status_segments(window)
    -- The order goes from bottom (left) to top (right)
    return {
        {
            icon = glyphs.PROJECT,
            content = window:active_workspace(),
            accent = wezterm.color.parse("red"):darken(0.1),
        },
        {
            icon = glyphs.DOCUMENT,
            content = tab_status(window),
            accent = wezterm.color.parse("green"):lighten(0.1),
        },
        {
            icon = glyphs.FOLDER,
            content = working_directory(window),
            accent = wezterm.color.parse("orange"):darken(0.1),
        },
    }
end


local function right_status_segments(window)
    -- The order is from bottom (right) to top (left)
    return {
        {
            icon = glyphs.CABLE,
            content = window:active_pane():get_domain_name(),
            accent = wezterm.color.parse("yellow"):darken(0.2),
        },
        {
            icon = glyphs.CALENDAR,
            content = wezterm.strftime("%b-%-d %H:%M"),
            accent = wezterm.color.parse("blue"):lighten(0.5),
        },
    }
end


wezterm.on("update-status", function (window, _)
    local color_scheme = window:effective_config().resolved_palette
    
    local bg = wezterm.color.parse(color_scheme.background):lighten(0.1)
    local fg = wezterm.color.parse("white")
    
    local left_segments = left_status_segments(window)
    local left_elements = {}

    for idx, segment in ipairs(left_segments) do
        -- Draw the icon
        table.insert(left_elements, { Background = { Color = "none" }})
        table.insert(left_elements, { Foreground = { Color = segment.accent }})
        table.insert(left_elements, { Text = padded(segment.icon, 1, 1) })
        
        table.insert(left_elements, { Background = { Color = "none" }})
        table.insert(left_elements, { Foreground = { Color = fg }})
        table.insert(left_elements, { Text = padded(segment.content, 0, 1) })
        
        -- Add spacing
        table.insert(left_elements, { Background = { Color = "none"}})
        table.insert(left_elements, { Foreground = { Color = "none" }})
        table.insert(left_elements, { Text = padded(" ", 1, 1) })
    end

    local right_segments = right_status_segments(window)
    local right_elements = {}
    for idx, segment in ipairs(right_segments) do
        -- Add spacing
        table.insert(right_elements, { Background = { Color = "none"}})
        table.insert(right_elements, { Foreground = { Color = "none" }})
        table.insert(right_elements, { Text = padded(" ", 1, 1) })

        -- Draw the icon
        table.insert(right_elements, { Background = { Color = "none" }})
        table.insert(right_elements, { Foreground = { Color = segment.accent }})
        table.insert(right_elements, { Text = padded(segment.icon, 1, 1) })
        
        table.insert(right_elements, { Background = { Color = "none" }})
        table.insert(right_elements, { Foreground = { Color = fg }})
        table.insert(right_elements, { Text = padded(segment.content, 0, 1) })
        
    end

    window:set_left_status(wezterm.format(left_elements))
    window:set_right_status(wezterm.format(right_elements))
end)


-- Assign keybindings
keybindings.apply(config)

return config
