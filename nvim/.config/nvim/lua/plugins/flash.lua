-- Allows jumping around like youre a vim god or something
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
        modes = {
            search = {
                -- Disable by default because its usually annoying
                enabled = false
            },
            char = {
                jump_labels = true
            }
        }
    },
    keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        -- Uninterested in this right now
        -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
}
