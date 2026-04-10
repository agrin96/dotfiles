-- Add git integration
-- @see https://github.com/echasnovski/mini.diff
return {
	"echasnovski/mini.diff",
	version = false,
	opts = {},
    lazy = false,
    keys = {
        {'<leader>gh', function () MiniDiff.toggle_overlay() end, desc = 'Toggle hunk view', mode = {'n'}}
    }
}
