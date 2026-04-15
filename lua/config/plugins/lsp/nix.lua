return {
	{
		"nixd",
		lsp = {
			filetypes = { "nix" },
			settings = {
				nixd = {
					nixpkgs = {
						expr = [[import <nixpkgs> {}]],
					},
					options = {},
					formatting = {
						command = { "alejandra" },
					},
					diagnostic = {
						suppress = {
							"sema-escaping-with",
						},
					},
				},
			},
		},
	},
}
