return {
	{
		"lspkind.nvim",
		event = "BufEnter",
		dep_of = { "blink.cmp" },
		setup = {
			mode = "text",
		},
	},
}
