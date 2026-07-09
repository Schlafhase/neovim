return {
	{
		"codex.nvim",
		event = "DeferredUIEnter",
		setup = {},
		after = function()
			local codex = require("codex")
			Keymap({ "n" }, "<leader>cc", codex.toggle)
		end,
	},
}
