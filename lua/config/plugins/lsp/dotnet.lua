return {
	{
		"easy-dotnet.nvim",
		ft = { "cs", "fs", "vb", "sln", "csproj", "fsproj" },
		setup = {
			lsp = {
				config = {
					settings = {
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = false,
						},
					},
				},
			},
		},
	},
	{
		"Ionide-vim",
		ft = { "fsharp", "fs", "fsproj", "fsharp_project" },
		setup = {},
	},
}
