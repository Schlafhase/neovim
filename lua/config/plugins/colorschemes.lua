return {
	{
		"onedarkpro.nvim",
		auto_enable = true,
		colorscheme = { "onedark", "onedark_dark", "onedark_vivid", "onelight" },
	},
	{
		"vim-moonfly-colors",
		auto_enable = true,
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
		auto_enable = true,
		colorscheme = {
			"catppuccin",
			"catppuccin-latte",
			"catppuccin-frappe",
			"catppuccin-machiato",
			"catppuccin-mocha",
		},
	},
}
