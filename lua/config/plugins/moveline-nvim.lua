return {
	{
		"moveline-nvim",
		event = "BufReadPre",
		after = function(_)
			local moveline = require("moveline")
			vim.keymap.set({ "n", "i" }, "<M-k>", moveline.up)
			vim.keymap.set({ "n", "i" }, "<M-j>", moveline.down)
			vim.keymap.set("v", "<M-k>", moveline.block_up)
			vim.keymap.set("v", "<M-j>", moveline.block_down)
		end,
	},
}
