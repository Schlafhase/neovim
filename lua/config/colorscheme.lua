Autocmd("VimEnter", {
	group = Augroup("Colorscheme"),
	callback = function()
		vim.schedule(function()
			vim.cmd.packadd("vim-moonfly-colors")
			vim.cmd.colorscheme("moonfly")
		end)
	end,
})
