return {
	{
		"blink.lib",
		dep_of = { "blink.cmp" },
	},
	{
		"blink.compat",
		dep_of = { "cmp-cmdline" },
	},
	{
		"colorful-menu.nvim",
		on_plugin = { "blink.cmp" },
	},
	{
		"blink.cmp",
		dep_of = { "nvim-lspconfig" },
		after = function(_)
			require("blink.cmp").setup({
				keymap = {
					preset = "none",
					-- ["<C-y>"] = { "select_and_accept" },
					["<Tab>"] = { "select_next", "fallback" },
					["<S-Tab>"] = { "select_prev", "fallback" },
					["<CR>"] = { "select_and_accept", "fallback" },
					["<C-Space>"] = { "show", "hide" },
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
					prebuilt_binaries = { force_version = "v1.9.1" },
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
					list = {
						selection = {
							auto_insert = false,
						},
					},
					ghost_text = {
						enabled = true,
					},
					menu = {
						draw = {
							treesitter = { "lsp" },
							columns = {
								{ "label", "label_description", gap = 1 },
								{ "kind_icon", "kind", gap = 1 },
							},
							components = {
								label = {
									text = function(ctx)
										return require("colorful-menu").blink_components_text(ctx)
									end,
									highlight = function(ctx)
										return require("colorful-menu").blink_components_highlight(ctx)
									end,
								},
								label_description = {
									highlight = "CustomBlinkLabelDescription",
								},
							},
						},
					},
					documentation = {
						auto_show = true,
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "omni" },
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
				snippets = {
					preset = "luasnip",
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
