return {
	{
		"vim-illuminate",
		event = "BufReadPost",
		after = function()
			require("vim-illuminate").setup({
				delay = 200,
				large_file_cutoff = 2000,
				large_file_overrides = {
					providers = { "lsp" },
				},
			})
		end,
	},
}
