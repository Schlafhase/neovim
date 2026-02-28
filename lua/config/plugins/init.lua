local MP = ...

return {
	{ import = MP:relpath("lsp") },
	{ import = MP:relpath("noice") },
	{ import = MP:relpath("colorschemes") },
	{ import = MP:relpath("snacks") },
	{ import = MP:relpath("treesitter") },
	{ import = MP:relpath("which_key") },
	{ import = MP:relpath("blink") },
	{ import = MP:relpath("cmp-cmdline") },
	{ import = MP:relpath("conform") },
	-- { import = MP:relpath("fidget") },
	{ import = MP:relpath("gitsigns") },
	{ import = MP:relpath("lualine") },
	{ import = MP:relpath("mason") },
	{ import = MP:relpath("nvim-lint") },
	{ import = MP:relpath("nvim-surround") },
	{ import = MP:relpath("startup-time") },
	{ import = MP:relpath("mini") },
	{ import = MP:relpath("trouble") },
	{ import = MP:relpath("telescope") },
	{ import = MP:relpath("nvim-notify") },
}
