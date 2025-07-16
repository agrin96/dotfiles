-- NOTE: This plugin will work automatically with blink.cmp since we set the mini_snippets
-- dependency there.
return {
    'echasnovski/mini.snippets',
    version = "*",
    lazy = false,
    config = function ()
        local gen_loader = require('mini.snippets').gen_loader
        require('mini.snippets').setup({
            snippets = {
                -- Load custom file with global snippets first (adjust for Windows)
                gen_loader.from_file('~/.config/nvim/snippets/global.json'),

                -- Load snippets based on current language by reading files from
                -- "snippets/" subdirectories from 'runtimepath' directories.
                gen_loader.from_lang(),
            },
        })
    end,
    keys = {
        {'grc', function() require('mini.snippets').session.stop() end, desc = "End mini snippets session"}
    }
}
