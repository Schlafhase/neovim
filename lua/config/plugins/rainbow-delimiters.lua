return {
	{
		-- "rainbow-delimiters.nvim",
		"vimplugin-rainbow-delimiters.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		after = function()
			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = "rainbow-delimiters.strategy.global",
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
			}
		end,
	},
}
