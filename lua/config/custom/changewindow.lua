local M = {}

function M.changeWindow(dir)
	local cur = vim.api.nvim_get_current_win()
	vim.cmd.wincmd(dir)
	local moved = vim.api.nvim_get_current_win() ~= cur

	if moved then
		return
	end

	local direction

	if dir == "h" then
		direction = "l"
	end
	if dir == "j" then
		direction = "d"
	end
	if dir == "k" then
		direction = "u"
	end
	if dir == "l" then
		direction = "r"
	end

	vim.system({ "hyprctl", "dispatch", "hl.dsp.focus({direction='" .. direction .. "'})" })
end

return M
