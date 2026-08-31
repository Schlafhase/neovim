local M = {}

local normalIM = "keyboard-gb"
local insertIM = "unixkey"
M.changeIM = function(name)
	local success = pcall(vim.fn.system, "fcitx5-remote -s " .. name)
	if not success then
		vim.notify("Failed to set fcitx5 input method. Is fcitx5-remote installed?")
	end
end

local locked = false
local updateScheduled = false
local useCorrectIM = function()
	local mode = vim.api.nvim_get_mode().mode
	if mode == "i" or mode == "c" or mode == "t" then
		M.changeIM(insertIM)
	else
		M.changeIM(normalIM)
	end
end

M.useCorrectIM = function()
	if locked then
		if updateScheduled then
			updateScheduled = true
			vim.schedule(function()
				useCorrectIM()
				updateScheduled = false
			end)
		end
		return
	end

	useCorrectIM()
	locked = true
	vim.schedule(function()
		locked = false
	end)
end

M.forceUseCorrectIM = useCorrectIM

return M
