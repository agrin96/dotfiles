return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Set up custom highlighting rules for the tree diagram using highlight
        -- groups found under :h neo-tree-highlights
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#E7905E" })
        vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#E7905E" })

        local neotree = require("neo-tree")
        local icons = require("nvim-web-devicons")
        icons.setup({
            color_icons = true,
            default = true,
            variant = "Dark",
        })
        -- Define the symbols used in diagnostics information
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "!",
                    [vim.diagnostic.severity.INFO] = "i",
                    [vim.diagnostic.severity.HINT] = "",
                },
            },
            -- Set virtual text false for all diagnostics
            virtual_text = false
        })

        neotree.setup({
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function (arg)
                        vim.opt_local.relativenumber = true
                    end,
                }
            },
            close_if_last_window = false,
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                name = {
                    use_git_status_colors = false,
                },
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "-",
                        renamed = "",
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "",
                        staged = "",
                        conflict = "",
                    }
                },
                modified = {
                    symbol = "󰣕",
                    highlight = "NeoTreeModified",
                },
                container = {
                    enable_character_fade = true,
                },
                indent = {
                    indent_size = 3,
                    padding = 1,
                    with_markers = true,
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                },
            },
        })

        -- Setup plugin keymaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>ee", "<cmd>Neotree toggle position=left<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>ef", "<cmd>Neotree toggle reveal<CR>", { desc = "Toggle file explorer current file" })

    end
}
