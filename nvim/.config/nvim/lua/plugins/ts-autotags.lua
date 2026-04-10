-- Handle automatic tag closing on Javascript/typescript
return {
    'windwp/nvim-ts-autotag',
    config = function ()
        require('nvim-ts-autotag').setup({})
    end
}
