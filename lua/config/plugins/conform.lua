return {
	{
		"conform.nvim",
		event = "DeferredUIEnter",
		after = function()
			require("conform").setup({
				format_after_save = {
					timeout_ms = 500,
					lsp_format = "fallback",
					async = true,
				},
				formatters = {
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
				},
				formatters_by_ft = {
					lua = { "stylua" },
					cs = { "csharpier" },
					nix = { "alejandra" },
					markdown = { "prettiermd" },
					javascript = { "prettier" },
					python = { "black" },
				},
			})
		end,
	},
}
