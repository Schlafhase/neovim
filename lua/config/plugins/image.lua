return {
	{
		"vimplugin-image.nvim",
		event = "DeferredUIEnter",
		setup_module = "image",
		setup = {},
		before = function()
			require("nvim-treesitter").install("markdown") -- required for some reason
		end,
	},
}
