Autocmd("FileType", {
	group = Augroup("CssFixComments"),
	pattern = { ".css" },
	callback = function()
		vim.bo.comments = ""
	end,
})

return {
	{
		"cssls",
		lsp = {},
	},
	{
		"eslint",
		lsp = {},
	},
	{
		"html",
		lsp = {},
	},
}
