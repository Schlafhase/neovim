return {
	{
		"nvim-notify",
		after = function()
			require("notify").setup()
		end,
	},
}
