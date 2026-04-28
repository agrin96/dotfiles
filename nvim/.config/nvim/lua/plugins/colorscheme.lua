-- Set additional colorschemes as lazy so we can use them on demand
-- but they are not loaded on startup. Load our default colorscheme on
-- startup.
return {
    {
        "tiagovla/tokyodark.nvim",
        lazy = true,
        opts = {},
        config = function()
            local colors = require("tokyodark.palette")
            colors.bg0 = "#22252A"
        end
    },
    {
        "sainnhe/sonokai",
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.sonokai_style = "default"
            vim.g.sonokai_enable_italic = 0
            vim.g.sonokai_diagnostic_text_highlight = 1
            vim.g.sonokai_diagnostic_line_highlight = 1
            vim.g.sonokai_colors_override = {
                bg0 = { "#1c2025", 235 },
                blue = { "#74ADE9", 110 },
                green = { "#61a670", 107 },
                yellow = { '#e5c07b', 179 },
                purple = { '#b57edc', 176 },
                red = { '#e06c75', 203 }
            }

            vim.api.nvim_create_autocmd('ColorScheme', {
                group = vim.api.nvim_create_augroup('custom_highlights_sonokai', {}),
                pattern = 'sonokai',
                callback = function()
                    local config = vim.fn['sonokai#get_configuration']()
                    local palette = vim.fn['sonokai#get_palette'](config.style, config.colors_override)
                    local set_hl = vim.fn['sonokai#highlight']

                    set_hl('Function', palette.purple, palette.none)
                    set_hl('Number', palette.blue, palette.none)
                    vim.api.nvim_set_hl(0, 'Constant', {
                        fg = '#979ED2',
                        italic = false,
                        bold = false,
                    })
                    vim.api.nvim_set_hl(0, '@lsp.type.variable.python', {
                        fg = '#e3e2d9',
                        italic = false,
                    })
                    vim.api.nvim_set_hl(0, '@lsp.type.enumMember.python', {
                        fg = '#979ED2',
                        bg = 'none',
                    })
                    vim.api.nvim_set_hl(0, '@lsp.type.property.python', {
                        fg = '#e3e2d9',
                        bg = 'none',
                    })
                    vim.api.nvim_set_hl(0, 'Directory', {
                        fg = '#ffcc66',
                        bg = 'none',
                    })

                    vim.cmd('highlight! link @lsp.type.enum.python Yellow')
                    vim.cmd('highlight! link @lsp.type.function.python Purple')
                    vim.cmd('highlight! link @lsp.type.method.python Purple')
                    vim.cmd('highlight! link @lsp.type.method.python Purple')
                    vim.cmd('highlight! link @string.python Green')
                    vim.cmd('highlight! link @string.documentation.python Green')
                    vim.cmd('highlight! link @lsp.type.decorator.python Purple')
                    vim.cmd('highlight! link @lsp.type.selfParameter.python @lsp.type.variable.python')
                    vim.cmd('highlight! link @lsp.type.class.python Yellow')
                    vim.cmd('highlight! link @lsp.type.type.python Constant')
                    vim.cmd('highlight! link @lsp.typemod.class.builtin.python Yellow')
                    vim.cmd('highlight! link @lsp.typemod.class.definition.python Yellow')

                    vim.cmd('highlight! link @constant.builtin.python Constant')
                    vim.cmd('highlight! link @boolean.python Constant')
                    vim.cmd('highlight! link @number.python Constant')
                    vim.cmd('highlight! link @number.float.python Constant')

                    -- Nim specific
                    vim.cmd('highlight! link @variable.builtin.nim Fg')
                    vim.cmd('highlight! link @type.nim Yellow')
                    vim.cmd('highlight! link @boolean.nim Blue')
                    vim.cmd('highlight! link @number.nim Blue')
                    vim.cmd('highlight! link @function.nim Purple')
                    vim.cmd('highlight! link @function.call.nim Purple')
                    vim.cmd('highlight! link @string.nim Green')
                    vim.cmd('highlight! link @constant.nim Constant')

                    -- Typescript
                    vim.api.nvim_set_hl(0, '@lsp.type.variable.typescript', {
                        fg = '#e3e2d9',
                        italic = false,
                    })
                    vim.api.nvim_set_hl(0, '@lsp.type.variable.typescriptreact', {
                        fg = '#e3e2d9',
                        italic = false,
                    })
                    vim.api.nvim_set_hl(0, '@variable.member.tsx', {
                        fg = '#e3e2d9',
                        italic = false,
                    })
                    vim.api.nvim_set_hl(0, '@tag.attribute.tsx', {
                        fg = '#e3e2d9',
                        italic = false,
                    })
                    vim.api.nvim_set_hl(0, '@variable.tsx', {
                        fg = '#e3e2d9',
                        italic = false,
                    })

                    vim.cmd('highlight! link @function.method.javascript Purple')
                    vim.cmd('highlight! link @function.method.call.javascript Purple')
                    vim.cmd('highlight! link @lsp.type.function.javascript Purple')
                    vim.cmd('highlight! link @lsp.type.function.typescript Purple')
                    vim.cmd('highlight! link @lsp.type.function.typescriptreact Purple')
                    vim.cmd('highlight! link @function.call.typescript Purple')
                    vim.cmd('highlight! link @function.call.typescriptreact Purple')
                    vim.cmd('highlight! link @lsp.type.class.typescript Yellow')
                    vim.cmd('highlight! link @lsp.type.class.typescriptreact Yellow')
                    vim.cmd('highlight! link @type.typescript Yellow')
                    vim.cmd('highlight! link @type.typescriptreact Yellow')
                    vim.cmd('highlight! link @lsp.type.namespace.typescriptreact Yellow')

                    vim.cmd('highlight! link @lsp.typemod.variable.defaultLibrary.javascript Yellow')
                    vim.cmd('highlight! link @lsp.type.property.typescriptreact Orange')
                    vim.cmd('highlight! link @lsp.type.member.typescriptreact Orange')
                    vim.cmd('highlight! link @lsp.type.member.typescript Orange')
                    vim.cmd('highlight! link @variable.builtin.javascript Orange')
                    vim.cmd('highlight! link @variable.builtin.typescript Orange')
                    vim.cmd('highlight! link @label.typescript Orange')

                    vim.cmd('highlight! link @string.tsx Green')
                    vim.cmd('highlight! link @string.typescript Green')
                    vim.cmd('highlight! link @string.javascript Green')
                    vim.cmd('highlight! link @tag.tsx Yellow')
                    vim.cmd('highlight! link @module.tsx Yellow')
                    vim.cmd('highlight! link @type.tsx Yellow')
                    vim.cmd('highlight! link @tag.delimiter.tsx Grey')
                    vim.cmd('highlight! link @constant.builtin.tsx Constant')
                    vim.cmd('highlight! link @constant.builtin.javascript Constant')
                    vim.cmd('highlight! link @boolean.tsx Constant')
                    vim.cmd('highlight! link @boolean.javascript Constant')
                    vim.cmd('highlight! link @number.tsx Constant')
                    vim.cmd('highlight! link @number.typescript Constant')
                    vim.cmd('highlight! link @number.javascript Constant')
                end
            })

            vim.cmd("colorscheme sonokai")
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = true,
        config = function()
            require('nordic').setup({
                on_palette = function(palette)
                    palette.gray0 = '#1b1c20'
                    palette.blue2 = '#7aaab8'
                    -- palette.white0_reduce_blue = '#e4e7ed'
                end
            })
            require('nordic').load()
        end
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = true,
    },
    {
        -- Includes dracula and dracula-soft (which looks like ponokai)
        "Mofiqul/dracula.nvim",
        lazy = true,
    },
    {
        -- Includes vaporwave, onedark, onelight, onedark_vivid, onedark_dark
        "olimorris/onedarkpro.nvim",
        lazy = true,
    },
    {
        -- Includes onenord and light
        "rmehri01/onenord.nvim",
        lazy = true,
        config = function()
            require("onenord").setup({
                custom_colors = {
                    dark = {
                        bg = "#212429",
                    },
                },
            })
        end
    },
    {
        -- Incldues minimal and minimal-base16, not a bad choice but a bit too bright?
        "Yazeed1s/minimal.nvim",
        lazy = true,
        config = function()
            vim.api.nvim_create_autocmd('ColorScheme', {
                group = vim.api.nvim_create_augroup('custom_highlights_minimal', {}),
                pattern = 'minimal',
                callback = function()
                    vim.api.nvim_set_hl(0, 'normal', {
                        fg = '#dfe0ea',
                        bg = '#212429'
                    })
                end
            })
        end
    }
}
