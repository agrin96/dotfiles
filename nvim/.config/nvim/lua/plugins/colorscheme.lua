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
		end,
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
				blue = { "#7CAAD9", 110 },
				green = { "#61a670", 107 },
				yellow = { "#e5c07b", 179 },
				purple = { "#AF86D1", 176 },
				red = { "#C96D74", 203 },
			}

			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("custom_highlights_sonokai", {}),
				pattern = "sonokai",
				callback = function()
					local config = vim.fn["sonokai#get_configuration"]()
					local palette = vim.fn["sonokai#get_palette"](config.style, config.colors_override)
					local sonokai_hl = vim.fn["sonokai#highlight"]
					local hl = vim.api.nvim_set_hl

					local fg_var = "#e3e2d9"
					local fg_const = "#979ED2"

					sonokai_hl("Function", palette.purple, palette.none)
					sonokai_hl("Number", palette.blue, palette.none)

					-- Base overrides
					hl(0, "Constant", { fg = fg_const })
					hl(0, "Directory", { fg = "#ffcc66" })

					-- Python: direct highlights
					hl(0, "@lsp.type.variable.python", { fg = fg_var })
					hl(0, "@lsp.type.property.python", { fg = fg_var })
					hl(0, "@lsp.type.enumMember.python", { fg = fg_const })
					hl(0, "@lsp.type.selfParameter.python", { link = "@lsp.type.variable.python" })

					-- TypeScript/React: direct highlights
					hl(0, "@lsp.type.variable.typescript", { fg = fg_var })
					hl(0, "@lsp.type.variable.typescriptreact", { fg = fg_var })
					hl(0, "@variable.member.tsx", { fg = fg_var })
					hl(0, "@tag.attribute.tsx", { fg = fg_var })
					hl(0, "@variable.tsx", { fg = fg_var })

					-- All link-based overrides
					local links = {
						-- Python
						["@lsp.type.function.python"] = "Purple",
						["@lsp.type.method.python"] = "Purple",
						["@lsp.type.decorator.python"] = "Purple",
						["@lsp.type.enum.python"] = "Yellow",
						["@lsp.type.class.python"] = "Yellow",
						["@lsp.typemod.class.builtin.python"] = "Yellow",
						["@lsp.typemod.class.definition.python"] = "Yellow",
						["@lsp.type.type.python"] = "Constant",
						["@string.python"] = "Green",
						["@string.documentation.python"] = "Green",
						["@constant.builtin.python"] = "Constant",
						["@boolean.python"] = "Constant",
						["@number.python"] = "Constant",
						["@number.float.python"] = "Constant",

						-- Nim
						["@variable.builtin.nim"] = "Fg",
						["@type.nim"] = "Yellow",
						["@boolean.nim"] = "Blue",
						["@number.nim"] = "Blue",
						["@function.nim"] = "Purple",
						["@function.call.nim"] = "Purple",
						["@string.nim"] = "Green",
						["@constant.nim"] = "Constant",

						-- JavaScript/TypeScript/React
						["@function.method.javascript"] = "Purple",
						["@function.method.call.javascript"] = "Purple",
						["@lsp.type.function.javascript"] = "Purple",
						["@lsp.type.function.typescript"] = "Purple",
						["@lsp.type.function.typescriptreact"] = "Purple",
						["@function.call.typescript"] = "Purple",
						["@function.call.typescriptreact"] = "Purple",
						["@lsp.type.class.typescript"] = "Yellow",
						["@lsp.type.class.typescriptreact"] = "Yellow",
						["@type.typescript"] = "Yellow",
						["@type.typescriptreact"] = "Yellow",
						["@lsp.type.namespace.typescriptreact"] = "Yellow",
						["@lsp.typemod.variable.defaultLibrary.javascript"] = "Yellow",
						["@lsp.type.property.typescriptreact"] = "Orange",
						["@lsp.type.member.typescriptreact"] = "Orange",
						["@lsp.type.member.typescript"] = "Orange",
						["@variable.builtin.javascript"] = "Orange",
						["@variable.builtin.typescript"] = "Orange",
						["@label.typescript"] = "Orange",
						["@string.tsx"] = "Green",
						["@string.typescript"] = "Green",
						["@string.javascript"] = "Green",
						["@tag.tsx"] = "Yellow",
						["@module.tsx"] = "Yellow",
						["@type.tsx"] = "Yellow",
						["@tag.delimiter.tsx"] = "Grey",
						["@constant.builtin.tsx"] = "Constant",
						["@constant.builtin.javascript"] = "Constant",
						["@boolean.tsx"] = "Constant",
						["@boolean.javascript"] = "Constant",
						["@number.tsx"] = "Constant",
						["@number.typescript"] = "Constant",
						["@number.javascript"] = "Constant",
					}

					for group, target in pairs(links) do
						hl(0, group, { link = target })
					end
				end,
			})

			vim.cmd("colorscheme sonokai")
		end,
	},
	{
		"AlexvZyl/nordic.nvim",
		lazy = true,
		config = function()
			require("nordic").setup({
				on_palette = function(palette)
					palette.gray0 = "#1b1c20"
					palette.blue2 = "#7aaab8"
				end,
			})
			require("nordic").load()
		end,
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
			local variables = "#E3E4E6"
			local keyword_color = "#DB9191"
			require("onenord").setup({
				custom_highlights = {
					["@variable"] = {
						fg = variables,
						style = "italic",
					},
					["@variable.parameter"] = {
						fg = variables,
						style = "italic",
					},
					["@keyword"] = {
						fg = keyword_color,
					},
					["@keyword.function"] = {
						fg = keyword_color,
					},
					["@function"] = {
						fg = "#81a1c1",
						style = "none",
					},
				},
				custom_colors = {
					bg = "#1B1B1C",
				},
			})
		end,
	},
	{
		-- Incldues minimal and minimal-base16, not a bad choice but a bit too bright?
		"Yazeed1s/minimal.nvim",
		lazy = true,
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("custom_highlights_minimal", {}),
				pattern = "minimal",
				callback = function()
					vim.api.nvim_set_hl(0, "normal", {
						fg = "#dfe0ea",
						bg = "#212429",
					})
				end,
			})
		end,
	},
}
