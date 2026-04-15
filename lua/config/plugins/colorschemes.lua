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
