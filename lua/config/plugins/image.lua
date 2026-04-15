return {
	{
		"image.nvim",
		event = "DeferredUIEnter",
		setup = {},
		before = function()
			require("nvim-treesitter").install("markdown") -- required for some reason
		end,
	},
}
