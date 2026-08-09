local M = {}

local normalIM = "keyboard-gb"
local insertIM = "unixkey"
M.changeIM = function(name)
	local success = pcall(vim.fn.system, "fcitx5-remote -s " .. name)
	if not success then
		vim.notify("Failed to set fcitx5 input method. Is fcitx5-remote installed?")
	end
end
M.useCorrectIM = function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" or mode == "c" or mode == "t" then
		M.changeIM(insertIM)
	else
		M.changeIM(normalIM)
	end
end

return M
