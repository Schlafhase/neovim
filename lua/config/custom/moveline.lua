local M = {}

function M.move_up()
	M.move("up")
end

function M.move_down()
	M.move("down")
end

---@param line string
local function get_actual_indent(line)
	local indent = line:match("^[ \t]*") or ""
	return {
		---@type string
		text = indent,
		---@type integer
		length = #indent,
		---@type integer
		spaces = select(2, indent:gsub(" ", "")),
		---@type integer
		tabs = select(2, indent:gsub("\t", "")),
	}
end

local function get_indent_style()
	local expandtab = vim.bo.expandtab
	local shiftwidth = vim.bo.shiftwidth
	local tabstop = vim.bo.tabstop

	return {
		use_spaces = expandtab,
		shiftwidth = shiftwidth,
		tabstop = tabstop,
	}
end

local function get_expected_indent(lnum)
	vim.v.lnum = lnum
	---@type integer
	local width = vim.fn.eval(vim.bo.indentexpr)
	local style = get_indent_style()

	if style.use_spaces then
		return string.rep(" ", width)
	else
		return string.rep("\t", width / style.tabstop)
	end
end

function M.move(dir)
	local lineno, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), lineno - 1, lineno, false)
	local line2no

	if (dir == "up") and lineno > 0 then
		line2no = lineno - 1
	elseif (dir == "down") and lineno < vim.api.nvim_buf_line_count(0) then
		line2no = lineno + 1
	end

	local line2 = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), line2no - 1, line2no, false)
	vim.api.nvim_buf_set_lines(0, lineno - 1, lineno, false, line2)
	vim.api.nvim_buf_set_lines(0, line2no - 1, line2no, false, line)

	local currentIndent = get_actual_indent(line[1])
	local expectedIndent = get_expected_indent(line2no)

	line = { expectedIndent .. line[1]:sub(currentIndent.length + 1, #line[1]) }
	local diff = #expectedIndent - currentIndent.length
	vim.api.nvim_win_set_cursor(0, { line2no, math.max(0, col + diff) })
	vim.api.nvim_buf_set_lines(0, line2no - 1, line2no, false, line)
end

return M
