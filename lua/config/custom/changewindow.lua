local M = {}

---@param dir string
function M.changeWindow(dir)
	local moved

	if dir:find("explorer") then
		dir = dir:sub(1, 1)
		moved = false
	else
		local cur = vim.api.nvim_get_current_win()
		vim.cmd.wincmd(dir)
		moved = vim.api.nvim_get_current_win() ~= cur
	end

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

	pcall(function()
		vim.system({ "hyprctl", "dispatch", "hl.dsp.focus({direction='" .. direction .. "'})" })
	end)
end

return M
