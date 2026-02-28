return {
	{
		"snacks.nvim",
		auto_enable = true,
		-- snacks makes a global, and then lazily loads itself
		lazy = false,
		-- priority only affects startup plugins
		-- unless otherwise specified by a particular handler
		priority = 1000,
		after = function(plugin)
			-- I also like this color
			vim.api.nvim_set_hl(0, "MySnacksIndent", { fg = "#32a88f" })
			local startup_time = vim.fn.reltime(vim.g.start_time or vim.fn.reltime())
			local startup_ms = math.floor(vim.fn.reltimefloat(startup_time) * 1000)

			require("snacks").setup({
				explorer =
					---@class snacks.explorer.Config
					{
						replace_netrw = true,
						trash = false,
					},
				picker = {
					sources = {
						explorer = {
							auto_close = false,
						},
					},
				},
				words = {
					enable = false,
				},
				git = {},
				terminal = {},
				scope = {},
				indent = {
					scope = {
						hl = "MySnacksIndent",
					},
					chunk = {
						-- enabled = true,
						hl = "MySnacksIndent",
					},
				},
				statuscolumn = {
					left = { "mark", "git" }, -- priority of signs on the left (high to low)
					right = { "sign", "fold" }, -- priority of signs on the right (high to low)
					folds = {
						open = true, -- show open fold icons
						git_hl = false, -- use Git Signs hl for fold icons
					},
					git = {
						-- patterns to match Git signs
						patterns = { "GitSign", "MiniDiffSign" },
					},
					refresh = 50, -- refresh at most every 50ms
				},
				dashboard = {
					preset = {
						header = require("config.ascii").dos_rebel,
						keys = {
							{
								icon = " ",
								key = "f",
								desc = "Find File",
								action = ":lua Snacks.dashboard.pick('files')",
							},
							{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
							{
								icon = " ",
								key = "g",
								desc = "Find Text",
								action = ":lua Snacks.dashboard.pick('live_grep')",
							},
							{
								icon = " ",
								key = "r",
								desc = "Recent Files",
								action = ":lua Snacks.dashboard.pick('oldfiles')",
							},
							{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
							{ desc = string.format("󰅒 Started in %dms", startup_ms), align = "center" },
						},
					},
					sections = {
						{ section = "header" },
						{ section = "keys", gap = 1, padding = 1 },
						-- { section = "terminal", gap = 1, padding = 1, height = 15, cmd = "asciiquarium -t" }
					},
				},
			})
			-- NOTE: we aren't loading this lazily, and the keybinds already are so it is fine to just set these here
			vim.keymap.set("n", "<leader>e", function()
				Snacks.explorer.open()
			end, { desc = "Snacks file explorer" })
			vim.keymap.set({ "n", "t" }, "<c-/>", function()
				Snacks.terminal()
			end, { desc = "Snacks Terminal" })
		end,
	},
}
