return {
	{
		"log-highlight.nvim",
		event = "DeferredUIEnter",
		setup = {
			keyword = {
				error = { "FAIL", "CRIT" },
				warning = "WARN",
				debug = { "DBUG", "TRCE" },
        info = "INFO",
			},
		},
	},
}
