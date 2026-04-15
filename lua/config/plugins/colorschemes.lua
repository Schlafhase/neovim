return {
	{
		"onedarkpro.nvim",
		colorscheme = { "onedark", "onedark_dark", "onedark_vivid", "onelight" },
	},
	{
		"vim-moonfly-colors",
		colorscheme = "moonfly",
		after = function()
			Autocmd("ColorScheme", {
				pattern = "moonfly",
				callback = function()
					local palette = require("moonfly").palette
					vim.api.nvim_set_hl(0, "NotifyBackground", { bg = palette.bg })

					vim.api.nvim_set_hl(0, "BreakpointIcon", { fg = palette.red })
					vim.api.nvim_set_hl(0, "BreakpointConditionIcon", { fg = palette.yellow })
					vim.api.nvim_set_hl(0, "BreakpointRejectedIcon", { fg = palette.grey1, strikethrough = true })

					vim.api.nvim_set_hl(0, "BreakpointLine", { bg = palette.grey11 })
					vim.api.nvim_set_hl(0, "BreakpointNumber", { fg = palette.red })
				end,
			})
		end,
	},
	{
		"catppuccin-nvim",
		colorscheme = {
			"catppuccin",
			"catppuccin-latte",
			"catppuccin-frappe",
			"catppuccin-machiato",
			"catppuccin-mocha",
		},
	},
}
