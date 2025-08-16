local wezterm = require "wezterm"
local exports = {}

local ProjectsRoot = "Projects"

local function find_projects(directory, projects, projects_base)
    for _, dir in ipairs(wezterm.glob(directory .. "/*")) do
        if dir:sub(-#ProjectsRoot) == ProjectsRoot then
            find_projects(dir, projects, projects_base)
        else
            table.insert(
                projects,
                {
                    id = dir,
                    label = dir:gsub(projects_base, ""):gsub(ProjectsRoot .. "/", "/")
                }
            )
        end
    end
end


function exports.choose_workspace()
    -- Our first project should just be the home directory
    local projects = {
        { id = wezterm.home_dir, label = "Home" },
        { id = wezterm.config_dir, label = "Wezterm Config"},
        { id = wezterm.home_dir .. "/.config/vim/", label = "Vim Config"},
    }
    -- Add our different one off projects as workspaces by searching recursively
    local projects_base = wezterm.home_dir .. "/" .. ProjectsRoot
    find_projects(projects_base, projects, projects_base)

    return wezterm.action.InputSelector {
        title = "Workspaces",
        choices = projects,
        fuzzy = true,
        action = wezterm.action_callback(function(child_window, child_pane, id, label)
            -- Label will be empoty if there was no user selection
            if not label then return end
            child_window:perform_action(wezterm.action.SwitchToWorkspace {
                -- Use the last part of workspace path as the name.
                name = label:match("([^/]+)$"),
                spawn = {
                     cwd = id
                },
            }, child_pane)
        end)
    }
end

return exports
