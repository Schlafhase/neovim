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
		-- after = function()
		-- 	vim.g.moonflyCursorColor = true
		-- 	Autocmd("ColorScheme", {
		-- 		pattern = "moonfly",
		-- 		callback = function()
		-- 			local palette = require("moonfly").palette
		-- 			vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = palette.green })
		-- 			vim.api.nvim_set_hl(0, "GitSignsChange", { fg = palette.yellow })
		-- 			vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = palette.red })
		-- 		end,
		-- 	})
		-- end,
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
