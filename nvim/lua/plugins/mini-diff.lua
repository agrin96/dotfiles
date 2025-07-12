-- Add git integration
-- @see https://github.com/echasnovski/mini.diff
return {
	"echasnovski/mini.diff",
	version = false,
	opts = {},
    keys = {
        {'<leader>go', function () MiniDiff.toggle_overlay() end, desc = 'Toggle Hunk Overlay', mode = {'n'}}
    }
}
