return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function ()
        local Rule = require('nvim-autopairs.rule')
        local npairs = require('nvim-autopairs')
        local cond = require('nvim-autopairs.conds')

        npairs.setup({
            check_ts = true, -- Enable Treesitter if available
            fast_wrap = {},
        })

        npairs.remove_rule('"')
        npairs.remove_rule("'")
        npairs.add_rules {
            Rule('"', '"')
                :with_pair(function(opts)
                    local line, col = opts.line, opts.col
                    local current_slice = line:sub(col - 2, col)

                    if current_slice:sub(-2) == '""' then
                        return false
                    end
                    if current_slice == '"""' then
                        return false
                    end
                    return true
                end)
                :with_move(function(opts)
                    -- Move cursor over closing quote when appropriate
                    return opts.char == '"' and opts.next_char == '"'
                end),
            Rule("'", "'")
                :with_pair(function(opts)
                    local line, col = opts.line, opts.col
                    local current_slice = line:sub(col - 2, col)

                    if current_slice:sub(-2) == "''" then
                        return false
                    end
                    if current_slice == "'''" then
                        return false
                    end
                    return true
                end)
                :with_move(function(opts)
                    -- Move cursor over closing quote when appropriate
                    return opts.char == "'" and opts.next_char == "'"
                end),
            -- Add a space around the equals sign
            Rule('=', '')
                :with_pair(cond.not_inside_quote())
                :with_pair(function(opts)
                    local last_char = opts.line:sub(opts.col - 1, opts.col - 1)
                    if last_char:match('[%w%=%s]') then
                        return true
                    end
                    return false
                end)
                :replace_endpair(function(opts)
                    local prev_2char = opts.line:sub(opts.col - 2, opts.col - 1)
                    local next_char = opts.line:sub(opts.col, opts.col)
                    next_char = next_char == ' ' and '' or ' '
                    if prev_2char:match('%w$') then
                        return '<bs> =' .. next_char
                    end
                    if prev_2char:match('%=$') then
                        return next_char
                    end
                    if prev_2char:match('=') then
                        return '<bs><bs>=' .. next_char
                    end
                    return ''
                end)
                :set_end_pair_length(0)
                :with_move(cond.none())
                :with_del(cond.none())
        }
    end,
}

