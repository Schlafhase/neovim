return {
	{
		"persistence.nvim",
		auto_enable = true,
		event = "DeferredUIEnter",
		priority = 500,

		after = function(_)
			require("persistence").setup()

			Autocmd("User", {
				group = Augroup("PersistenceCloseNonFiles"),
				pattern = "PersistenceSavePre",
				callback = function()
					local transient = {
						snacks_picker_list = true,
						snacks_picker_input = true,
						snacks_terminal = true,
						trouble = true,
					}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local buf = vim.api.nvim_win_get_buf(win)
						local ft = vim.bo[buf].filetype
						if transient[ft] or vim.bo[buf].buftype ~= "" then
							pcall(vim.api.nvim_win_close, win, false)
						end
					end
				end,
			})
		end,
	},
}
