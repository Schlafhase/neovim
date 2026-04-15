Autocmd("VimEnter", {
	group = Augroup("Colorscheme"),
	callback = function()
		vim.cmd.colorscheme("moonfly")
	end,
})
