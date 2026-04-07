return {
	{
		"blink.compat",
		auto_enable = true,
		dep_of = { "cmp-cmdline" },
	},
	{
		"colorful-menu.nvim",
		auto_enable = true,
		on_plugin = { "blink.cmp" },
	},
	{
		"blink.cmp",
		auto_enable = true,
		event = { "InsertEnter", "CmdlineEnter" },
		after = function(_)
			require("blink.cmp").setup({
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- See :h blink-cmp-config-keymap for configuring keymaps
				keymap = {
					preset = "none",
					-- ["<C-y>"] = { "select_and_accept" },
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<CR>"] = { "select_and_accept", "fallback" },
				},
				cmdline = {
					enabled = true,
					keymap = {
						preset = "cmdline",
						["<Right>"] = false,
						["<Left>"] = false,
					},
					completion = {
						list = { selection = { preselect = false } },
						menu = {
							auto_show = true,
						},
					},
					sources = function()
						local type = vim.fn.getcmdtype()
						-- Search forward and backward
						if type == "/" or type == "?" then
							return { "buffer" }
						end
						-- Commands
						if type == ":" or type == "@" then
							return { "cmdline", "cmp_cmdline" }
						end
						return {}
					end,
				},
				fuzzy = {
					sorts = {
						"exact",
						-- defaults
						"score",
						"sort_text",
					},
				},
				signature = {
					enabled = true,
					window = {
						show_documentation = true,
					},
				},
				completion = {
					accept = {
						auto_brackets = { enabled = true },
					},
					menu = {
						draw = {
							treesitter = { "lsp" },
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
							},
						},
					},
					documentation = {
						auto_show = true,
					},
				},
				sources = {
					default = { "lsp", "path", "buffer", "omni" },
					providers = {
						path = {
							score_offset = 50,
						},
						lsp = {
							score_offset = 40,
						},
						cmp_cmdline = {
							name = "cmp_cmdline",
							module = "blink.compat.source",
							score_offset = -100,
							opts = {
								cmp_name = "cmdline",
							},
						},
					},
				},
			})
			Autocmd("CmdlineLeave", {
				group = Augroup("CloseCompletions"),
				callback = function()
					pcall(require("blink.cmp").hide)
				end,
			})
		end,
	},
}
