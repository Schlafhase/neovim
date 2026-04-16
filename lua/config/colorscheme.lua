Autocmd("VimEnter", {
	group = Augroup("Colorscheme"),
	callback = function()
		vim.cmd.packadd("vim-moonfly-colors")
		vim.cmd.colorscheme("moonfly")
	end,
})
