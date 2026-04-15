local MP = ...

_G.lze = require("lze")
_G.lzextras = require("lzextras")

string.relpath = function(str, sub, n)
	local result = {}
	n = type(sub) == "string" and n or sub
	if type(n) == "number" and n > 0 then
		for match in (str .. "."):gmatch("(.-)%.") do
			table.insert(result, match)
		end
		while n > 0 do
			table.remove(result)
			n = n - 1
		end
	else
		table.insert(result, str)
	end
	if type(sub) == "string" then
		table.insert(result, sub)
	end
	return #result == 1 and result[1] or table.concat(result, ".")
end

vim.g.start_time = vim.fn.reltime()

vim.loader.enable() -- <- bytecode caching

vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0

vim.diagnostic.config({ virtual_text = true })

if not table.pack then
	---@diagnostic disable-next-line: duplicate-set-field
	table.pack = function(...)
		return { n = select("#", ...), ... }
	end
end

-- NOTE: These 2 should be set up before any plugins with keybinds are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: Best to keep these two at the top since they export the global Keymap and Autocmd/Augroup functions
require(MP:relpath("autocmds"))
require(MP:relpath("keymaps"))

require(MP:relpath("colorscheme"))
require(MP:relpath("highlights"))
require(MP:relpath("options"))
require(MP:relpath("commands"))
require(MP:relpath("lze-handlers"))

lze.load({ import = MP:relpath("plugins") })
