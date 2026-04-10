return {
    'akinsho/git-conflict.nvim',
    version = "*",
    lazy = false,
    keys = {
        {'<leader>go', '<Plug>(git-conflict-ours)', desc = "Choose ours (current)", mode = {'n'} },
        {'<leader>gt', '<Plug>(git-conflict-theirs)', desc = "Choose theirs (incoming)", mode = {'n'} },
        {'<leader>gb', '<Plug>(git-conflict-both)', desc = "Choose both of the changes", mode = {'n'} },
        {'<leader>g0', '<Plug>(git-conflict-none)', desc = "Choose none of the changes", mode = {'n'} },
        {'g]', '<Plug>(git-conflict-next-conflict)', desc = "Go to next git conflict", mode = {'n'} },
        {'g[', '<Plug>(git-conflict-previous-conflict)', desc = "Go to previous git conflict", mode = {'n'} },
    },
    config = function ()
        vim.api.nvim_set_hl(0, 'DiffText', {
            fg = '#1c2025',
            bg = '#324c69',
        })
        require('git-conflict').setup({
            highlights = {
                incoming = 'DiffAdd',
                current = 'DiffText'
            }
        })
    end
}

