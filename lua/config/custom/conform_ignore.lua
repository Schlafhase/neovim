local M = {}

local conform = require("conform")

-- ignoring ranges is incredibly broken and basically useless

-- local function get_ignore_ranges(bufnr)
-- 	local ignore_ranges = {}
-- 	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
-- 	if not ok or not parser then
-- 		return ignore_ranges
-- 	end
--
-- 	local tree = parser:parse()[1]
-- 	if not tree then
-- 		return ignore_ranges
-- 	end
--
-- 	local root = tree:root()
-- 	local lang = parser:lang()
--
-- 	local comment_query_str = "(comment) @comment"
-- 	local ok_q, query = pcall(vim.treesitter.query.parse, lang, comment_query_str)
-- 	if not ok_q then
-- 		return ignore_ranges
-- 	end
--
-- 	for _, node in query:iter_captures(root, bufnr, 0, -1) do
-- 		local text = vim.treesitter.get_node_text(node, bufnr)
-- 		if text and text:match("%s*conform%-ignore%s*") then
-- 			local start_row, _, end_row, _ = node:range()
-- 			table.insert(ignore_ranges, { start_row, end_row + 1 })
-- 		end
-- 	end
--
-- 	return ignore_ranges
-- end
--
-- function M.conform_format_ignorable(bufnr)
-- 	bufnr = bufnr or 0
-- 	local ignore_ranges = get_ignore_ranges(bufnr)
-- 	local line_count = vim.api.nvim_buf_line_count(bufnr)
--
-- 	if #ignore_ranges == 0 then
-- 		conform.format({ bufnr = bufnr })
-- 		return
-- 	end
--
-- 	local format_ranges = {}
-- 	local prev_end = 0
-- 	for _, range in ipairs(ignore_ranges) do
-- 		local ignore_start, ignore_end = range[1], range[2]
-- 		if ignore_start > prev_end + 1 then
-- 			table.insert(format_ranges, { prev_end, ignore_start - 1 })
-- 		end
-- 		prev_end = ignore_end
-- 	end
--
-- 	if prev_end < line_count then
-- 		table.insert(format_ranges, { prev_end, line_count - 1 })
-- 	end
-- 	vim.notify(vim.inspect(format_ranges))
--
-- 	for _, r in ipairs(format_ranges) do
-- 		conform.format({
-- 			bufnr = bufnr,
-- 			range = {
-- 				start = { r[1] + 1, 0 },
-- 				["end"] = { r[2] + 1, 0 },
-- 			},
-- 		})
-- 	end
-- end

local function conform_should_format(bufnr)
	local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
	if not ok or not parser then
		return true
	end

	local tree = parser:parse()[1]
	if not tree then
		return true
	end

	-- conform-ignore
	local root = tree:root()
	local lang = parser:lang()

	local comment_query_str = "(comment) @comment"
	local ok_q, query = pcall(vim.treesitter.query.parse, lang, comment_query_str)
	if not ok_q then
		return true
	end

	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		local text = vim.treesitter.get_node_text(node, bufnr)
		if text and text:match("%s*{conform%-ignore}%s*") then
			-- if any conform-ignore comment exists: don't format
			return false
		end
	end

	return true
end

function M.conform_format_ignorable(bufnr)
	if conform_should_format(bufnr) then
		conform.format({ bufnr = bufnr, async = true }, function()
			vim.cmd("noautocmd w")
		end)
	end
end

return M
