return {
	{
		"musubi-lsp",
		load = function()
			vim.filetype.add({
				extension = {
					mbi = "musubi",
					mbim = "musubi-module",
				},
			})

			vim.lsp.config("musubi-lsp", {
				cmd = {
					"dotnet",
					"/home/Linus/Projects/cs/Musubi/Musubi.Lsp/bin/Release/net10.0/publish/Musubi.Lsp.dll",
				},
				filetypes = { "musubi", "musubi-module"},
				root_markers = { ".git", "*.sln" },
			})
			vim.lsp.enable("musubi-lsp")
		end,
	},
}
