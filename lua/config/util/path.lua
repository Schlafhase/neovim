local M = {}

local root_cache = {}

-- local highlight = require("lualine.highlight")

function M.lsp_root(buf)
	local clients = vim.lsp.get_clients({ bufnr = buf })
	for _, client in ipairs(clients) do
		if client.name ~= "copilot" then
			local root = client.config.root_dir
			if root and root ~= "" then
				return root
			end
		end
	end
end

local function pattern_root(buf, patterns)
	local path = vim.api.nvim_buf_get_name(buf)
	if path == "" then
		return
	end
	path = vim.fn.fnamemodify(path, ":p:h")
	for _, pat in ipairs(patterns) do
		for dir in vim.fs.parents(path) do
			if vim.fn.isdirectory(dir .. "/" .. pat) == 1 or vim.fn.filereadable(dir .. "/" .. pat) == 1 then
				return dir
			end
		end
	end
end

function M.get_root()
	local buf = vim.api.nvim_get_current_buf()
	if root_cache[buf] then
		return root_cache[buf]
	end

	local root = M.lsp_root(buf) or pattern_root(buf, { ".git", ".sln", ".csproj", ".fsproj" }) or vim.uv.cwd()

	root = vim.fn.fnamemodify(root, ":p"):gsub("/$", "")
	root_cache[buf] = root

	Autocmd({ "LspAttach", "LspDetach", "BufWritePost" }, {
		group = Augroup("LspInvalidateRootCache"),
		buffer = buf,
		once = false,
		callback = function()
			root_cache[buf] = nil
		end,
	})

	return root
end

function M.lualine_root_dir(opts)
	opts = vim.tbl_extend("force", {
		cwd = true,
		icon = "󱉭 ",
		color = "Special",
	}, opts or {})

	return {
		function()
			local root = M.get_root()
			local cwd = vim.fn.fnamemodify(vim.uv.cwd() or "", ":p"):gsub("/$", "")
			if not opts.cwd and root == cwd then
				return ""
			end
			return opts.icon .. vim.fn.fnamemodify(root, ":t")
		end,
		color = { fg = Snacks.util.color(opts.color) or "#7aa2f7" },
		cond = function()
			local root = M.get_root()
			local cwd = vim.fn.fnamemodify(vim.uv.cwd() or "", ":p"):gsub("/$", "")
			return opts.cwd or root ~= cwd
		end,
		padding = { left = 1, right = 0 },
		separator = "",
	}
end

local function format_hl(self, text, hl_group)
	if not hl_group or hl_group == "" then
		return text
	end

	self.hl_cache = self.hl_cache or {}
	local lualine_hl = self.hl_cache[hl_group]

	if not lualine_hl then
		local utils = require("lualine.utils.utils")

		local gui_parts = {}
		if utils.extract_highlight_colors(hl_group, "bold") then
			table.insert(gui_parts, "bold")
		end
		if utils.extract_highlight_colors(hl_group, "italic") then
			table.insert(gui_parts, "italic")
		end

		lualine_hl = self:create_hl({
			fg = utils.extract_highlight_colors(hl_group, "fg"),
			gui = table.concat(gui_parts, ","),
		}, "LV_" .. hl_group)

		self.hl_cache[hl_group] = lualine_hl
	end

	return self:format_hl(lualine_hl) .. text .. self:get_default_hl()
end

function M.lualine_pretty_path(opts)
	-- PERF: only works with moonfly at the moment
	opts = vim.tbl_extend("force", {
		relative = "root",
		modified_hl = "MoonflyOrange",
		dir_hl = "MoonflyGrey70",
		file_hl = "MoonflyGrey89",
	}, opts or {})

	return function(self)
		local path = vim.api.nvim_buf_get_name(0)
		if path == "" then
			return ""
		end
		path = vim.fn.fnamemodify(path, ":p")

		local base
		if opts.relative == "root" then
			base = M.get_root()
		else
			base = vim.fn.fnamemodify(vim.uv.cwd() or "", ":p"):gsub("/$", "")
		end

		if path:find(base, 1, true) == 1 then
			path = path:sub(#base + 2)
		else
			path = vim.fn.fnamemodify(path, ":~")
		end

		local filename = vim.fn.fnamemodify(path, ":t")
		local dirs = vim.fn.fnamemodify(path, ":h")

		if dirs ~= "." then
			local parts = vim.split(dirs, "/")
			if #parts > 2 then
				parts = { parts[1], parts[#parts] }
				table.insert(parts, 2, "…")
			end
			dirs = table.concat(parts, "/")
		else
			dirs = ""
		end

		local modified = vim.bo.modified
		local file_hl = modified and opts.modified_hl or opts.file_hl

		local result = ""
		if dirs ~= "" then
			result = format_hl(self, dirs .. "/", opts.dir_hl) .. format_hl(self, filename, file_hl)
		else
			result = format_hl(self, filename, file_hl)
		end

		return result
	end
end

return M
