Augroup = function(name)
	vim.api.nvim_create_augroup(name, { clear = true })
end

Autocmd = vim.api.nvim_create_autocmd

local highlight_group = Augroup("YankHighlight")
Autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
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

local last_root = vim.fn.getcwd()

Autocmd({ "BufEnter", "LspAttach" }, {
	group = Augroup("root-changed-detect"),
	callback = function()
		vim.schedule(function()
			local root = require("config.util.path").get_root()
			if root ~= last_root then
				last_root = root
				vim.api.nvim_exec_autocmds("User", {
					pattern = "RootChanged",
					data = { root = root },
				})
			end
		end)
	end,
})

Autocmd("User", {
	pattern = "RootChanged",
	group = Augroup("change-to-root-dir"),
	callback = function(ev)
		vim.cmd.cd(ev.data.root)
	end,
})
