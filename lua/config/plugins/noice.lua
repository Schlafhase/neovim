return {
	{
		"noice.nvim",
		lazy = false,
		auto_enable = true,
		after = function()
			require("noice").setup({
				notify = {
					enabled = true,
					view = "notify",
				},
				status = {
					lsp_progress = { event = "lsp", kind = "progress" },
				},
				-- routes = {
				-- 	filter = {
				-- 		event = "lsp",
				-- 		kind = "progress",
				-- 	},
				-- 	opts = { skip = true },
				-- },
			})

			-- LSP Hover scrolling
			vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
				if not require("noice.lsp").scroll(4) then
					return "<c-f>"
				end
			end, { silent = true, expr = true })

			vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
				if not require("noice.lsp").scroll(-4) then
					return "<c-b>"
				end
			end, { silent = true, expr = true })
		end,
	},
}
