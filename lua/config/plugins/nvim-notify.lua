return {
	{
		"nvim-notify",
		after = function()
			require("notify").setup({
				timeout = 5,
				max_width = 300,
				max_height = 100,
				top_down = false,
			})
		end,
	},
}
