Augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

Autocmd = vim.api.nvim_create_autocmd

local highlight_group = Augroup("YankHighlight")
Autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local lsp_progress_group = Augroup("LspRedraw")
Autocmd("LspProgress", {
	group = lsp_progress_group,
	pattern = "*",
	callback = function()
		vim.cmd("redrawstatus")
	end,
})

Autocmd("BufReadPost", {
	group = Augroup("CursorRestore"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
