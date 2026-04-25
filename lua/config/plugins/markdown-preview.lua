return {
	{
		"markdown-preview.nvim",
		on_plugin = "live-server.nvim",
		setup_module = "markdown_preview",
		setup = {
			debounce_ms = 10,
		},
	},
}
