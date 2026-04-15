return {
	{
		"smart-splits.nvim",
		event = "DeferredUIEnter",
		setup = {},
		after = function()
			local smart_splits = require("smart-splits")
			Keymap("n", "<M-Left>", smart_splits.resize_left)
			Keymap("n", "<M-Down>", smart_splits.resize_down)
			Keymap("n", "<M-Up>", smart_splits.resize_up)
			Keymap("n", "<M-Right>", smart_splits.resize_right)
		end,
	},
}
