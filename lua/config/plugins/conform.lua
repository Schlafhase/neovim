return {
	{
		"conform.nvim",
		for_cat = "general",
		auto_enable = true,
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
					lua = nixInfo(nil, "settings", "cats", "lua") and { "stylua" } or nil,
					cs = { "csharpier" },
					nix = { "alejandra" },
					markdown = { "prettier" },
					javascript = { "prettier" },
				},
			})
		end,
	},
}
