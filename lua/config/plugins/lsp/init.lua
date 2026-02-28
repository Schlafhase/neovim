local MP = ...

return {
	{ import = MP:relpath("lspconfig") },
	{ import = MP:relpath("dotnet") },
	{ import = MP:relpath("go") },
	{ import = MP:relpath("haskell") },
	{ import = MP:relpath("lua") },
	{ import = MP:relpath("nix") },
}
