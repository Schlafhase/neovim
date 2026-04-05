return {
	{
		"nvim-autopairs",
		auto_enable = true,
		event = "InsertEnter",
		after = function(_)
			require("nvim-autopairs").setup()
		end,
	},
}
