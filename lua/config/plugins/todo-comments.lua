return {
	{
		"todo-comments.nvim",
		event = "DeferredUIEnter",
		setup = {},
		after = function()
			Keymap("n", "<leader>st", Snacks.picker.todo_comments, { desc = "Search TODOs" })
		end,
	},
}
