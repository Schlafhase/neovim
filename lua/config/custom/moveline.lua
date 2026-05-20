---@diagnostic disable: param-type-mismatch
local M = {}

function M.move(pos)
	pcall(vim.cmd, "m " .. pos .. "<CR>==")
end

function M.move_block(pos)
	local start_line = vim.fn.getpos("v")[2]
	local end_line = vim.fn.getpos(".")[2]
	if start_line > end_line then
		start_line, end_line = end_line, start_line
	end

	vim.fn.setpos("'<", { 0, start_line, 1, 0 })
	vim.fn.setpos("'>", { 0, end_line, 1, 0 })
	pcall(vim.cmd, "silent '<,'>m " .. pos)
	vim.cmd("silent! normal! gv=gv")
end

return M
