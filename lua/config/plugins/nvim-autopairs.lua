return {
	{
		"nvim-autopairs",
		event = "InsertEnter",
		after = function(_)
			require("nvim-autopairs").setup()
		end,
	},
}
