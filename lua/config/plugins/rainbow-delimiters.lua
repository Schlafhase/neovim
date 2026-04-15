return {
	{
		-- "rainbow-delimiters.nvim",
		"rainbow-delimiters.nvim",
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
