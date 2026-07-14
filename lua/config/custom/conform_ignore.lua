local M = {}

local conform = require("conform")

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
		conform.format({ bufnr = bufnr, async = false })
	end
end

return M
