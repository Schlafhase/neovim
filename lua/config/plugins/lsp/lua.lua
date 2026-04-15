return {
	{
		-- lazydev makes your lua lsp load only the relevant definitions for a file.
		-- It also gives us a nice way to correlate globals we create with files.
		"lazydev.nvim",
		cmd = { "LazyDev" },
		enabled = false,
		ft = "lua",
		after = function(_)
			require("lazydev").setup({
				library = {
					-- { words = { "nixInfo%.lze" }, path = nixInfo("lze", "plugins", "start", "lze") .. "/lua" },
					-- {
					-- 	words = { "nixInfo%.lze" },
					-- 	path = nixInfo("lzextras", "plugins", "start", "lzextras") .. "/lua",
					-- },
				},
			})
		end,
	},
	{
		-- name of the lsp
		"lua_ls",
		-- provide a table containing filetypes,
		-- and then whatever your functions defined in the function type specs expect.
		-- in our case, it just expects the normal lspconfig setup options,
		-- but with a default on_attach and capabilities
		lsp = {
			-- if you provide the filetypes it doesn't ask lspconfig for the filetypes
			-- (meaning it doesn't call the callback function we defined in the main init.lua)
			filetypes = { "lua" },
			settings = {
				Lua = {
					signatureHelp = { enabled = true },
					diagnostics = {
						globals = { "lze", "lzextras", "vim" },
						disable = { "missing-fields" },
					},
					codeLens = {
						enable = true,
					},
					completion = {
						callSnippet = "Replace",
					},
					doc = {
						privateName = { "^_" },
					},
					hint = {
						enable = true,
						setType = false,
						paramType = true,
						semicolon = "Disable",
					},
				},
			},
		},
	},
}
