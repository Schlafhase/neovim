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
					markdown = { "mdformat" },
					-- go = { "gofmt", "golint" },
					-- templ = { "templ" },
					-- Conform will run multiple formatters sequentially
					-- python = { "isort", "black" },
					-- Use a sub-list to run only the first available formatter
					-- javascript = { { "prettierd", "prettier" } },
				},
			})
		end,
	},
}
