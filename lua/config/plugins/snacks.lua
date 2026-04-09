return {
	{
		"snacks.nvim",
		auto_enable = true,
		-- snacks makes a global, and then lazily loads itself
		lazy = false,
		-- priority only affects startup plugins
		-- unless otherwise specified by a particular handler
		priority = 1000,
		after = function(_)
			-- I (birdeehub) also like this color
			vim.api.nvim_set_hl(0, "MySnacksIndent", { fg = "#32a88f" })
			local startup_time = vim.fn.reltime(vim.g.start_time or vim.fn.reltime())
			local startup_ms = math.floor(vim.fn.reltimefloat(startup_time) * 1000)

			local function term_nav(dir)
				---@param self snacks.terminal
				return function(self)
					return self:is_floating() and "<c-" .. dir .. ">"
						or vim.schedule(function()
							vim.cmd.wincmd(dir)
						end)
				end
			end

			require("snacks").setup(
				---@class snacks.Config
				{
					explorer =
						---@class snacks.explorer.Config
						{
							replace_netrw = true,
							trash = false,
						},
					picker = {
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_down", mode = { "n", "i" } },
									["<S-Tab>"] = { "list_up", mode = { "n", "i" } },
									["V"] = { "select_and_prev", mode = { "n" } },
									["v"] = { "select_and_next", mode = { "n" } },
								},
							},
						},
						sources = {
							explorer = {
								auto_close = false,
								win = {
									list = {
										keys = {
											["<Esc>"] = false,
											["<Tab>"] = false,
											["<S-Tab>"] = false,
											["V"] = { "select_and_prev", mode = { "n" } },
											["v"] = { "select_and_next", mode = { "n" } },
										},
									},
								},
							},
						},
					},
					words = {
						enable = false,
					},
					git = {},
					terminal = {
						win = {
							keys = {
								nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
								nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
								nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
								nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
								hide = { "<C-/>", "hide", desc = "Hide Terminal", mode = "t" },
							},
						},
					},
					scope = {},
					bigfile = {},
					quickfile = {},
					indent = {
						scope = {
							hl = "MySnacksIndent",
						},
						chunk = {
							-- enabled = true,
							hl = "MySnacksIndent",
						},
					},
					input = {},
					scroll = {},
					toggle = {},
					statuscolumn = {
						left = { "mark", "sign" }, -- priority of signs on the left (high to low)
						right = { "fold", "git" }, -- priority of signs on the right (high to low)
						folds = {
							open = false, -- show open fold icons
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
								{
									icon = " ",
									key = "s",
									desc = "Restore Session",
									action = ":lua require('persistence').load()",
								},
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
				}
			)
			-- NOTE: we aren't loading this lazily, and the keybinds already are so it is fine to just set these here
			vim.keymap.set("n", "<leader>e", function()
				Snacks.explorer.open()
			end, { desc = "Snacks file explorer" })
			vim.keymap.set({ "n", "t" }, "<c-/>", function()
				Snacks.terminal()
			end, { desc = "Snacks Terminal" })

			-- 'Search' keymaps
			Keymap("n", "<leader>sk", Snacks.picker.keymaps)
			Keymap("n", "<leader>sc", Snacks.picker.colorschemes)
			Keymap("n", "<leader>si", Snacks.picker.icons)
			Keymap("n", "<leader>sa", Snacks.picker.autocmds)
			Keymap("n", "<leader>sh", Snacks.picker.highlights)

			Keymap("n", "<leader><leader>", function()
				Snacks.picker.grep()
			end)

			Keymap("n", "<leader>bd", function()
				Snacks.bufdelete()
			end)
		end,
	},
}
