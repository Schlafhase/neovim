return {
	{
		"mini.icons",
		event = "DeferredUIEnter",
		after = function()
			require("mini.icons").setup()
		end,
	},
}
