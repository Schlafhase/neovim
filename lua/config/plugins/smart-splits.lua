return {
	{
		"smart-splits.nvim",
		event = "DeferredUIEnter",
		setup = {
			default_amount = 1,
		},
		after = function()
			local smartsplits = require("smart-splits")
			Keymap({ "n", "v", "i" }, "<C-Left>", smartsplits.resize_left)
			Keymap({ "n", "v", "i" }, "<C-Down>", smartsplits.resize_down)
			Keymap({ "n", "v", "i" }, "<C-Up>", smartsplits.resize_up)
			Keymap({ "n", "v", "i" }, "<C-Right>", smartsplits.resize_right)
		end,
	},
}
