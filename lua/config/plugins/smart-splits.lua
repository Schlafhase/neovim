return {
	{
		"smart-splits.nvim",
		event = "DeferredUIEnter",
		setup = {
			default_amount = 1,
		},
		after = function()
			local smartsplits = require("smart-splits")
			Keymap({ "n", "v", "i" }, "<C-S-H>", smartsplits.resize_left)
			Keymap({ "n", "v", "i" }, "<C-S-J>", smartsplits.resize_down)
			Keymap({ "n", "v", "i" }, "<C-S-K>", smartsplits.resize_up)
			Keymap({ "n", "v", "i" }, "^[[108;6u", smartsplits.resize_right)
		end,
	},
}
