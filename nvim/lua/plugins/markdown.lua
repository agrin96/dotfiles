return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function ()
        local render_markdown = require("render-markdown")
        -- Parse query outside of the function to avoid doing it for each call
        local query = vim.treesitter.query.parse(
            "python",
            "(block (expression_statement (string (string_start) (string_content) @docstring)))"
        )

        -- local function parse_python(root, buf)
        --     local marks = {}
        --     for id, node in query:iter_captures(root, buf) do
        --         local capture = query.captures[id]
        --         local start_row, start_col, end_row, _ = node:range()
        --         if capture == 'docstring' then
        --             local text = vim.api.nvim_buf_get_lines(buf, start_row, end_row, false)
        --             local indent = string.find(text[2],"^%s*") + 1
        --             for i, _ in ipairs(text) do
        --                 if i == 1 then
        --                     goto continue
        --                 else
        --                     text[i] = text[i]:sub(indent, -1)
        --                 end
        --                 ::continue::
        --             end
        --             
        --             local tempbuf = vim.api.nvim_create_buf(false, true)
        --             vim.api.nvim_buf_set_lines(tempbuf, 1, -1, false, text)
        --
        --             local parser = vim.treesitter.get_parser(tempbuf, "markdown")
        --             local trees = parser:parse(true)
        --             print("Length - " .. #trees)
        --             -- For each node in the parsed tree its position will simply be the 
        --             -- start_row + row, start_col + offset + col
        --             -- except the first row which would have a row = 1 and can simply be
        --             -- start_row + row, start_col + col
        --             table.insert(marks, {
        --                 conceal = true,
        --                 start_row = start_row,
        --                 start_col = 0,
        --                 opts = {
        --                     end_row = end_row,
        --                     end_col = 0,
        --                 },
        --             })
        --         end
        --     end
        --  return marks
        -- end
        render_markdown.setup({
            file_types = { "markdown", "python" },
            -- custom_handlers = {
            --     python = { parse = parse_python },
            -- }
        })
    end,
}
