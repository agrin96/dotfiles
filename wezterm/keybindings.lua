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
Helper to map cursor pane movements
]]
local function move_pane(key, direction)
    return {
        key = key,
        mods = "LEADER",
        action = wezterm.action.ActivatePaneDirection(direction),
    }
end

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
        -- Allows us to send the Leader combo as a regular key combo by just repeating it
        -- {
        --     key = "a",
        --     modes = "LEADER",
        --     action = wezterm.action.SendKey {
        --         key = "a",
        --         mods = "CTRL",
        --     }
        -- },
        -- Pane splitting using the leader (this is like tmux)
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
        move_pane("j", PaneDirection.DOWN),
        move_pane("k", PaneDirection.UP),
        move_pane("h", PaneDirection.LEFT),
        move_pane("l", PaneDirection.RIGHT),
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
        -- Mux session connection/disconnection
        {
           key = "a",
           mods = "LEADER",
           action = wezterm.action.AttachDomain("local-domain"),
        },
        {
           key = "d",
           mods = "LEADER",
           action = wezterm.action.DetachDomain { DomainName = "local-domain" },
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
        }
    }
end

return exports
