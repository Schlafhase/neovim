return {
	{
		"flash.nvim",
		auto_enable = true,
		event = "BufReadPost",
		after = function(_)
			local flash = require("flash")
			vim.keymap.set({ "n", "x", "o" }, "s", flash.jump)
			vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter)
		end,
	},
}
