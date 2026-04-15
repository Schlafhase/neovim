return {
	{
		"conform.nvim",
		event = "BufReadPre",
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
				},
				formatters_by_ft = {
					lua = { "stylua" },
					cs = { "csharpier" },
					nix = { "alejandra" },
					markdown = { "prettier" },
					javascript = { "prettier" },
				},
			})
		end,
	},
}
