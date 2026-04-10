local wezterm = require "wezterm"
local workspaces = require "workspaces"
local exports = {}

local PaneDirection = {
    UP = "Up",
    DOWN = "Down",
    LEFT = "Left",
    RIGHT = "Right"
}

--[[ ### Summary
Helper to resize the currently active pane.
]]
local function resize_pane(key, direction)
    return {
        key = key,
        action = wezterm.action.AdjustPaneSize {
            direction, 2
        }
    }
end

--[[ If we dont't wrap these assignments in a function then we get a coroutine
error. 
From what I understand this is because the engine tries to execute this code as
a seperate thread and thus the workspaces function is immediately executed causing
an error. ]]
function exports.apply(config)
    config.leader = {
        key = "a",
        mods = "CTRL",
        timeout_milliseconds = 2000
    }
    config.key_tables = {
        resize_panes = {
            resize_pane("j", PaneDirection.DOWN),
            resize_pane("k", PaneDirection.UP),
            resize_pane("h", PaneDirection.LEFT),
            resize_pane("l", PaneDirection.RIGHT),
        }
    }
    config.keys = {
        -- Open new tabs to the user home directory instead of the source tabs directory.
        {
            key = 't',
            mods = 'CMD',
            action = wezterm.action.SpawnCommandInNewTab {
            cwd = wezterm.home_dir
            },
        },
        -- Allows navigating over words via macos
        {
            key = "LeftArrow",
            mods = "OPT",
            action = wezterm.action.SendString('\x1bb')
        },
        {
            key = "RightArrow",
            mods = "OPT",
            action = wezterm.action.SendString('\x1bf')
        },
        -- Open the wezterm configuration in an editor
        {
            key = ",",
            mods = "SUPER",
            action = wezterm.action.SpawnCommandInNewTab {
                cwd = wezterm.home_dir,
                args = { "vim", wezterm.config_file }
            }
        },
        {
            key = '"',
            mods = "LEADER",
            action = wezterm.action.SplitHorizontal {
                domain = "CurrentPaneDomain"
            }
        },
        {
            key = '%',
            mods = "LEADER",
            action = wezterm.action.SplitVertical {
                domain = "CurrentPaneDomain"
            }
        },
        {
            key = "r",
            mods = "LEADER",
            action = wezterm.action.ActivateKeyTable {
                name = "resize_panes",
                one_shot = false,
                timeout_milliseconds = 2000,
            }
        },
        {
            key = "w",
            mods = "LEADER",
            action = workspaces.choose_workspace(),
        },
        {
            key = "s",
            mods = "LEADER",
            action = wezterm.action.ShowLauncherArgs {
                flags = "FUZZY|WORKSPACES"
            }
        },
        -- Toggle single pane zoomin
        {
            key = "z",
            mods = "ALT",
            action = wezterm.action.TogglePaneZoomState,
        },
        -- Spawn new tab
        {
            key = "c",
            mods = "LEADER",
            action = wezterm.action.SpawnTab "CurrentPaneDomain",
        },
        -- Navigate between tabs
        {
            key = "n",
            mods = "LEADER",
            action = wezterm.action.ActivateTabRelative(1)
        },
        {
            key = "p",
            mods = "LEADER",
            action = wezterm.action.ActivateTabRelative(-1)
        },
        -- Rename tabs which is awesome.
        {
            key = ",",
            mods = "LEADER",
            action = wezterm.action.PromptInputLine {
                description = "Enter name for tab",
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            window:active_tab():set_title(line)
                        end
                    end
                )
            }
        },
        -- open tab navigator
        {
            key = "t",
            mods = "LEADER",
            action = wezterm.action.ShowTabNavigator,
        },
        -- Kill current tabe process
        {
            key = "&",
            mods = "LEADER",
            action = wezterm.action.CloseCurrentTab { confirm = true }
        },
        {
            key = "$",
            mods = "LEADER",
            action = wezterm.action.PromptInputLine {
                description = "Enter new workspace name",
                action = wezterm.action_callback(
                    function(window, pane, line)
                        if line then
                            wezterm.mux.rename_workspace(
                                window:mux_window():get_workspace(),
                                line
                            )
                        end
                    end
                )
            }
        },
        -- Wezterm eats CMD keys so we need to translate them for them to be read by
        -- neovim. In this case we transalte them into function keys
        {
            key = "j",
            mods = "CMD",
            action = wezterm.action.SendKey({ key = "n", mods = "CTRL" }),
        },
        {
            key = "k",
            mods = "CMD",
            action = wezterm.action.DisableDefaultAssignment,
        },
        {
            key = "k",
            mods = "CMD",
            action = wezterm.action.SendKey({ key = "p", mods = "CTRL" }),
        },
        -- Sessions
        {
            key = 's',
            mods = 'ALT',
            action = wezterm.action({ EmitEvent = "save_session" }),
        },
        {
            key = 'l',
            mods = 'CMD',
            action = wezterm.action({ EmitEvent = "load_session" }),
        },
        {
            key = 'r',
            mods = 'ALT',
            action = wezterm.action({ EmitEvent = "restore_session" }),
        },
        {
            key = 'd',
            mods = 'CTRL|SHIFT',
            action = wezterm.action({ EmitEvent = "delete_session" }),
        },
        {
            key = 'e',
            mods = 'CTRL|SHIFT',
            action = wezterm.action({ EmitEvent = "edit_session" }),
        },
        {
            key = 'f',
            mods = 'ALT',
            action = wezterm.action({ EmitEvent = "fork_session" }),
        },
    }
end

return exports
