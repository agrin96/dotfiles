return {
    "lukas-reineke/indent-blankline.nvim",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    main = "ibl",
    opts = {
        indent = { char = "┊" },
        scope = {
            enabled = true,
            char = "┃",
            show_end = false,
            show_start = false,
        },
    },
}
