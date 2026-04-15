-- local function gh(x)
-- 	return "https://github.com/" .. x
-- end
--
-- vim.pack.add({
-- 	"BirdeeHub/lze",
-- 	"BirdeeHub/lzextras",
-- })
--
-- vim.pack.add({
-- 	gh("olimorris/onedarkpro.nvim"),
-- 	gh("catpuccin/nvim"),
-- 	gh("bluz71/vim-moonfly-colors"),
-- 	gh("folke/noice.nvim"),
-- 	gh("folke/lazydev.nvim"),
-- 	gh("mrcjkb/haskell-tools.nvim"),
-- 	gh("HiPhish/rainbow-delimiters.nvim"),
-- 	gh("GustavEikaas/easy-dotnet.nvim"),
-- 	gh("3rd/image.nvim"),
-- 	gh("nvim-treesitter/nvim-treesitter"),
-- 	gh("folke/snacks.nvim"),
-- 	gh("neovim/nvim-lspconfig"),
-- 	gh("kylechui/nvim-surround"),
-- 	gh("saghen/blink.cmp"),
-- 	gh("saghen/blink.compat"),
-- 	gh("hrsh7th/cmp-cmdline"),
-- }, { load = function() end })

if vim.g.vscode == nil then
	require("config")
end
