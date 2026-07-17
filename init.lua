local function gh(x)
	return "https://github.com/" .. x
end

vim.pack.add({
	gh("BirdeeHub/lze"),
	gh("BirdeeHub/lzextras"),
})

local active_plugins = {
	lze = true,
	lzextras = true,
}

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
	gh("nvim-mini/mini.surround"),
	gh("folke/trouble.nvim"),
	gh("nvim-telescope/telescope.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("OXY2DEV/markview.nvim"),
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
	{ src = gh("JavaHello/spring-boot.nvim"), version = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0" },
	gh("nvim-java/nvim-java"),
	gh("lewis6991/async.nvim"),
	gh("ThePrimeagen/refactoring.nvim"),
	gh("jmbuhr/otter.nvim"),
	gh("wakatime/vim-wakatime"),
	gh("windwp/nvim-ts-autotag"),
	gh("L3MON4D3/LuaSnip"),
	gh("soifou/blink_luasnip"),
	gh("ionide/Ionide-vim"),
	gh("onsails/lspkind.nvim"),
	gh("johnseth97/codex.nvim"),
  gh("fei6409/log-highlight.nvim")
}, {
	load = function(p)
		active_plugins[p.spec.name] = true
	end,
	confirm = false,
})
-- Loading is handled by lze

vim.pack.remove_inactive = function()
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		return
	end

	vim.notify("Unused plugins: " .. vim.inspect(unused_plugins))
	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

if vim.g.vscode == nil then
	require("config")
end
