return {
	{
		"flash.nvim",
		auto_enable = true,
		event = "BufReadPost",
		after = function(_)
			local flash = require("flash")
			flash.toggle(true)
			Keymap({ "n", "x", "o" }, "s", flash.jump)
			Keymap({ "n", "x", "o" }, "S", flash.treesitter)
		end,
	},
}
