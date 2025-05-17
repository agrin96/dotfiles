return {
	'jake-stewart/multicursor.nvim',
	config = function()
		local mc = require("multicursor-nvim")
        mc.setup()

        local set = vim.keymap.set

        -- Add or skip cursor above/below the main cursor.
        set({"n", "x"}, "<M-Up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor up"})
        set({"n", "x"}, "<M-Down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor down"})
        set({"n", "x"}, "<M-C-Up>", function() mc.lineSkipCursor(-1) end, { desc = "Skip cursor up"})
        set({"n", "x"}, "<M-C-Down>", function() mc.lineSkipCursor(1) end, { desc = "Skip cursor down"})

        -- Add or skip adding a new cursor by matching word/selection
        set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end, { desc = "Add new cursor by selection"})
        set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end, { desc = "Skip new cursor by selection"})
        set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end, { desc = "Add new cursor before by selection"})
        set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end, { desc = "Skip new cursor before by selection"})
        -- Add and remove cursors with control + left click.
        set("n", "<c-leftmouse>", mc.handleMouse)
        set("n", "<c-leftdrag>", mc.handleMouseDrag)
        set("n", "<c-leftrelease>", mc.handleMouseRelease)

        -- Disable and enable cursors.
        set({"n", "x"}, "<c-q>", mc.toggleCursor, { desc = "Toggle cursor active/inactive"})
	       
		-- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Delete the main cursor.
            layerSet({"n", "x"}, "<leader>x", mc.deleteCursor, { desc = "Delete main cursor"})

            -- Enable and clear cursors using escape.
            layerSet("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
	end
}
