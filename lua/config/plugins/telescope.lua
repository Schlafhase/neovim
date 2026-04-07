return {
	{
		"telescope.nvim",
		after = function()
			require("telescope").setup({})

			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local make_entry = require("telescope.make_entry")
			local conf = require("telescope.config").values
			local actions = require("telescope.actions")

			-- custom picker based on telescope.builtin.buffers but includes files in cwd as well
			local buffers_and_files = function(opts)
				local bufnrs = vim.tbl_filter(function(bufnr)
					if 1 ~= vim.fn.buflisted(bufnr) then
						return false
					end
					-- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
					if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(bufnr) then
						return false
					end
					if opts.ignore_current_buffer and bufnr == vim.api.nvim_get_current_buf() then
						return false
					end

					return true
				end, vim.api.nvim_list_bufs())

				local buffers_and_files = {}
				local default_selection_idx = 1
				local open_buffers = {}

				if not next(bufnrs) then
					goto files
				end

				if opts.sort_mru then
					table.sort(bufnrs, function(a, b)
						return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
					end)
				end

				for i, bufnr in ipairs(bufnrs) do
					local flag = bufnr == vim.fn.bufnr("") and "%" or (bufnr == vim.fn.bufnr("#") and "#" or " ")

					if opts.sort_lastused and not opts.ignore_current_buffer and flag == "#" then
						default_selection_idx = 2
					end

					local element = {
						type = "buffer",
						value = {
							bufnr = bufnr,
							flag = flag,
							info = vim.fn.getbufinfo(bufnr)[1],
						},
					}

					local bufname = vim.api.nvim_buf_get_name(bufnr)

					if opts.sort_lastused and (flag == "#" or flag == "%") then
						local idx = ((buffers_and_files[1] ~= nil and buffers_and_files[1].flag == "%") and 2 or 1)
						table.insert(buffers_and_files, idx, element)
						open_buffers[bufname] = true
					else
						if opts.select_current and flag == "%" then
							default_selection_idx = i
						end
						table.insert(buffers_and_files, element)
						open_buffers[bufname] = true
					end
				end

				if not opts.bufnr_width then
					local max_bufnr = math.max(unpack(bufnrs))
					opts.bufnr_width = #tostring(max_bufnr)
				end

				::files::

				local cwd = vim.fn.getcwd()
				local files = vim.fn.systemlist('bash -c "find ' .. cwd .. " -type f -not -path '*/.*/*'; true\"")
				for _, f in ipairs(files) do
					if not open_buffers[f] then
						local element = {
							type = "file",
							value = f,
						}
						table.insert(buffers_and_files, element)
					end
				end

				local buffer_entry_maker = make_entry.gen_from_buffer(opts)
				local file_entry_maker = make_entry.gen_from_file(opts)

				local function gen_entry(result)
					if result.type == "buffer" then
						return buffer_entry_maker(result.value)
					else
						return file_entry_maker(result.value)
					end
				end

				pickers
					.new(opts, {
						prompt_title = "Buffers and Files",
						finder = finders.new_table({
							results = buffers_and_files,
							entry_maker = gen_entry,
						}),
						previewer = conf.grep_previewer(opts),
						sorter = conf.generic_sorter(opts),
						default_selection_index = default_selection_idx,
						attach_mappings = function(_, map)
							map({ "i", "n" }, "<M-d>", actions.delete_buffer)
							return true
						end,
					})
					:find()
			end

			Keymap("n", "<S-TAB>", function()
				buffers_and_files({ sort_mru = true, sort_lastused = true })
			end)
		end,
	},
}
