return {
	{
		"conform.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("conform").setup({
				format_after_save = function()
					local conform_ignore = require("config.custom.conform_ignore")
					conform_ignore.conform_format_ignorable(0)
				end,
				formatters = {
					injected = {
						ignore_erros = true,
					},
					mdformat = {
						command = "mdformat",
						append_args = { "--wrap", "75" },
					},
					prettiermd = {
						command = "prettier",
						args = {
							"--print-width",
							"80",
							"--prose-wrap",
							"always",
							"--stdin-filepath",
							"$FILENAME",
						},
					},
					prettierhtml = {
						command = "prettier",
						args = {
							"--parser",
							"html",
						},
					},
				},
				formatters_by_ft = {
					lua = { "stylua", "injected" },
					cs = { "csharpier", "injected" },
					nix = { "alejandra" },
					markdown = { "prettiermd", "injected" },
					html = { lsp_format = "first" },
					xml = { "prettierhtml" },
					javascript = { lsp_format = "first" },
					python = { "black" },
					go = { lsp_format = "first" },
					typescriptreact = { "prettier" },
					css = { "prettier" },
				},
			})
		end,
	},
}
