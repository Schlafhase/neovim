return {
	{
		"nvim-surround",
		event = "DeferredUIEnter",
		lazy = true,
		-- keys = "",
		after = function(plugin)
			require("nvim-surround").setup()
			Keymap({ "n", "v" }, "gsa")
		end,
	},
}
