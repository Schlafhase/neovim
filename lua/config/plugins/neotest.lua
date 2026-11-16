return {
	{
		"neotest-dotnet",
		dep_of = { "neotest" },
	},
	{
		"neotest",
		after = function()
			require("neotest").setup({
				adapters = {
					require("neotest-dotnet"),
				},
        log_level = 1,
			})
		end,
	},
}
