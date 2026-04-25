local function gh(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("BirdeeHub/lze"),
	gh("BirdeeHub/lzextras"),
})

vim.pack.add({
	gh("nvim-lua/plenary.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("olimorris/onedarkpro.nvim"),
	gh("catppuccin/nvim"),
	gh("bluz71/vim-moonfly-colors"),
	gh("folke/noice.nvim"),
	gh("folke/lazydev.nvim"),
	gh("mrcjkb/haskell-tools.nvim"),
	gh("HiPhish/rainbow-delimiters.nvim"),
	gh("GustavEikaas/easy-dotnet.nvim"),
	gh("3rd/image.nvim"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("folke/snacks.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("saghen/blink.lib"),
	{ src = gh("saghen/blink.cmp"), version = "v1" },
	gh("saghen/blink.compat"),
	gh("hrsh7th/cmp-cmdline"),
	gh("xzbdmw/colorful-menu.nvim"),
	gh("nvim-lualine/lualine.nvim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("folke/which-key.nvim"),
	gh("mfussenegger/nvim-lint"),
	gh("stevearc/conform.nvim"),
	gh("RRethy/vim-illuminate"),
	gh("nvim-mini/mini.icons"),
	gh("folke/trouble.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("OXY2DEV/markview.nvim"),
	gh("willothy/moveline.nvim"),
	gh("folke/persistence.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("folke/flash.nvim"),
	gh("nvim-treesitter/nvim-treesitter-context"),
	gh("akinsho/bufferline.nvim"),
	gh("brenoprata10/nvim-highlight-colors"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/todo-comments.nvim"),
	gh("Bekaboo/dropbar.nvim"),
	gh("akinsho/git-conflict.nvim"),
	gh("mfussenegger/nvim-dap"),
	gh("igorlfs/nvim-dap-view"),
	gh("mrjones2014/smart-splits.nvim"),
	gh("mfussenegger/nvim-dap-python"),
	gh("selimacerbas/markdown-preview.nvim"),
	gh("selimacerbas/live-server.nvim"),
}, { load = function() end, confirm = false })

if vim.g.vscode == nil then
	require("config")
end
